# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'
 inhibit_all_warnings!


target 'Logistic' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Logistic

  pod 'SDWebImage', '~> 5.0'
  pod 'ReachabilitySwift', '~> 4.3.1'
  pod 'Alamofire', '~> 5.0.0-beta.5'
  pod 'OHHTTPStubs/Swift', '~> 7.0.0'
  pod 'Fabric', '~> 1.9.0'
  pod 'Crashlytics', '~> 3.12.0'
  pod 'Toast-Swift', '~> 5.0.0'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5.0'
      end
    end
  end

  target 'LogisticTests' do
    inherit! :search_paths
    use_frameworks!

    # Pods for testing
    
  pod 'Nimble', '~> 8.0.1'
  pod 'Quick'

  end

  target 'LogisticUITests' do
    inherit! :search_paths
    
    # Pods for testing
    pod 'OHHTTPStubs/Swift', '~> 7.0.0'
    pod 'SDWebImage', '~> 5.0'
    pod 'ReachabilitySwift', '~> 4.3.1'
    pod 'Alamofire', '~> 5.0.0-beta.5'
    pod 'OHHTTPStubs/Swift', '~> 7.0.0'
    pod 'Fabric', '~> 1.9.0'
    pod 'Crashlytics', '~> 3.12.0'
    pod 'Toast-Swift', '~> 5.0.0'

  end

end
