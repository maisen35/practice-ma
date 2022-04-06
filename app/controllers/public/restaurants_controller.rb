class Public::RestaurantsController < Public::Base

  before_action :exist_public_restaurant?, only: %i[show]

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

end
