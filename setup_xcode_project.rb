#!/usr/bin/env ruby

require 'xcodeproj'
require 'fileutils'

def create_ios_project
  puts "🚀 Creating Xcode project for IOSStartApp..."

  project_path = 'IOSStartApp.xcodeproj'

  # Remove existing project if it exists
  FileUtils.rm_rf(project_path) if File.exist?(project_path)

  # Create new project
  project = Xcodeproj::Project.new(project_path)

  # Main group
  main_group = project.main_group

  # Create group structure
  app_group = main_group.new_group('App')
  core_group = main_group.new_group('Core')
  core_plugin = core_group.new_group('Plugin')
  core_routing = core_group.new_group('Routing')
  core_routing_nav = core_routing.new_group('Navigations')
  core_theme = core_group.new_group('Theme')
  core_localization = core_group.new_group('Localization')
  core_networking = core_group.new_group('Networking')
  core_components = core_group.new_group('UIComponents')
  core_alert = core_group.new_group('Alert')
  core_utilities = core_group.new_group('Utilities')

  plugins_group = main_group.new_group('Plugins')
  features_group = main_group.new_group('Features')
  appguide_group = features_group.new_group('AppGuide')
  resources_group = main_group.new_group('Resources')
  resources_loc = resources_group.new_group('Localization')
  targets_group = main_group.new_group('Targets')

  # Add files
  app_files = ['App/AppDelegate.swift', 'App/RootView.swift', 'App/AppEnvironment.swift']
  app_files.each { |file| app_group.new_file(file) if File.exist?(file) }

  core_plugin_files = ['Core/Plugin/ApplicationService.swift', 'Core/Plugin/PluggableApplicationDelegate.swift']
  core_plugin_files.each { |file| core_plugin.new_file(file) if File.exist?(file) }

  core_routing_files = ['Core/Routing/Route.swift', 'Core/Routing/Navigator.swift']
  core_routing_files.each { |file| core_routing.new_file(file) if File.exist?(file) }

  nav_files = [
    'Core/Routing/Navigations/LaunchAppNavigation.swift',
    'Core/Routing/Navigations/AuthenticationAppNavigation.swift',
    'Core/Routing/Navigations/HomeNavigation.swift',
    'Core/Routing/Navigations/CustomAlertNavigation.swift',
    'Core/Routing/Navigations/AppGuideNavigation.swift'
  ]
  nav_files.each { |file| core_routing_nav.new_file(file) if File.exist?(file) }

  core_theme.new_file('Core/Theme/AppTheme.swift') if File.exist?('Core/Theme/AppTheme.swift')
  core_localization.new_file('Core/Localization/LocalizationManager.swift') if File.exist?('Core/Localization/LocalizationManager.swift')

  networking_files = ['Core/Networking/NetworkError.swift', 'Core/Networking/APIClient.swift']
  networking_files.each { |file| core_networking.new_file(file) if File.exist?(file) }

  components_files = ['Core/UIComponents/AppButton.swift', 'Core/UIComponents/AppTextField.swift', 'Core/UIComponents/StateViews.swift']
  components_files.each { |file| core_components.new_file(file) if File.exist?(file) }

  core_alert.new_file('Core/Alert/AlertCenter.swift') if File.exist?('Core/Alert/AlertCenter.swift')
  core_utilities.new_file('Core/Utilities/Extensions.swift') if File.exist?('Core/Utilities/Extensions.swift')

  plugins_files = Dir.glob('Plugins/*.swift')
  plugins_files.each { |file| plugins_group.new_file(file) }

  appguide_group.new_file('Features/AppGuide/AppGuideView.swift') if File.exist?('Features/AppGuide/AppGuideView.swift')

  resources_group.new_file('Resources/Info.plist') if File.exist?('Resources/Info.plist')

  localization_files = [
    'Resources/Localization/en.lproj/Localizable.strings',
    'Resources/Localization/ar.lproj/Localizable.strings'
  ]
  localization_files.each { |file| resources_loc.new_file(file) if File.exist?(file) }

  # Add Podfile and configuration files
  main_group.new_file('Podfile') if File.exist?('Podfile')
  main_group.new_file('.swiftlint.yml') if File.exist?('.swiftlint.yml')
  main_group.new_file('swiftgen.yml') if File.exist?('swiftgen.yml')

  # Create target for YGB flavor
  create_target(project, 'YGB')

  # Create target for DEMO flavor
  create_target(project, 'DEMO')

  # Save project
  project.save

  puts "✅ Xcode project created successfully!"
  puts "📁 Project path: #{project_path}"
  puts ""
  puts "📌 Next steps:"
  puts "   1. pod install"
  puts "   2. open IOSStartApp.xcworkspace"
  puts "   3. Select scheme YGB-Debug or DEMO-Debug"
  puts "   4. Build and run!"
