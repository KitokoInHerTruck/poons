class Admin::EventsController < Spree::Admin::BaseController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ new create edit update destroy ]

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
    @event = Event.find(params[:id])
  end

  def update
    if @event.update(event_params[:id])
      redirect_to admin_events_path, notice: "Event updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to admin_events_path, notice: "Event deleted successfully."
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end

  def check_authorization
    authorize! :manage, Event
  end
