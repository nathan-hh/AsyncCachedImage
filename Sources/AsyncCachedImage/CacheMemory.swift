//
//  CacheMemory.swift
//  AsyncCachedImage
//
//  Created by Nati on 09/08/2024.
//

import Foundation
import UIKit

//@CacheActor
actor CacheMemory: CacheProtocol {
    
    let cache = NSCache<WrappedKey, NSData>()
    
    func insert(_ value: Data, forKey key: URL) async {
        cache.setObject(value as NSData, forKey: WrappedKey(key))
    }
    
    func retrieve(forKey key: URL) async -> Data? {
        cache.object(forKey: WrappedKey(key)) as Data?
    }
    
    func invalidateCache() async{
        cache.removeAllObjects()
    }
    
    func removeValue(forKey key: URL) {
        cache.removeObject(forKey: WrappedKey(key))
    }

    final class WrappedKey: NSObject {
        let key: URL
        init(_ key: URL) { self.key = key }
        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }

}
