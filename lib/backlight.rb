module Backlight
  ##
  # Class to edit backlight settings on intel-based systems
  #
  class Settings
    attr_reader :output
    attr_reader :max
    attr_reader :value

    ##
    # Initalizes a new Settings instance
    #
    # ==== Attributes
    #
    # * +output+ - The file to write the backlight value to
    # * +max+    - The file (or numeric value) to use for the max brightness
    #
    def initialize(output = '/sys/class/backlight/intel_backlight/brightness',
                   max = '/sys/class/backlight/intel_backlight/max_brightness')
      self.output = output
      self.max = max
      @value = IO.read(@output)
      # NOTE: we don't call self.value= here, because this would make it
      # impossible to recover from a bad value being written in the file
    end

    ##
    # Sets the output file for the backlight settings
    #
    # ==== Attributes
    #
    # * +file+ - The file to write the backlight value to
    #
    def output=(file)
      raise(ArgumentError, 'Out File Does Not Exist') unless File.exist?(file)
      @output = file
    end

    ##
    # Sets the maximum brightness value of the backlight.
    #
    # ==== Attributes
    #
    # * +max+ - This can either be the filename to read the max from, or a
    #           numeric maximum value.
    #
    def max=(max)
      if max.is_a? Numeric
        raise(ArgumentError, 'Max Brightness Cannot Be Less Than 0') if max < 0
        @max = max.to_i
      elsif max.is_a? String
        raise(ArgumentError, 'Max File Does Not Exist') unless File.exist?(max)
        @max = IO.read(max).to_i
      else
        raise(ArgumentError, 'Unknown Parameter Type')
      end
    end

    ##
    # Sets the value of the backlight, from zero to the set maximum
    #
    # ==== Attributes
    #
    # * +value+ - The value to set to the backlight output file
    #
    def value=(value)
      value = value.to_i
      raise(ArgumentError, 'Invalid Value') if value < 0 || value > @max
      IO.write(@output, value)
      @value = value
    end

    ##
    # Sets the backlight brightness as a percentage
    #
    def set(percent)
      self.value = percent * @max / 100
    end

    ##
    # Gets the backlight brightness as a percentage
    #
    def get
      100 * @value / @max
    end
  end
end
