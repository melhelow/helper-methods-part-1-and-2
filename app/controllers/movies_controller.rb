class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new

  
  end

  def index
  @movies = Movie.all.order(created_at: :desc)

  respond_to do |format|
    format.json do
      render json: @movies
    end

    format.html do
      render template: "movies/index"
    end
  end
end


  def show
   @the_movie = Movie.find(params.fetch(:id))
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to movies_url, { notice: "Movie was successfully created." }
    else
      render template: "movies/new"
    end
  end

  def edit
   @the_movie = Movie.find(params.fetch(:id))
  end

def update
  @the_movie = Movie.find(params[:id])

  # Use params["query_title"] directly; it returns nil if missing instead of raising error
  title_param = params["query_title"]
  description_param = params["query_description"]

  # Optionally check presence to avoid saving invalid data
  if title_param.blank?
    flash.now[:alert] = "Title cannot be blank"
    return render :edit
  end

  @the_movie.title = title_param
  @the_movie.description = description_param

  if @the_movie.valid?
    @the_movie.save
    redirect_to movie_url(@the_movie), notice: "Movie updated successfully."
  else
    flash.now[:alert] = "Movie failed to update successfully."
    render :edit
  end
end




def destroy
  @the_movie = Movie.find(params.fetch(:id))

  @the_movie.destroy

  redirect_to(movies_url, notice: "Movie deleted successfully.")
end


end
