//
//  AsyncImageView.swift
//  AsyncCachedImage
//
//  Created by Nati on 08/08/2024.
//

import Foundation
import SwiftUI

public struct AsyncImageView<ImageView: View, PlaceholderView: View>: View {
    
    let cache: CacheProtocol
    let url: URL?
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    @State private var image: Image? = nil
    @State private var loading = true
    
    public init(
        cache: CacheProtocol? = nil,
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView = { $0 } ,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView = { Image(systemName: "photo").resizable() }
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
        self.cache = cache ?? ImageCache.shared
    }
    
    @MainActor
    public var body: some View {
        VStack {
            if let image {
                content(image)
            } else {
                placeholder()
                    .overlay {
                        if loading{
                            ProgressView()
                        }
                    }
                    .onAppear {
                        Task {
                            do{
                                image = try await getImage()
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
            }
        }
    }
}

private extension AsyncImageView{
    
    func getImage() async throws -> Image? {
        defer{
            loading = false
        }
        guard let url else { return nil }
        
        if let cached = await cache.retrieve(forKey: url) {
            return try decode(from: cached, for: url)
        } else {
            var request = URLRequest(url: url)
            if let header = AsyncImageConfiguration.shared.header{
                request.addValue(header.value, forHTTPHeaderField: header.key)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
            }
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let image = try decode(from: data, for: url)
            await cache.insert(data, forKey: url)
            return image
        }
    }
    
    func decode(from data: Data, for url: URL) throws -> Image {
        if let uiImage = UIImage(data: data)?.preparingForDisplay() {
            return Image(uiImage: uiImage)
        }
        throw DecodingData.decodingFail(url: url)
    }
    
    enum DecodingData: LocalizedError{
        case decodingFail(url: URL)
        
        var errorDescription: String?{
            switch self {
            case .decodingFail(let url):
                return "could'nt decode image from url \(url), make sure it's a vailed image"
            }
        }
    }

}
