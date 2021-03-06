class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    unless @passenger 
      redirect_to passengers_path
      return
    end

    @trip = Trip.new
    @trips = @passenger.trips
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to passengers_path
    else
      render :new
    end
  end

  def edit
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)

    unless @passenger 
      redirect_to passengers_path
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    unless @passenger 
      redirect_to passengers_path
      return
    end

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
    else
      render :edit
    end
  end

  def destroy
    @passenger = Passenger.find_by(id: params[:id])
    @passenger.destroy
    redirect_to passengers_path
  end

  private
  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num)
  end
end
