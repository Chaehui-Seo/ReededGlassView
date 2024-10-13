# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReededGlassView'
  s.version          = '1.0.1'
  s.summary          = 'Assistant for Reeded Glass UI in iOS'
  
  # Set Swift version
  s.swift_version = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library is an assistant of making reeded glass UI in iOS with UIKit.
                       DESC

  s.homepage         = 'https://github.com/Chaehui-Seo/ReededGlassView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chaehui-Seo' => 'sch0991@naver.com' }
  s.source           = { :git => 'https://github.com/Chaehui-Seo/ReededGlassView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'Sources/ReededGlassView/**/*'
  
  # s.resource_bundles = {
  #   'ReededGlassView' => ['ReededGlassView/Assets/*.png']
  # }
end
