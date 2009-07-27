require 'test_helper'

class SerializerTest < Test::Unit::TestCase
  context "Rubyprot serializer" do
    setup do
      @test_file_path = "test/test_files/dump"
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
    end
    
    should "create marshalled file from object" do
      object = TestClass.new
      
      Rubyprot.serialize(object)
      
      assert_nothing_raised do
        file = File.open("test/test_files/dump/serializer/TestClass")
      end
      
      FileUtils.rmtree(Rubyprot.dump_path)
    end    

    should "have valid marshaled file" do
      object = TestClass.new
      
      Rubyprot.serialize(object)
      
      assert_nothing_raised do
        file = File.open("test/test_files/dump/serializer/TestClass")
        new_object = Marshal.load(file)
        file.close

        assert_equal new_object.test_method, 'this method returned'
        assert_nothing_raised do
          new_object.test_attr = 'hello world'
        end
        assert_equal new_object.test_attr, 'hello world'
      end
      
      FileUtils.rmtree(Rubyprot.dump_path)
    end
  end
end