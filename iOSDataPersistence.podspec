Pod::Spec.new do |spec|

  #spec.cocoapods_version = '= 1.0'
  spec.name         = "iOSDataPersistence"
  spec.version      = "0.1.1"
  spec.summary      = "Framework for data persistence"
  spec.homepage     = "https://github.com/xKhrizZ/iOSDataPersistence"
  spec.license      = "MIT"
  spec.author       = { "Christian R" => "christianapu@hotmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/xKhrizZ/iOSDataPersistence.git", :tag => spec.version.to_s }
  spec.source_files  = "iOSDataPersistence/**/*.{swift}"
  #spec.resource_bundles = {'iOSDataPersistence' => ['iOSDataPersistence/**/*.xcdatamodeld']}
  spec.resources = "iOSDataPersistence/**/*.xcdatamodeld"
  spec.frameworks = 'Foundation', 'CoreData'
  #spec.static_framework = true
  spec.ios.deployment_target = '12.0'
  #spec.requires_arc = true
  #spec.dependency "iOSBusinessDomain", '~> 0.1.0' #No
  
  #spec.module_name = 'iOSBusinessDomain'
  #spec.module_name = 'iOSSecurity'
  
  #spec.add_development_dependency 'iOSBusinessDomain',     '~> 0.1.0'

end
