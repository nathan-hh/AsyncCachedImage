//
//  CacheManager.swift
//  AsyncCachedImage
//
//  Created by Nati on 08/08/2024.
//

import Foundation
import UIKit

public protocol CacheProtocol {
    func insert(_ value: Data, forKey key: URL) async
    func retrieve(forKey key: URL) async -> Data?
    func invalidateCache() async
}

struct Options: OptionSet {
    static let saveToDisk = Options(rawValue: 1 << 0)
    static let saveToMemory = Options(rawValue: 1 << 1)

    let rawValue: Int
}

struct ImageCache {
    static let shared = CacheManager(options: nil)
    
    private init(){}
}

//a facade structure to handle both disk and memory
actor CacheManager: CacheProtocol {
    private let memoryCache: CacheMemory
    private let diskCache: CacheDisk
    private let options : Options

    init(options: Options? = nil) {
        self.memoryCache = CacheMemory()
        self.diskCache = CacheDisk()
        self.options = options ?? [Options.saveToDisk, Options.saveToMemory]
    }
    
    func insert(_ value: Data, forKey key: URL) async{
        if options.contains(.saveToMemory){
            await memoryCache.insert(value, forKey: key)
        }
        if options.contains(.saveToDisk){
            await diskCache.insert(value, forKey: key)
        }
    }

    func retrieve(forKey key: URL) async -> Data? {
        if let val = await memoryCache.retrieve(forKey: key){
            return val
        } else if let value = await diskCache.retrieve(forKey: key){
            if options.contains(.saveToMemory){
                await memoryCache.insert(value, forKey: key)
            }
            return value
        }
        return nil;
    }
    
    func invalidateCache() async {
        await memoryCache.invalidateCache()
        await diskCache.invalidateCache()
    }
    
}
