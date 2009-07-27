module Rubyprot
  class Deserializer #:nodoc:
    def self.deserialize(file)
      if file.closed? 
        f = File.open(file.path, 'r')
        object = Marshal.load(f)
        f.close
        return object 
      else
        object = Marshal.load(file)
        return object
      end
    end
  end
end
