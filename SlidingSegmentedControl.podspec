Pod::Spec.new do |s|
  s.name             = 'SlidingSegmentedControl'
  s.version          = '0.1.0'
  s.summary          = 'SlidingSegmentedControl is a simple sliding multiselection segment control view.'


  s.description      = <<-DESC
    SlidingSegmentedControl is a simple multiselection segment control view. It is realized with UIStackView and custom UIView subclass - Segment. Segment is based on UIButton. There is delegate for handling MultiSelectionSlideSegmentedControl events such as select new item, and select many items. MultipleSelectionControl provides to select many items by sliding
                       DESC

  s.homepage         = 'https://github.com/DimaNakhratiants/SlidingSegmentedControl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DimaNakhratiants' => 'dirmidante@gmail.com' }
  s.source           = { :git => 'https://github.com/DimaNakhratiants/SlidingSegmentedControl.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'SlidingSegmentedControl/Classes/**/*'

end
