require 'test_files/models/test_module'

class TestClass < TestModule::TestClassThree
  attr_accessor :test_attr
    
  def test_method
    return 'this method returned'
  end
end