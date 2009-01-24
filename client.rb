require "rubygems"
require "couchrest"

class CouchModel < CouchRest::Model
  self.use_database(CouchRest.database!("http://127.0.0.1:5984/sinatra"))
  
  timestamps!
end

class Project < CouchModel
  key_accessor :name, :notes, :start_date, :end_date, :completed
end

p = Project.new(:name => "Fuck You", :notes => "What do you want bitch?")
p.save