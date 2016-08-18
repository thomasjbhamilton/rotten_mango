class MoviesController < ApplicationController

  before_action :restrict_access

  def index

    if params
      t = (params[:search] ? "%"+params[:search]+"%" : "%")
      du = (params[:duration] ? params[:duration] : "")
      @movies = Movie.where("title like ? OR director like ?", t, t)

      case du
        when '1' then @movies = @movies.duration_search_1
        when '2' then @movies = @movies.duration_search_2
        when '3' then @movies = @movies.duration_search_3
      end

    else
      @movies = Movie.all.order('created_at DESC')
    end

  end

 def show
   @movie = Movie.find(params[:id])
 end

 def new
   @movie = Movie.new
 end

 def edit
   @movie = Movie.find(params[:id])
 end

 def create
   @movie = Movie.new(movie_params)

   if @movie.save
     redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
   else
     render :new
   end
 end

 def update
   @movie = Movie.find(params[:id])

   if @movie.update_attributes(movie_params)
     redirect_to movie_path(@movie)
   else
     render :edit
   end
 end

   def destroy
     @movie = Movie.find(params[:id])
     @movie.reviews.destroy
     @movie.destroy
     redirect_to movies_path
   end

  protected

  def movie_params
    params.require(:movie).permit(
    :title, :release_date, :director, :runtime_in_minutes,
    :poster_image_url, :description, :image, :remove_image,
    :scale
    )
  end

end
