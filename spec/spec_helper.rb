require 'coveralls'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '.gems'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'vcardio'
