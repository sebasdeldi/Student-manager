DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/notes_app.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end
=begin
class Grades
	include DataMapper::Resource
	property :id, Serial
	property :name, Text, :required => true
	property :current_grade, Integer, :required => true
	property :needed_grade, Integer, :required => true
	property :created_at, DateTime
	property :updated_at, DateTime
end
=end
DataMapper.finalize.auto_upgrade!
