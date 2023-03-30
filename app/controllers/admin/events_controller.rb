require 'spree/user'

class Admin::EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ new create edit update destroy ]
  

  def require_admin
    unless current_spree_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

  def index
    @events = Event.all
    @event = Event.first
    @taxons = Spree::Taxon.all
  end

  def new
    @event = Event.new
  end  

   def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to admin_events_path, notice: "Event created successfully."
    else
      render 'new'
    end
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

    def events_show
  @event = Event.find_by(id:params[:id])
   if @event.nil?
      flash[:error] = "Cet événement n'existe pas"
      redirect_to event_path
  else
      render 'events_show'
   end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params[:id])
      redirect_to admin_events_path, notice: "Event updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path, notice: "Event deleted successfully."
  end
end


  private


  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date_time, :end_time)
  end
  
  def check_authorization
    authorize! :manage, Event
  end

