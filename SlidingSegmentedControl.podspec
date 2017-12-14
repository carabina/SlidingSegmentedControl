#
# Be sure to run `pod lib lint SlidingSegmentedControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SlidingSegmentedControl'
  s.version          = '0.1.0'
  s.summary          = 'SlidingSegmentedControl is a simple sliding multiselection segment control view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    SlidingSegmentedControl is a simple multiselection segment control view. It is realized with UIStackView and custom UIView subclass - Segment. Segment is based on UIButton. There is delegate for handling MultiSelectionSlideSegmentedControl events such as select new item, and select many items. MultipleSelectionControl provides to select many items by sliding
                       DESC

  s.homepage         = 'https://github.com/DimaNakhratiants/SlidingSegmentedControl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DimaNakhratiants' => 'dirmidante@gmail.com' }
  s.source           = { :git => 'https://github.com/DimaNakhratiants/SlidingSegmentedControl.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'SlidingSegmentedControl/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SlidingSegmentedControl' => ['SlidingSegmentedControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
