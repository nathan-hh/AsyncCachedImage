
# AsyncCachedImage
[![Version](https://img.shields.io/cocoapods/v/SwiftyMediaGallery.svg?style=flat)](https://cocoapods.org/pods/SwiftyMediaGallery)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-compatible-brightgreen.svg)](https://developer.apple.com/documentation/swiftui)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyMediaGallery.svg?style=flat)](https://cocoapods.org/pods/SwiftyMediaGallery)
![Swift](https://img.shields.io/badge/%20in-swift%205.5-orange.svg)
![Swift Package Manager](https://img.shields.io/badge/package%20manager-compatible-brightgreen.svg)
[![License](https://img.shields.io/badge/license-NON--AI--MIT-yellow.svg)](https://github.com/non-ai-licenses/non-ai-licenses/blob/main/NON-AI-MIT)

A powerful, flexible, and easy-to-use asynchronous image loading component for SwiftUI, featuring automatic caching and placeholder support.
Leveraging FileManager cachesDirectory and NSCache provides persistent and in-memory caches.

## Overview

AsyncCachedImage is designed to simplify image loading in SwiftUI applications while providing advanced features such as caching, placeholder support, and authentication. This component aims to replace the standard SwiftUI AsyncImage view with a more robust and efficient alternative for remote images.

## Features

- Asynchronous image loading
- Automatic caching of loaded images
- Placeholder support during loading
- URL-based image loading
- Local file system image caching
- Memory image caching
- Supports adding an authentication token header

## Requirements and support

You can use AsyncCachedImage on the following platforms:
* iOS 15.0+

## Usage

The simplest way to create an `AsyncCachedImage` view is to pass the image URL to the `init(url:)` initializer.

```swift
AsyncImageView(url: URL(string: "https://fastly.picsum.photos/id/16/2500/1667.jpg"))
  .frame(width: 300, height: 200)
```

To manipulate the loaded image, use the `content` parameter.

```swift
AsyncImageView(url: URL(string: "https://fastly.picsum.photos/id/16/2500/1667.jpg")) { image in
  image
    .resizable()
    .scaledToFill()
    .blur(radius: 4)
}
```

The view displays a standard placeholder that fills the available space until the image loads. You
can specify a custom placeholder by using the `placeholder` parameter.

```swift
AsyncImageView(url: URL(string: "https://fastly.picsum.photos/id/16/2500/1667.jpg")) { image in
  image
    .resizable()
    .scaledToFill()
} placeholder: {
    Image(systemName: "photo.fill")
      .blendMode(.overlay)
}
.frame(width: 150, height: 150)
.clipped()
```

###  Configuration

Setting authentication header

```swift
let header = AuthenticationHeader(key: "Bearer TOKEN", value: "Authorization")
AsyncImageConfiguration.shared.setAuthentication(header: header)
```

## Installation

### CocoaPods

SwiftyMediaGallery is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AsyncCachedImage'
```

### Swift Package Manager

To use AsyncCachedImage in a Swift Package Manager project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/nathan-hh/AsyncCachedImage", from: "0.1.0")
```

Include `"AsyncCachedImage"` as a dependency for your executable target:

```swift
.target(name: "<target>", dependencies: [
  .product(name: "AsyncCachedImage", package: "AsyncCachedImage")
]),
```

## Best Practices

1. Use AsyncCachedImage for remote images to improve performance and reduce network usage.
2. Provide meaningful placeholders to improve user experience during loading.
3. Configure caching policies based on your app's needs and image characteristics.
4. Be mindful of memory usage when dealing with large images or numerous concurrent loads.

## Contributing

Contributions are welcome! Please submit pull requests with detailed descriptions of changes and additions.

## License
AsyncCachedImage is available under the [NON-AI-MIT license](https://github.com/non-ai-licenses/non-ai-licenses/blob/main/NON-AI-MIT). See the LICENSE file for more info.

