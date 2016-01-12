DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/notes_app.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end



class Grade
	include DataMapper::Resource
	property :id, Serial
	property :name, Text
	property :current_grade, Float
	property :needed_grade, Float
	property :missing_perc, Float
	property :created_at, DateTime
	property :updated_at, DateTime
end
DataMapper.finalize.auto_upgrade!
