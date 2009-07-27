module Rubyprot
  class Serializer #:nodoc:
    def self.serialize(object)
      raise "Dump path attribute must be set" if Rubyprot.dump_path.nil?
      
      if object.is_a?(Array) then
        if object[0].class.name.rindex("s") == object[0].class.name.length - 1
          plural_string = "es"
        else
          plural_string = "s"
        end
        file_name = object[0].class.name + plural_string
      else       
        file_name = object.class.name
      end
        file = File.new(Rubyprot.dump_path + "/" + file_name, "w")
        file.write(Marshal.dump(object))
        file.close    
      
      file_name
    end
  end
end
