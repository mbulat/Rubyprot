require 'test_helper'

class StorageTest < Test::Unit::TestCase
  #change these values to run the tests
  #AMAZON_BUCKET_NAME = "yourbucket"
  #AMAZON_ACCESS_KEY_ID = "yourkey"
  #AMAZON_SECRET_ACCESS_KEY = "yoursecret"
  
  context "Rubyprot Storage File NOT on Amazon" do
    setup do
      @location = "marshalled_data"
      @object_name = "TestClass"
      Rubyprot.configure do |config|
        Rubyprot.dump_path = "test/test_files/test_data"
        config.amazon_bucket_name = AMAZON_BUCKET_NAME
        config.amazon_access_key_id = AMAZON_ACCESS_KEY_ID
        config.amazon_secret_access_key = AMAZON_SECRET_ACCESS_KEY
      end
    end
    
    should "upload file to amazon and return true" do
      assert_nothing_raised do
        assert Rubyprot.aws_upload(@location, @object_name)
      end      
    end    
  end
  
  context "Rubyprot Storage File already on Amazon" do
    setup do
      @location = "marshalled_data"
      @object_name = "TestClass"
      Rubyprot.configure do |config|
        Rubyprot.dump_path = "test/test_files/test_data"
        config.amazon_bucket_name = AMAZON_BUCKET_NAME
        config.amazon_access_key_id = AMAZON_ACCESS_KEY_ID
        config.amazon_secret_access_key = AMAZON_SECRET_ACCESS_KEY
      end

      AWS::S3::Base.establish_connection!(
        :access_key_id     => Rubyprot.amazon_access_key_id,
        :secret_access_key => Rubyprot.amazon_secret_access_key
      )
      
      file = File.open(Rubyprot.dump_path + "/" + @object_name)
      
      AWS::S3::S3Object.store(@location + "/" + @object_name, 
                              file, 
                              Rubyprot.amazon_bucket_name,
                              :cache_control => "no-store, no-cache, must-revalidate, post-check=0, pre-check=0")
    end
  
    should "download file from amazon" do
      assert_nothing_raised do
        assert Rubyprot.aws_download(@location, @object_name)
      end
    end  
    
    should "delete file from amazon and return true" do
      assert_nothing_raised do
        assert Rubyprot.aws_delete(@location, @object_name)
      end      
    end      
  end

end