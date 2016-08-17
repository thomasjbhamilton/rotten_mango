class MoviesController < ApplicationController

  before_action :restrict_access

  def index
    if params[:title]
      t = (params[:title] ? "%"+params[:title]+"%" : "")
      d = (params[:director] ? "%"+params[:director]+"%" : "")
      du = (params[:duration] ? params[:duration] : "")
      @movies = Movie.where("title like ?", t).where("director like ?", d)
      if du == '1'
        puts 'CHECKING FOR UNDER 90'
        @movies = @movies.where("runtime_in_minutes <= ?", 90)
      elsif du == '2'
        @movies = @movies.where("? < runtime_in_minutes < ?", 90, 120)
      elsif du == '3'
        @movies = @movies.where("runtime_in_minutes >= ?", 120)
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
     @movie.destroy
     redirect_to movies_path
   end

  protected

  def movie_params
    params.require(:movie).permit(
    :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remove_image, :scale
    )
 end

end
