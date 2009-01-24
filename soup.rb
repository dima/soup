require "rubygems"
require "sinatra"
require "couchrest"
require "activesupport"
require "thin"

class CouchModel < CouchRest::Model
  self.use_database(CouchRest.database!("http://127.0.0.1:5984/sinatra"))
  
  timestamps!
end

class Project < CouchModel
  key_accessor :name, :notes, :completed
end

class Task < CouchModel
  key_accessor :name, :notes, :project_id
end

mime :json, "application/json"
 
error do  
  puts "Sorry there was a nasty error:"
  puts request.env['sinatra.error']
end

#curl -i -XGET http://localhost:4567/projects.json
get '/:model.json' do
  "#{params[:model]}".singularize.camelize.constantize.all.to_json
end

#curl -i -XGET http://localhost:4567/projects/7fe3d9118192d1e51487f754d5eaed3a.json
get '/:model/:id.json' do
 "#{params[:model]}".singularize.camelize.constantize.get(params[:id]).to_json
end

#curl -i -XPOST -d"{\"name\":\"Demo Project\"}" http://localhost:4567/projects.json
post '/:model.json' do
  record = "#{params[:model]}".singularize.camelize.constantize.new(JSON.parse(request.body.string))
  record.save
  record.to_json
end

#curl -i -XPUT -d"{\"name\":\"Random Project\"}" http://localhost:4567/projects/7fe3d9118192d1e51487f754d5eaed3a.json
put '/:model/:id.json' do
  record = "#{params[:model]}".singularize.camelize.constantize.get(params[:id])
  record.update_attributes(JSON.parse(request.body.string))
  record.to_json
end

#curl -i -XDELETE http://localhost:4567/projects/7fe3d9118192d1e51487f754d5eaed3a.json
delete '/:model/:id.json' do
  record = "#{params[:model]}".singularize.camelize.constantize.get(params[:id])
  result = record.to_json
  record.destroy
  result
end