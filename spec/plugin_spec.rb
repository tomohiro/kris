# encoding: utf-8

require 'spec_helper'
require 'kris/plugin'

module Kris
  describe Plugin do
    describe 'convert filename to class name' do
      it 'shoud get class name' do
        combination = {
          'foo.rb'         => 'Foo',
          'foo_bar.rb'     => 'FooBar',
          'foo_bar_baz.rb' => 'FooBarBaz',
          'foo/bar_baz.rb' => 'BarBaz'
        }

        combination.each do |filename, expect_class_name|
          class_name = Plugin.filename_classify(filename)
          class_name.must_equal(expect_class_name)
        end
      end
    end
  end
end
