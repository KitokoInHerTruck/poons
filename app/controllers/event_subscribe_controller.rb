class EventSubscribeController < ApplicationController
        def new
            @event = Event.find(params[:event_id])
            if current_spree_user
            @subscribe = @event.subscribe.new(user: current_spree_user)
            render :new
            else
            redirect_to new_spree_user_registration_path
            end
        end
        
  private

  def subscribe_params
    params.require(:subscribe).permit(:email, :username)
  end
end
 
end
