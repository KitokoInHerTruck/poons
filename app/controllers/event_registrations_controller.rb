class EventRegistrationsController < ApplicationController
        def new
            @event = Event.find(params[:event_id])
            if current_spree_user
            @registration = @event.registrations.new(user: current_spree_user)
            render :new
            else
            redirect_to new_spree_user_registration_path
            end
        end
        
  private

  def registration_params
    params.require(:registration).permit(:email, :username)
  end
end
 
end
