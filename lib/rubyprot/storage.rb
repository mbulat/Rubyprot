require 'aws/s3'
require 'mechanize'
  
module Rubyprot 
  class Storage #:nodoc:
    def self.aws_download(location, name)
      raise "s3_bucket_name attribute must be set" unless Rubyprot.s3_bucket_name
      raise "s3_secret_access_key attribute must be set" unless Rubyprot.s3_secret_access_key
      raise "s3_access_key_id attribute must be set" unless Rubyprot.s3_access_key_id

        AWS::S3::Base.establish_connection!(
          :access_key_id     => Rubyprot.s3_access_key_id,
          :secret_access_key => Rubyprot.s3_secret_access_key
        )
      
        marshalled_data = AWS::S3::S3Object.find location + name, Rubyprot.s3_bucket_name
        url = URI.parse(marshalled_data.url)
      
        agent = WWW::Mechanize.new
        marshalled_file = agent.get(url)
        marshalled_file.save_as(Rubyprot.dump_path + '/' + name)
    end

    def self.aws_upload(location, name)
      raise "s3_bucket_name attribute must be set" unless Rubyprot.s3_bucket_name
      raise "s3_secret_access_key attribute must be set" unless Rubyprot.s3_secret_access_key
      raise "s3_access_key_id attribute must be set" unless Rubyprot.s3_access_key_id

      AWS::S3::Base.establish_connection!(
        :access_key_id     => Rubyprot.s3_access_key_id,
        :secret_access_key => Rubyprot.s3_secret_access_key
      )
      
      file = File.open(Rubyprot.dump_path + "/" + name)
      
      AWS::S3::S3Object.store(location + name, 
                              file, 
                              Rubyprot.s3_bucket_name,
                              :cache_control => "no-store, no-cache, must-revalidate, post-check=0, pre-check=0")
    end
    
  end
end



