class ItinerariesController < ApplicationController

helper_method :sort_column, :sort_direction
before_action :find_trip, only: [:index, :show, :new, :edit]

def show
  @itinerary = Itinerary.find(params[:id])
end

def index
	@itineraries = @trip.itineraries.order(sort_column + " " + sort_direction)
end

def new
	@itinerary = Itinerary.new(trip: @trip)
end

def update
	@itinerary = Itinerary.find(params[:id])
	@itinerary.user_id = current_user.id
	if @itinerary.update(itinerary_params)
		redirect_to action: 'show', id: @itinerary.id
	else
		render action: 'edit'
	end
end

def edit
	@itinerary = Itinerary.find(params[:id])
end

def create
	@itinerary = Itinerary.new(itinerary_params)
	@itinerary.user_id = current_user.id
  if @itinerary.save
    redirect_to action: 'show', id: @itinerary.id
  else
    render action: 'new'
  end
end

def destroy
	@itinerary = Itinerary.find(params[:id])
	@itinerary.destroy
	flash[:notice] = "You have successfully deleted itinerary"
	redirect_to action: 'index'
end

private
	
	def itinerary_params
		params.require(:itinerary).permit(:location, :travel_on, :estimated_cost, :trip_id)
	end

	def sort_column
  	Itinerary.column_names.include?(params[:sort]) ? params[:sort] : "location"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def find_trip
  	@trip = Trip.find(params[:trip_id])
  end

end