class Admin::EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:show, :register, :unregister]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path, notice: "Event created successfully."
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to admin_events_path, notice: "Event updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path, notice: "Event deleted successfully."
  end

  def register
    @event.registrations.create(user: current_user)
    redirect_to @event, notice: "You have been registered for the event."
  end

  def unregister
    registration = @event.registrations.find_by(user: current_user)
    registration.destroy if registration
    redirect_to @event, notice: "You have been unregistered from the event."
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def require_admin
    redirect_to root_path, alert: "You must be an admin to access this page." unless current_spree_user && current_spree_user.admin?
  end
end