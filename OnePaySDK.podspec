#
# Be sure to run `pod lib lint OnePaySDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OnePaySDK'
  s.version          = '1.0.0'
  s.summary          = 'OnePay.network SDK for Swift&SwiftUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'OnePay.network SDK for Swift & SwiftUI.'
  s.swift_versions   = '4.0'
  s.homepage         = 'https://github.com/1pay-network/1pay-swift-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'x-oauth-basic' => 'sunnv.1510@gmail.com' }
  s.source           = { :git => 'https://github.com/1pay-network/1pay-swift-sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'OnePaySDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'OnePaySDK' => ['OnePaySDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'SwiftUI', 'WebKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
