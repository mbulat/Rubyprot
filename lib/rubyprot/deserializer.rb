module Rubyprot
  class Deserializer #:nodoc:
    def self.deserialize(name)
      raise "Dump path attribute must be set" unless Rubyprot.dump_path
      
      File.open(Rubyprot.dump_path + "/deserializer/" + name) do |f|
        Marshal.load(f)
      end
    end
  end
end