end

def create_target(project, flavor_name)
  puts "📱 Creating target: #{flavor_name}"

  # Create target
  target = project.new_target(:application, flavor_name, :ios, '17.0')
  target.product_name = flavor_name

  # Add build phases
  target.build_phases.clear

  # Add all Swift files to target
  swift_files = Dir.glob('**/*.swift')
  swift_files.each do |file|
    file_ref = project.files.find { |f| f.real_path.to_s == File.expand_path(file) }
    unless file_ref
      file_ref = project.main_group.new_file(file)
    end
    target.add_file_references([file_ref])
  end

  # Configure build settings
  target.build_configurations.each do |config|
    settings = config.build_settings

    # Basic settings
    settings['PRODUCT_NAME'] = flavor_name
    settings['EXECUTABLE_NAME'] = flavor_name
    settings['BUNDLE_IDENTIFIER'] = flavor_name == 'YGB' ? 'com.example.ygb.app' : 'com.example.demo.app'
    settings['DISPLAY_NAME'] = flavor_name == 'YGB' ? 'YGB App' : 'DEMO App'

    # Swift settings
    settings['SWIFT_VERSION'] = '5.10'
    settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'

    # Code signing
    settings['CODE_SIGN_STYLE'] = 'Automatic'
    settings['DEVELOPMENT_TEAM'] = 'PLACEHOLDER'
    settings['CODE_SIGN_IDENTITY'] = 'Apple Development'

    # Device settings
    settings['TARGETED_DEVICE_FAMILY'] = '1,2'

    # Info.plist
    settings['INFOPLIST_FILE'] = 'Resources/Info.plist'

    # XCConfig
    if config.name == 'Debug'
      config.base_configuration_reference = project.files.find { |f| f.real_path.to_s.include?("#{flavor_name}-Debug.xcconfig") } ||
        project.main_group.new_file("Targets/#{flavor_name}/Configurations/#{flavor_name}-Debug.xcconfig")
    elsif config.name == 'Release'
      config.base_configuration_reference = project.files.find { |f| f.real_path.to_s.include?("#{flavor_name}-Release.xcconfig") } ||
        project.main_group.new_file("Targets/#{flavor_name}/Configurations/#{flavor_name}-Release.xcconfig")
    end
  end

  # Add build phases for SwiftLint
  script_phase = target.new_shell_script_build_phase('SwiftLint')
  script_phase.shell_script = '"${PODS_ROOT}/SwiftLint/swiftlint"'
  script_phase.show_env_vars_in_log = '0'

  # Add build phases for SwiftGen
  swiftgen_phase = target.new_shell_script_build_phase('SwiftGen')
  swiftgen_phase.shell_script = 'swiftgen run'
  swiftgen_phase.show_env_vars_in_log = '0'
end

# Run the script
begin
  create_ios_project
rescue => e
  puts "❌ Error: #{e.message}"
  puts e.backtrace
  exit 1
end
