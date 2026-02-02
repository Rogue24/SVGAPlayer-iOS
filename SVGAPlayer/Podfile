platform :ios, '12.0'

target 'SVGAPlayer' do
  use_frameworks!
  
  pod 'SSZipArchive', '~> 2.1.4'
  pod 'Protobuf', '3.29.5'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
      end
    end
  end
end
