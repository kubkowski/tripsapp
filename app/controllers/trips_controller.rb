class TripsController < ApplicationController

helper_method :sort_column, :sort_direction

def show
  @trip = Trip.find(params[:id])
end

def index
	@trips = Trip.order([sort_column, sort_direction].join(" "))
end

def new
	@trip = Trip.new
end

def update
	@trip = Trip.find(params[:id])
	if @trip.update(trips_params)
		redirect_to action: 'show', id: @trip.id
	else
		render action: 'edit'
	end
end

def edit
	@trip = Trip.find(params[:id])
end

def create
	@trip = Trip.new(trips_params)
  if @trip.save
    redirect_to action: 'show', id: @trip.id
  else
    render action: 'new'
  end
end

def destroy
	@trip = Trip.find(params[:id])
	@trip.destroy
	flash[:notice] = "You have successfully deleted trip"
	redirect_to action: 'index'
end

private
	
	def trips_params
		params.require(:trip).permit(:name)
	end

	def sort_column
  	Trip.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end