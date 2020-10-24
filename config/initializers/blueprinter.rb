require 'oj' # you can skip this if OJ has already been required.

Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
  config.datetime_format = ->(datetime) { datetime.nil? ? datetime : datetime.iso8601 }

end
