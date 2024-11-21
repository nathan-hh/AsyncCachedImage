//
//  AsyncImageConfiguration.swift
//  AsyncCachedImage
//
//  Created by Nati on 20/11/2024.
//

import Foundation

public struct AuthenticationHeader{
    let key: String, value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

public class AsyncImageConfiguration{
    var header: AuthenticationHeader? = nil
    public static let shared = AsyncImageConfiguration()
    
    private init(){}
}

public extension AsyncImageConfiguration{
    
    func setAuthentication(header: AuthenticationHeader){
        self.header = header
    }
    
    func setCachePolicy(){

    }
    
    func invalidateCache() async{
        await ImageCache.shared.invalidateCache()
    }
}
