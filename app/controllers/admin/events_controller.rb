class Admin::EventsController < ApplicationController
  include Admin::EventsHelper

  before_action :set_event, only: [:admin_events_show, :edit, :update, :destroy]
  before_action :require_admin, except: [:user_events_show, :new, :register, :unregister]
  before_action :authenticate_spree_user!, except: [:index, :show]

  def events_user_events_show
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
    @event.users << current_user
    redirect_to @event, notice: "Vous êtes maintenant inscrit à cet événement."
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

  def admin_events_show
    @event = Event.find(params[:id])
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

  def user_events_show
    @events = Event.all
  end

  def user_event_params
    params.require(:user_event).permit(:event_id)
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date_time, :end_time)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def require_admin
    redirect_to root_path, alert: "You must be an admin to access this page." unless current_spree_user && current_spree_user.admin?
  end
end