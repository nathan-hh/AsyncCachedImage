//
//  CacheDisk.swift
//  AsyncCachedImage
//
//  Created by Nati on 09/08/2024.
//

import Foundation

@globalActor
actor CacheActor{
    static let shared = CacheActor()
}

//@CacheActor
actor CacheDisk: CacheProtocol {
    
    private var cacheFolderURL: URL  {
        let folderURLs = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return folderURLs.first!
    }
    
    private let fileManager = FileManager.default
    
    func insert(_ value: Data, forKey key: URL) async {
        let id = key.absoluteString + ".cache"
        let fileURL = cacheFolderURL.appendingPathComponent(URL(string:id)!.lastPathComponent)
        do {
            try value.write(to: fileURL, options: .atomicWrite)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieve(forKey key: URL) async -> Data? {
        let id = key.absoluteString + ".cache"

        let fileURL = cacheFolderURL.appendingPathComponent(URL(string:id)!.lastPathComponent)
        let data = try? Data(contentsOf: fileURL, options: Data.ReadingOptions())
        return data
    }
    
    func removeValue(forKey key: URL) {
        do{
            try fileManager.removeItem(at: key)
        }catch{
            print(error)
        }
    }
    
    func invalidateCache() async{
        guard let filesUrl = try? fileManager.contentsOfDirectory(at: cacheFolderURL, includingPropertiesForKeys: nil, options: []) else {return}
        
        for file in filesUrl{
            if file.pathExtension == "cache"{
                try? fileManager.removeItem(at: file)
            }
        }
    }
}
