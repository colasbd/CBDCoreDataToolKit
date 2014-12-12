Pod::Spec.new do |s|


  s.name         = "CBDCoreDataToolKit"
  s.version      = "3.2.0"
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




  ############################################################
  # Importing
  ############################################################

  s.subspec 'Importing' do |ss|

    ss.source_files = 'Classes/Importing/*.{h,m}'

    ss.dependency 'CBDCoreDataToolKit/ActiveRecord'
    ss.dependency 'CBDCoreDataToolKit/Classical_cloning'


    # CBDCoreDataDiscriminator
    ss.subspec 'CBDCoreDataDiscriminator' do |sss|
      sss.dependency 'CBDCoreDataToolKit/Misc'
      sss.dependency 'CBDCoreDataToolKit/Importing/CBDCoreDataDecision'

      sss.source_files = 'Classes/Importing/CBDCoreDataDiscriminator/*.{h,m}'

      sss.subspec 'CBDCoreDataDiscriminatorHint' do |ssss|
        ssss.source_files = 'Classes/Importing/CBDCoreDataDiscriminator/CBDCoreDataDiscriminatorHint/**/*.{h,m}'
      end
    end


    # CBDCoreDataDecision
    ss.subspec 'CBDCoreDataDecision' do |sss|
      sss.dependency 'CBDCoreDataToolKit/Misc'

      sss.source_files = 'Classes/Importing/CBDCoreDataDecision/**/*.{h,m}'
    end

  end







  ############################################################
  # Classical_cloning
  ############################################################

  s.subspec 'Classical_cloning' do |ss|
      ss.source_files = 'Classes/Cloning/**/*.{h,m}' 
  end






  ############################################################
  # Enhanced_Cloning
  ############################################################

  s.subspec 'Enhanced_Cloning' do |ss|
      ss.dependency 'CBDCoreDataToolKit/Importing/CBDCoreDataDecision'

      ss.source_files = 'Classes/Enhanced Cloning/**/*.{h,m}'
  end




  ############################################################
  # Replacing
  ############################################################

  s.subspec 'Replacing' do |ss|
    ss.dependency 'CBDCoreDataToolKit/Misc'

    ss.source_files = 'Classes/Replacing/**/*.{h,m}'
  end
  




  ############################################################
  # ActiveRecord
  ############################################################

  s.subspec 'ActiveRecord' do |ss|
    ss.source_files = 'Classes/ActiveRecord/**/*.{h,m}'
  end





  ############################################################
  # ConnectedEntities
  ############################################################

  s.subspec 'ConnectedEntities' do |ss|
    ss.source_files = 'Classes/ConnectedEntities/**/*.{h,m}'
  end





  ############################################################
  # Misc
  ############################################################

  s.subspec 'Misc' do |ss|
    ss.source_files = 'Classes/Misc/**/*.{h,m}'
  end






  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.framework = 'CoreData'

  
end
