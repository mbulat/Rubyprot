# 
#  rubyprot.rb
#  rubyprot
#  
#  includes all the pieces for rubyprot
# 
#  Created by Michael Bulat on 2009-07-23.
#  Copyright 2009 __MyCompanyName__. All rights reserved.
# 
require 'rubyprot/serializer'
require 'rubyprot/deserializer'

module Rubyprot
  class << self
    attr_accessor :dump_path
    attr_accessor :s3_bucket_name
    attr_accessor :s3_access_key_id
    attr_accessor :s3_secret_access_key  
    
    #allows block configuration of Rubyprot attributes
    def configure
      yield self
    end
    
    #Marshals any object into a file and stores 
    #the file in the "serializer" folder under 
    #the specified dump_path.
    def serialize(object)
      return Rubyprot::Serializer.serialize(object)
    end

    #Unmarshals named file and returns the object. 
    #The file must be located in the "deserializer" 
    #folder in the specified dump_path.
    def deserialize(name)
      return Rubyprot::Deserializer.deserialize(name)
    end
    
    def dump_path=(value)
      begin
        unless File.directory?(value)
          FileUtils.mkdir(value)
        end      
        unless File.directory?(value + '/serializer')
          FileUtils.mkdir(value + '/serializer')
        end
        unless File.directory?(value + '/deserializer')
          FileUtils.mkdir(value + '/deserializer')
        end        
        if File.directory?(value)
          @dump_path = value
        end
      rescue
        raise "Dump path directory invalid. Please check your configuration."
      end
    end
  end
end
