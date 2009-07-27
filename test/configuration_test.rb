require 'test_helper'

class ConfigurationTest < Test::Unit::TestCase  
  should "be done with a block" do
    Rubyprot.configure do |config|
      config.dump_path = "test/test_files/my_path"
      config.amazon_bucket_name = "my_bucket"
      config.amazon_access_key_id = "my_key"
      config.amazon_secret_access_key = "my_access_key"
    end

    assert_equal "test/test_files/my_path", Rubyprot.dump_path
    assert_equal "my_bucket", Rubyprot.amazon_bucket_name
    assert_equal "my_key", Rubyprot.amazon_access_key_id
    assert_equal "my_access_key", Rubyprot.amazon_secret_access_key

    Rubyprot.configure do |config|
      config.dump_path = nil
      config.amazon_bucket_name = nil
      config.amazon_access_key_id = nil
      config.amazon_secret_access_key = nil
    end
  end
  
  should "raise error if bad path supplied" do
    assert_raise RuntimeError do
      Rubyprot.configure do |config|
        config.dump_path = "/this/is/a/bad/path"
      end

    end
  end
end
