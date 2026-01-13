platform :ios, '17.0'

target 'IOSStartApp' do
  use_frameworks!

  # Networking
  pod 'Alamofire', '~> 5.9'
  pod 'PromiseKit', '~> 6.23'

  # Firebase
  pod 'Firebase/Core', '~> 11.0'
  pod 'Firebase/Messaging', '~> 11.0'

  # Keyboard
  pod 'IQKeyboardManagerSwift', '~> 3.3'

  # Linting
  pod 'SwiftLint', '~> 0.56'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      flutter_additional_ios_build_settings(target)
      target.build_configurations.each do |config|
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
          '$(inherited)',
          'FIREBASE_SDK_VERSION=' + Pod::Version.parse(installer.analysis_result.specs.detect { |s| s.name == 'Firebase' }.version).major.to_s
        ]
      end
    end
  end
end
