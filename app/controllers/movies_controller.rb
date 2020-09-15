class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    user_ratings = params[:ratings]
    sort_type = params[:sort_type]
    
    if user_ratings.length == 0
      user_ratings = @all_ratings
    end 
    
    if sort_type == 'title'
      @movies = Movie.where(rating: user_ratings.keys)
      @title_css = 'hilite'
      @release_css = nil 
    elsif sort_type == 'release_date'
      @movies = Movie.where(rating: user_ratings.keys)
      @title_css = nil
      @release_css = 'hilite'
    else
      @movies = Movie.where(rating: user_ratings.keys)
      @title_css = nil 
      @release_css = nil
    end

      
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
