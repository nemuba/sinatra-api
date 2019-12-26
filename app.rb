require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/cross_origin"
require "rest-client"

  # Helpers
  helpers do
    def base_url(path)
      "https://bibleapi.co/api#{path}"
    end
  end

  # config CORS
  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  # route - Root path
  get '/' do
    redirect '/books'
  end

  # route - Books all
  get '/books' do
    # content_type :json
    response = RestClient.get(base_url(request.path_info))
    response
  end

  # route - Find book with abbreviation
  get '/books/:abbrev' do
    # content_type :json
    response = RestClient.get(base_url(request.path_info))
    response
  end

  # route - Chapters of the book
  get '/verses/:version/:book/:chapter' do
    # content_type :json
    response = RestClient.get(base_url(request.path_info))
    response
  end

  # route - Verses of the chapter
  get '/verses/:version/:book/:chapter/:number' do
    # content_type :json
    response = RestClient.get(base_url(request.path_info))
    response
  end
