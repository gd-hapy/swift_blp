#
# Be sure to run `pod lib lint swift_blp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'swift_blp'
  s.version          = '0.1.0'
  s.summary          = 'A short description of swift_blp.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gd-hapy/swift_blp'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gd-hapy' => 'gdhapy@gmail.com' }
  s.source           = { :git => 'https://github.com/gd-hapy/swift_blp.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'swift_blp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'swift_blp' => ['swift_blp/Assets/*.png']
  # }
  s.dependency 'Alamofire', '4.9.1'
  s.dependency 'Moya', '13.0.1'
  s.dependency 'SwiftyJSON', '5.0.1'
  s.dependency 'RxSwift', '6.5.0'
  s.dependency 'RxCocoa', '6.5.0'
  s.dependency 'HandyJSON' #4.1.1 (5.0.2)

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
