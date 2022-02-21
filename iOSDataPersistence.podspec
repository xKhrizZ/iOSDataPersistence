Pod::Spec.new do |spec|

  #spec.cocoapods_version = '= 1.0'
  spec.name         = "iOSDataPersistence"
  spec.version      = "1.1.0"
  spec.summary      = "Framework for data persistence"

  spec.homepage     = "https://github.com/xKhrizZ/iOSDataPersistence"
  spec.license      = "MIT"
  spec.author       = { "Christian R" => "christianapu@hotmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/xKhrizZ/iOSDataPersistence.git", :tag => spec.version.to_s }
  spec.source_files  = "**/*.{h,swift}"
  spec.resource_bundles = {'iOSDataPersistence' => ['**/*.xcdatamodeld']}
  #spec.frameworks = 'Foundation', 'CoreData'
  spec.static_framework = true
  #spec.resources = "iOSDataPersistence/**/*.xcdatamodeld", "Resources/CoreDataModel.momd"
  #spec.ios.deployment_target = '12.0'
  spec.requires_arc = true
  #spec.public_header_files = 'iOSDataPersistence/**/*.h'
  spec.frameworks = 'CoreData'


end
