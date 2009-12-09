require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubyprot'
require 'test_files/models/test_class'
require 'test_files/models/test_class_two'
require 'test_files/models/test_module'
require 'test_files/models/person'

class Test::Unit::TestCase
end
