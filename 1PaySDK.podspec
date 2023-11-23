#
# Be sure to run `pod lib lint OnePaySDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = '1PaySDK'
  s.version          = '1.0.0'
  s.summary          = 'OnePay.network SDK for Swift & SwiftUI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'OnePay.network SDK for Swift & SwiftUI.'
  s.swift_versions   = '4.0'
  s.homepage         = 'https://1pay.network'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SunnV' => 'sunnv.dev@1pay.network' }
  s.source           = { :git => 'https://github.com/1pay-network/1pay-ios-sdk.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/1pay_network'
  s.readme           = 'https://raw.githubusercontent.com/1pay-network/1pay-ios-sdk/main/README.md'
  s.module_name      = 'OnePaySDK'

  s.ios.deployment_target = '13.0'

  s.source_files = 'OnePaySDK/Classes/**/*'
  s.frameworks = 'UIKit', 'SwiftUI', 'WebKit'
end
