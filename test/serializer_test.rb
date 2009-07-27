require 'test_helper'

class SerializerTest < Test::Unit::TestCase
  context "Rubyprot serializer" do
    setup do
      @test_file_path = "test/test_files/dump"
      @object_name = "TestClass"
    end
    
    teardown do
      unless Rubyprot.dump_path.nil?
        FileUtils.rmtree(Rubyprot.dump_path)
        Rubyprot.dump_path = nil
      end
    end    
    
    should "raise error if dump path not set" do
      assert_raise RuntimeError do
        object = TestClass.new      
        Rubyprot.serialize(object)
      end
    end
    
    should "create marshalled file from object" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      object = TestClass.new      
      Rubyprot.serialize(object)
      
      assert_nothing_raised do
        file = File.open(@test_file_path + "/" + @object_name)
      end
      
      FileUtils.rmtree(Rubyprot.dump_path)
    end    

    should "have valid marshaled file" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      object = TestClass.new
      Rubyprot.serialize(object)
      
      assert_nothing_raised do
        file = File.open(@test_file_path + "/" + @object_name)
        new_object = Marshal.load(file)
        file.close

        assert_equal new_object.test_method, 'this method returned'
        assert_nothing_raised do
          new_object.test_attr = 'hello world'
        end
        assert_equal new_object.test_attr, 'hello world'
      end
    end
    
    should "return a file object" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      object = TestClass.new
      f = Rubyprot.serialize(object)
      
      assert_kind_of File, f
    end
  end
  

end