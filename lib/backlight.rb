module Backlight
  ##
  # Class to edit backlight settings on intel-based systems
  #
  class Settings
    attr_reader :output
    attr_reader :max
    attr_reader :value

    def initialize(output = '/sys/class/backlight/intel_backlight/brightness',
                   max = '/sys/class/backlight/intel_backlight/max_brightness')
      self.output = output
      self.max = max
      @value = IO.read(@output)
      # NOTE: we don't call self.value= here, because this would make it
      # impossible to recover from a bad value being written in the file
    end

    def output=(file)
      raise(ArgumentError, 'Out File Does Not Exist') unless File.exist?(file)
      @output = file
    end

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

    def value=(value)
      value = value.to_i
      raise(ArgumentError, 'Invalid Value') if value < 0 || value > @max
      IO.write(@output, value)
      @value = value
    end

    def set(percent)
      self.value = percent * @max / 100
    end

    def get
      100 * @value / @max
    end
  end
end
