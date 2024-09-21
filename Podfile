source 'https://github.com/CocoaPods/Specs.git'

platform:ios,'13.0'

#公用pods

def commonPods

  use_frameworks!
  
  pod 'MyBaseExtension', :path => '/Users/guanjiayin/MyBaseExtension'
  pod 'MyControlView', :path => '/Users/guanjiayin/MyControlView'
end

target 'CIImage-Debug' do
  
    project 'CIImage-Debug.xcodeproj'
    
    commonPods
end
