//
//  Cachable.swift
//  AsyncCachedImage
//
//  Created by Nati on 13/08/2024.
//

import Foundation
import UIKit

public protocol Cachable {
    func encode() async -> Data
}

@CacheActor
extension UIImage: Cachable {
    public func encode() -> Data {
        return jpegData(compressionQuality: 0.1)!
    }
}
