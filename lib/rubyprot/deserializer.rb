module Rubyprot
  class Deserializer #:nodoc:
    def self.deserialize(name)
      raise "dump_path attribute must be set" unless Rubyprot.dump_path
      
      File.open(Rubyprot.dump_path + "/" + name) do |f|
        Marshal.load(f)
      end
    end
  end
end
