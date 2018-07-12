#
#  Be sure to run `pod spec lint XXArrowTips.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name             = "XXArrowTips"
  s.version          = "1.0.0"
  s.summary          = "A arrow Tips view used on iOS."
  s.description      = <<-DESC
                       It is a marquee view used on iOS, which implement by Objective-C.
                       DESC
  s.homepage         = "https://github.com/lucyDad/XXArrowTips"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "何翔" => "riverfly1987@163.com" }
  s.source           = { :git => "https://github.com/lucyDad/XXArrowTips.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'
 
  s.platform     = :ios, '8.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true
 
  s.source_files = 'XXArrowTips/*'
  # s.resources = 'Assets'
 
  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'


end
