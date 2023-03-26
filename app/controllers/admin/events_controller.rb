class Admin::EventsController < ApplicationController


  before_action :authenticate_spree_user!, except: [:index, :user_events_show]

  def user_events_show
    @events = Event.all
    render :index
  end

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end  
  
  def subscribe
    @event = Event.find(params[:id])
    @event.users << current_user
    redirect_to @event
  end

  def unsubscribe
    @event = Event.find(params[:id])
    @event.users.delete(current_user)
    redirect_to @event
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end


  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  def events_show
  @event = Event.find_by_id(params[:id])
   if @event.nil?
      flash[:error] = "Cet événement n'existe pas"
      redirect_to events_path
  else
      render 'user_events_show'
   end
  end


  def event_params
    params.require(:event).permit(:event_id)
  end


  private

  def event_params
    params.require(:event).permit(:name, :description, :date_time, :end_time)
  end


