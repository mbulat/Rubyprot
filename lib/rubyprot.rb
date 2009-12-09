# == About rubyprot.rb
#
# All of Rubyprot's various part are loaded when you use <tt>require 'rubyprot'</tt>.
#
# * rubyprot/serializer.rb: serializes objects via marshal into file
# * rubyprot/deserializer.rb: deserializes files via marshal into objects
# 
# Created by Michael Bulat on 2009-07-23.
# Copyright 2009 Michael Bulat. All rights reserved.
# 
require 'rubyprot/serializer'
require 'rubyprot/deserializer'
require 'rubyprot/storage'

module Rubyprot
  class << self
    # top level path where temporary files will be placed
    attr_accessor :dump_path
    # amazon s3 bucket for file storage
    attr_accessor :amazon_bucket_name
    # amazon access key
    attr_accessor :amazon_access_key_id
    # amazon secret key
    attr_accessor :amazon_secret_access_key  
    
    #Allows block configuration of Rubyprot attributes
    #
    #   Rubyprot.configure do |config|
    #     config.dump_path = "my_folder/my_path"
    #     config.amazon_bucket_name = "my_bucket"
    #     config.amazon_access_key_id = "my_key"
    #     config.amazon_secret_access_key = "my_access_key"
    #   end    
    def configure
      yield self
    end
    
    # Marshals any object into a file named after the object class and stores 
    # the file in the folder specified by the +dump_path+ attribute.
    # Returns the name of the file.
    #
    #   >> Rubyprot.serialize(object)
    #   => "Object"
    def serialize(object)
      return Rubyprot::Serializer.serialize(object)
    end

    # Unmarshals named file from the folder specified 
    # by the +dump_path+ attribute. 
    # Returns the object.
    #
    #   >> Rubyprot.deserialize("Object")
    #   => #<Object:0x18a30d0>
    def deserialize(name)
      return Rubyprot::Deserializer.deserialize(name)
    end

    # Downloads file from amazon 
    # using +amazon_bucket_name+, +amazon_access_key_id+, +amazon_secret_access_key+
    # attributes to +dump_path+. 
    #
    # Returns the file name for use to deserialize object
    #
    #   Rubyprot.deserialize(Rubyprot.aws_download("path_to_data", "Object"))
    def aws_download(location, name)
      return Rubyprot::Storage.aws_download(location, name)
    end

    # Uploads file from amazon
    # using +amazon_bucket_name+, +amazon_access_key_id+, +amazon_secret_access_key+
    # to given +location+ on s3.
    #
    # Returns HTTP status
    #
    #    Rubyprot.aws_upload("path_to_data", Rubyprot.serialize(conversations)) 
    def aws_upload(location, name)
      return Rubyprot::Storage.aws_upload(location, name)
    end

    # Deletes file from amazon
    # using +amazon_bucket_name+, +amazon_access_key_id+, +amazon_secret_access_key+
    # from given +location+ on s3.
    #
    # Returns HTTP status
    #
    #    Rubyprot.aws_delete("path_to_data", "Object") 
    def aws_delete(location, name)
      return Rubyprot::Storage.aws_delete(location, name)
    end

    def dump_path=(value) #:nodoc: 
      begin
        unless value.nil?
          unless File.directory?(value)
            FileUtils.mkdir(value)
          end      
          if File.directory?(value)
            @dump_path = value
          end
        else
          @dump_path = nil
        end
      rescue
        raise "Dump path directory invalid. Please check your configuration."
      end
    end
  end
end
