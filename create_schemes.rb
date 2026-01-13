#!/usr/bin/env ruby

require 'xcodeproj'
require 'fileutils'

def create_schemes
  puts "🎯 Creating Xcode schemes..."

  project_path = 'IOSStartApp.xcodeproj'
  project = Xcodeproj::Project.open(project_path)

  flavors = ['YGB', 'DEMO']
  configurations = ['Debug', 'Release', 'Staging']

  flavors.each do |flavor|
    configurations.each do |config|
      target = project.targets.find { |t| t.name == flavor }
      next unless target

      scheme_name = "#{flavor}-#{config}"
      puts "  📌 Creating scheme: #{scheme_name}"

      scheme = Xcodeproj::XCScheme.new

      # Add build action
      build_action_entry = Xcodeproj::XCScheme::BuildAction::Entry.new(target)
      scheme.build_action.add_entry(build_action_entry)

      # Set build configuration
      scheme.launch_action.build_configuration = config
      scheme.build_action.build_configuration = config
      scheme.test_action.build_configuration = config
      scheme.profile_action.build_configuration = config
      scheme.analyze_action.build_configuration = config

      # Save scheme
      schemes_path = File.join(project_path, 'xcshareddata', 'xcschemes')
      FileUtils.mkdir_p(schemes_path)
      scheme.save_as(project_path, scheme_name, true)
    end
  end

  puts "✅ Schemes created successfully!"
end

begin
  create_schemes
rescue => e
  puts "❌ Error: #{e.message}"
  puts e.backtrace
  exit 1
end
