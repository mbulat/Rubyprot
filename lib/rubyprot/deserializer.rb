# 
#  serializer.rb
#  rubyprot
#  
#  Created by Michael Bulat on 2009-07-23.
#  Copyright 2009 Michael Bulat. All rights reserved.
# 
module Rubyprot
  class Deserializer #:nodoc:
    def self.deserialize(name)
      File.open(Rubyprot.dump_path + "/deserializer/" + name) do |f|
        Marshal.load(f)
      end
    end
  end
end
