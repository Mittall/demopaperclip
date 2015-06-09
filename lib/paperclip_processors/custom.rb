module Paperclip
  class Custom < Processor

    def initialize file, options = {}, attachment = nil
      super
      @file           = file
      @attachment     = attachment
      @is_polarized   = options[:is_polarized]
      @current_format = File.extname(@file.path) 
      @format         = options[:format]
      @basename       = File.basename(@file.path, @current_format)
    end

    def make
      temp_file = Tempfile.new([@basename, @format])
      temp_file.binmode
      if @is_polarized
        run_string =  "convert #{fromfile} -thumbnail 300x400  -bordercolor white -background white  +polaroid  #{tofile(temp_file)}"    
        Paperclip.run(run_string)
      end
      temp_file
    end

    def fromfile
      File.expand_path(@file.path)
    end

    def tofile(destination)
      File.expand_path(destination.path)
    end
  end
end

