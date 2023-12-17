source 'https://cdn.cocoapods.org/'

platform :ios, '15.0'

target 'MovieMate' do
  use_frameworks!

  # Pods for MovieMate
  pod 'SnapKit'
  pod 'HandlersKit'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'CombineCocoa'
  pod 'FLEX', :configurations => ['Debug']
  pod 'SkeletonView'
  pod 'Shuffle-iOS'
  pod 'YYText'

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
	config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
