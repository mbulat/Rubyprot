require 'test_helper'

class SerializerTest < Test::Unit::TestCase
  context "Rubyprot deserializer" do
    setup do
      @test_file_path = "test/test_files/test_data"
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end

    end
    
    should "should unmarshal closed file into working object" do
      
      assert_nothing_raised do
        file = File.open("test/test_files/test_data/deserializer/TestClass","r")
        file.close
        my_object = Rubyprot.deserialize(file)

        assert_kind_of TestClass, my_object

        assert_equal my_object.test_method, 'this method returned'
        assert_nothing_raised do
          my_object.test_attr = 'hello world'
        end
        assert_equal my_object.test_attr, 'hello world'
      end
      
    end    

    should "should unmarshal open file into working object" do
      
      assert_nothing_raised do
        file = File.open("test/test_files/test_data/deserializer/TestClass","r")
        my_object = Rubyprot.deserialize(file)

        assert_kind_of TestClass, my_object

        assert_equal my_object.test_method, 'this method returned'
        assert_nothing_raised do
          my_object.test_attr = 'hello world'
        end
        assert_equal my_object.test_attr, 'hello world'
      end
      
    end    

  end

end