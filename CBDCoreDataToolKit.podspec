Pod::Spec.new do |s|


  s.name         = "CBDCoreDataToolKit"
  s.version      = "2.0.0"
  s.summary      = "Clone, replace, import and fetch methods for CoreData"

  s.description  = <<-DESC
                  Clone, replace, import and fetch methods for CoreData

                  * cloning a NSManagedObject from a NSManagedObjectContext (MOC) to another
                  * replacing a NSManagedObject by another
                  * importing objects from a MOC to another MOC
                  * wrapping methods for fetching objects. These methods don't create the MOC, the NSManagedObjectModel, etc. So, they are fully working with NSPersistentDocument
                   DESC

  s.author        = { "Colas" => "colas.bardavid@gmail.com" }
  s.homepage      = "https://github.com/colasjojo/CBDCoreDataToolKit"

  s.license = { :type => 'MIT'}

  s.source       = { :git => 'https://github.com/colasjojo/CBDCoreDataToolKit.git', 
                     :tag =>  "#{s.version}" }

  s.source_files = 'Classes/CBDCoreDataToolKit.h'

  s.subspec 'Misc' do |ss|
    ss.source_files = 'Classes/Misc/**/*.{h,m}'
  end

  s.subspec 'Importing' do |ss|
    ss.source_files = 'Classes/Importing/**/*.{h,m}'
  end

  s.subspec 'Cloning' do |ss|
    ss.source_files = 'Classes/Cloning/**/*.{h,m}'
  end

  s.subspec 'Replacing' do |ss|
    ss.source_files = 'Classes/Replacing/**/*.{h,m}'
  end
  
  s.subspec 'ActiveRecord' do |ss|
    ss.source_files = 'Classes/ActiveRecord/**/*.{h,m}'
  end

  s.requires_arc = true

  s.ios.platform   = :ios, '5.0'
  s.osx.platform   = :osx, '10.7'

  s.framework = 'CoreData'
  
  
end
