require 'test_helper'

class StorageTest < Test::Unit::TestCase
  context "Rubyprot Storage" do
    setup do
      @location = "marshalled_data/"
      @object_name = "TestClass"
      Rubyprot.configure do |config|
        Rubyprot.dump_path = "test/test_files/test_data"
        #change these values to run the tests
        #config.s3_bucket_name = "YOUR_BUCKET"
        #config.s3_access_key_id = "YOUR_KEY"
        #config.s3_secret_access_key = "YOUR_SECRET"
      end

    end
    
    if Rubyprot.s3_bucket_name && Rubyprot.s3_access_key_id && Rubyprot.s3_secret_access_key

      should "should upload file to amazon and return true" do
        assert_nothing_raised do
          assert Rubyprot.aws_upload(@location, @object_name)
        end      
      end
    
      should "should load file from amazon" do
        assert_nothing_raised do
          assert Rubyprot.aws_download(@location, @object_name)
        end
      end    

    else
      should "skip tests" do
        assert true
      end
    end
  end

end