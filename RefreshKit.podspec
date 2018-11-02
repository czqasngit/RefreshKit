#
# Be sure to run `pod lib lint RefreshKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RefreshKit'
  s.version          = '1.0.0'
  s.summary          = 'A refresh kit for UIScrollView written by Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Pull-up pull-down kit
  Simple to use and extend
                       DESC

  s.homepage         = 'https://github.com/czqasngit/RefreshKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'czqasngit' => 'czqasn@163.com' }
  s.source           = { :git => 'https://github.com/czqasngit/RefreshKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'RefreshKit/Classes/**/*'
  s.resource_bundles = {
     'RefreshKit' => ['RefreshKit/Assets/*.png']
  }
  s.swift_version = '4.0'
  s.dependency 'BerryPlant'
end
