#!/usr/bin/env ruby

require_relative '../lib/backlight.rb'
require 'test/unit'

class TestBacklight < Test::Unit::TestCase
  # TODO: define constant for max/output file paths
  def setup
    IO.write('test/output', '0')
    IO.write('test/max', '3000')
  end # TODO: delete these files after all tests?

  def test_defaults
  end

  def test_set_output
    backlight = Backlight::Settings.new
    backlight.output = 'test/output'
    assert_equal(backlight.output, 'test/output')
  end

  def test_set_output_error
    backlight = Backlight::Settings.new
    assert_raise(ArgumentError) { backlight.output = 'test/nofile' }
  end

  def test_set_max
    backlight = Backlight::Settings.new
    backlight.max = 2000
    assert_equal(backlight.max, 2000)
  end

  def test_set_max_error
    backlight = Backlight::Settings.new
    assert_raise(ArgumentError) { backlight.max = -30 }
  end

  def test_set_max_file
    backlight = Backlight::Settings.new
    backlight.max = 'test/max'
    assert_equal(backlight.max, IO.read('test/max').to_i)
  end

  def test_set_max_file_error
    backlight = Backlight::Settings.new
    assert_raise(ArgumentError) { backlight.max = 'test/nofile' }
  end

  def test_set_value
    backlight = Backlight::Settings.new
    backlight.output = 'test/output'
    backlight.max = 3000
    backlight.value = 2000
    assert_equal(backlight.value, 2000)
  end

  def test_set_value_error
    backlight = Backlight::Settings.new
    backlight.output = 'test/output'
    backlight.max = 3000
    assert_raise(ArgumentError) { backlight.value = -100 }
    assert_raise(ArgumentError) { backlight.value = 5000 }
  end

  def test_set_percent
    backlight = Backlight::Settings.new
    backlight.output = 'test/output'
    backlight.max = 2000
    backlight.set 30
    assert_equal(backlight.value, 600)
    assert_equal(backlight.get, 30)
  end
end
