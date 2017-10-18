class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/show"
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])
    if params["figure"]["title_ids"]
      @figure.title_ids = params["figure"]["title_ids"]
      @figure.save
    elsif !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
      @figure.save
    end
    if params["figure"]["landmark_ids"]
      @figure.landmark_ids = params["figure"]["landmark_ids"]
      @figure.save
    elsif !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.save
    end
    redirect "/figures"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/edit"
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(name: params["figure"]["name"])
    if params["figure"]["title_ids"]
      @figure.title_ids = params["figure"]["title_ids"]
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.save
    end
    if params["figure"]["landmark_ids"]
      @figure.landmark_ids = params["figure"]["landmark_ids"]
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.save
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
