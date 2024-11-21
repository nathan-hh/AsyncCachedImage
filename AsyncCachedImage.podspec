#
# Be sure to run `pod lib lint AsyncCachedImage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AsyncCachedImage'
    s.version          = '0.1.0'
    s.summary          = 'AsyncCachedImage let you simplify image loading and caching in SwiftUI.'
    s.requires_arc = true

    s.description      = <<-DESC
    AsyncCachedImage is powerful, flexible, and easy-to-use asynchronous image loading component for SwiftUI, featuring automatic caching and placeholder support. Leveraging FileManager cachesDirectory and NSCache provides persistent and in-memory caches.
                       DESC

    s.homepage         = 'https://github.com/nathan-hh/AsyncCachedImage'
    s.license          = { :type => 'NON-AI-MIT', :file => 'LICENSE.txt' }
    s.author           = { 'nathan-hh' => 'nathan' }
    s.source           = { :git => 'https://github.com/nathan-hh/AsyncCachedImage.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '15.0'

    s.swift_version = "5.5"
    s.source_files = 'Sources/**/*.{h,m,swift}'
  # s.resources = 'Sources/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit' ,'AVFoundation', 'SwiftUI'
end
