require 'data_mapper'
require 'sinatra'
require_relative ("./data_base_mng.rb")
require_relative ("calculator_logic.rb")
require 'sinatra/flash'

enable :sessions

SITE_TITLE = "Vago"
SITE_DESCRIPTION = "'cause you are too dumb to remember"

get '/' do
    @notes = Note.all :order => :id.desc
    @grades = Grade.all :order => :id.desc
    @title = "All Notes & Grades"
    erb :home
end


post '/notes' do

    n = Note.new
    n.content = params[:content]
    n.created_at = Time.now
    n.updated_at = Time.now

    if n.save
        #flash[:notice] = 'Note created successfully.'
        redirect '/'
    else
        flash[:error] = 'Failed to save note.'
        redirect '/'
    end
end

post '/grades' do
  c = Calculator.new(params[:grades].to_s, params[:percentage].to_s)

    g = Grade.new
    g.name = params[:subject_name]
    g.current_grade = c.r
    g.needed_grade = c.needed
    g.missing_perc = c.perc_rest
    g.created_at = Time.now
    g.updated_at = Time.now


    if g.save
        #flash[:notice] = 'Note created successfully.'
        redirect '/'
    else
        flash[:error] = 'Failed to save subject.'
        redirect '/'
    end
end


get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note #{params[:id]}"
  erb :edit
end


put '/:id' do
  n = Note.get params[:id]
  n.content = params[:content]
  n.updated_at = Time.now
  if n.save
      #flash[:notice] = 'Note updated successfully.'
  else
      flash[:error] = 'Failed to update note.'
  end
  redirect '/'
end

get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Confirm deletion of note #{params[:id]}"
  erb :delete
end

delete '/:id' do
	n = Note.get params[:id]


	if n.destroy
	    #flash[:notice] = 'Note deleted successfully.'
	else
	    flash[:error] = 'Failed to delete note.'
	end
  redirect '/'
end

get '/grades/:id/delete' do
  @grade = Grade.get params[:id]
  @title = "Confirm deletion of grade #{params[:id]}"
  erb :delete_grade
end

delete '/grades/:id' do
  g = Grade.get params[:id]

  if g.destroy
      #flash[:notice] = 'Note deleted successfully.'
  else
      flash[:error] = 'Failed to delete grade.'
  end
  redirect '/'
end

get '/:id/complete' do
  n = Note.get params[:id]
  n.complete = n.complete ? 0 : 1
  n.updated_at = Time.now
  if n.save
      #flash[:notice] = 'Note clompleted successfully.'
  else
      flash[:error] = 'Failed to complete note.'
  end
  redirect '/'
end

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end

