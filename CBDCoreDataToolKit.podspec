Pod::Spec.new do |s|


  s.name         = "CBDCoreDataToolKit"
  s.version      = "3.2.1"
  s.summary      = "Cloning, replacing, importing with CoreData"

  s.description  = <<-DESC
                  Cloning, replacing, importing with CoreData

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




# *******************************
# ************* TODO ************
# *******************************
#
# Comment the following line to see the TODO
  s.prefix_header_contents = '#define TODO(args...)'
#
#
# Comment to ignore the TODO
  #s.prefix_header_contents = '#import "MyCBDMacros.h"'
#
#
# Uncomment in the following line to include the todo file
  #s.resource  = "todo.rtf"
# *******************************



  s.source_files = 'Classes/**/*.{h,m}'



  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.framework = 'CoreData'

  
end
