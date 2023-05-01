require "rubygems"
require "bundler/setup"
require "sinatra"
require "sinatra/contrib/all"
require "sinatra/cross_origin"
require "json"
require "dotenv/load"
require "uri"

class App < Sinatra::Base
   # Helpers
  helpers do
    def service
      ServiceClient::Base
    end

    def base_url(path)
      "#{ENV['API_BIBLE_HOST']}/#{path}"
    end

    def headers
      { 'api-key': ENV['API_BIBLE_KEY'] }
    end
  end

  # config CORS
  configure do
    enable :cross_origin
  end

  configure :development do
    set :port, '3001'
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

  before do
    content_type :json
  end

  # route - Root path
  get '/' do
    redirect '/v1/bibles'
  end

  # route - Books all
  get '/v1/bibles' do
    response = service.get(base_url(""), headers: headers)

    response.data.to_json
  end

  # route - Find book with abbreviation
  get '/v1/bibles/books' do
    response = service.get(base_url("books"), headers: headers)
    response.data.to_json
  end

  get '/v1/bibles/books/:bookId' do
    response = service.get(base_url("books/#{params[:bookId]}"), headers: headers)
    response.data.to_json
  end

  get '/v1/bibles/books/:bookId/chapters' do
    response = service.get(base_url("books/#{params[:bookId]}/chapters"), headers: headers)
    response.data.to_json
  end

  get '/v1/bibles/books/:bookId/chapters' do
    response = service.get(base_url("books/#{params[:bookId]}/chapters"), headers: headers)
    response.data.to_json
  end

  get '/v1/bibles/books/:bookId/chapters/:chapterId' do
    chapterId = URI.encode(params[:chapterId])
    
    response = service.get(base_url("chapters/#{chapterId}"), headers: headers)
    response.data.to_json
  end
end
  
