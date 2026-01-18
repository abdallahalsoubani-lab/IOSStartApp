platform :ios, '17.0'

use_frameworks!

# Shared pods for all targets
def shared_pods
  # Networking
  pod 'Alamofire', '~> 5.9'
  pod 'PromiseKit', '~> 6.0'

  # Firebase
  pod 'Firebase/Core', '~> 11.0'
  pod 'Firebase/Messaging', '~> 11.0'

  # Keyboard
  pod 'IQKeyboardManagerSwift', '~> 6.5'

  # Linting
  pod 'SwiftLint', '~> 0.56'
end

target 'DEMO' do
  shared_pods
end

target 'YGB' do
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
    end
  end
end
