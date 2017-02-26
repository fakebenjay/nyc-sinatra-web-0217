class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])

    if !params["title"]["name"].empty?
      @new_title = Title.find_or_create_by(name: params["title"]["name"])
      @figure.titles << @new_title
    end

    if !params["landmark"]["name"].empty?
      @new_landmark = Landmark.find_or_create_by(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
      @figure.landmarks << @new_landmark
    end

    if params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |t|
        @title = Title.find(t.to_i)
        @figure.titles << @title
      end
    end

    if params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |l|
        @landmark = Landmark.find(l.to_i)
        @figure.landmarks << @landmark
      end
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])

    if !params["title"]["name"].empty?
      @new_title = Title.find_or_create_by(name: params["title"]["name"])
      @figure.titles << @new_title
    end

    if !params["landmark"]["name"].empty?
      @new_landmark = Landmark.find_or_create_by(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
      @figure.landmarks << @new_landmark
    end

    if params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |t|
        @title = Title.find(t.to_i)
        @figure.titles << @title
      end
    end

    if params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |l|
        @landmark = Landmark.find(l.to_i)
        @figure.landmarks << @landmark
      end
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
