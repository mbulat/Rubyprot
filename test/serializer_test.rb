require 'test_helper'

class SerializerTest < Test::Unit::TestCase
  context "Rubyprot serializer" do
    setup do
      @test_file_path = "test/test_files/dump"
      @object_name = "Person"
      @object_name_ends_in_s = "TestClass"
    end
    
    teardown do
      unless Rubyprot.dump_path.nil?
        FileUtils.rmtree(Rubyprot.dump_path)
        Rubyprot.dump_path = nil
      end
    end    
    
    should "raise error if dump path not set" do
      assert_raise RuntimeError do
        object = Person.new      
        Rubyprot.serialize(object)
      end
    end
    
    should "create marshalled file from object" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      object = Person.new      
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
      
      object = Person.new
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
    
    should "return a string name" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      object = Person.new
      name = Rubyprot.serialize(object)
      
      assert_kind_of String, name
    end

    should "return string plural name for array" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      array = Array.new
      object = Person.new
      array[0] = object
      array[1] = object
      
      name = Rubyprot.serialize(array)
      
      assert_kind_of String, name
      assert name == "Persons"
    end
    
    should "return string plural name for array from object ending in s" do
      Rubyprot.configure do |config|
        Rubyprot.dump_path = @test_file_path
      end
      
      array = Array.new
      object = TestClass.new
      array[0] = object
      array[1] = object
      
      name = Rubyprot.serialize(array)
      
      assert_kind_of String, name
      assert name == "TestClasses"
    end    
  end
  

end