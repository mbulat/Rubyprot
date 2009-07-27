# 
#  serializer.rb
#  rubyprot
#  
#  Created by Michael Bulat on 2009-07-23.
#  Copyright 2009 Michael Bulat. All rights reserved.
# 
module Rubyprot
  class Serializer #:nodoc:
    def self.serialize(object)
      file = File.new(Rubyprot.dump_path + "/serializer/" + object.class.name, "w")
      file.write(Marshal.dump(object))
      file.close      
    end
  end
end
