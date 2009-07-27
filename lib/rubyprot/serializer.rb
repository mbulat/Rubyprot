module Rubyprot
  class Serializer #:nodoc:
    def self.serialize(object)
      raise "Dump path attribute must be set" if Rubyprot.dump_path.nil?
      
      file = File.new(Rubyprot.dump_path + "/" + object.class.name, "w")
      file.write(Marshal.dump(object))
      file.close    
      
      file  
    end
  end
end
