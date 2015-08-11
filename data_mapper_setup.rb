require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

# DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
DataMapper.setup(:default, "postgres://rzlxlvwqlxmkgb:MxcDlqCMpxYodhHzql3ZziUs5A@ec2-54-197-230-210.compute-1.amazonaws.com:5432/d2i2sm80arhpjo"
require './app/models/link'

DataMapper.finalize

DataMapper.auto_upgrade!
