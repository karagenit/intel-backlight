module Backlight
  class Settings

    attr_reader :output
    attr_reader :max
    attr_reader :value

    def initialize(output = '/sys/class/backlight/intel_backlight/brightness', max = '/sys/class/backlight/intel_backlight/max_brightness')
      self.output = output
      self.max = max
    end

    def output=(file)
      raise(ArgumentError, 'Output File Does Not Exist') unless File.exist?(file)
      @output = file
    end

    def max=(max)
      if max.is_a? Numeric
        raise(ArgumentError, 'Max Brightness Cannot Be Less Than 0') if max < 0
        @max = max
      elsif max.is_a? String
        raise(ArgumentError, 'Max Brightness File Does Not Exist') unless File.exist?(max)
        @max = IO.read(max).to_i
      end
    end

    def value=(value)
      raise(ArgumentError, 'Invalid Value') if value < 0 || value > @max
      IO.write(@output, value)
    end

    def set(percent)
      self.value = percent * @max / 100
    end

  end
end
