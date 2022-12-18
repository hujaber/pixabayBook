# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'PixabayBook' do

  use_frameworks!

  # Pods for PixabayBook
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
    pod 'Kingfisher', '~> 7.0'

  target 'PixabayBookTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
    # remove this in Xcode 14.1
    
    
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        end
      end
  end

end
