source 'https://github.com/CocoaPods/Specs.git'

platform:ios,'13.0'

#公用pods

def commonPods

  use_frameworks!
  
#  pod 'MyBaseExtension', :path => '/Users/Howard-Zjun/MyBaseExtension'
#  pod 'MyControlView', :path => '/Users/Howard-Zjun/MyControlView'
  pod 'MyBaseExtension', :git => 'https://github.com/Howard-Zjun/MyBaseExtension.git'
  pod 'MyControlView', :git => 'https://github.com/Howard-Zjun/MyControlView.git'
end

target 'CIImage-Debug' do
  
    project 'CIImage-Debug.xcodeproj'
    
    commonPods
end
