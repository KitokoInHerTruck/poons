# frozen_string_literal: true

class SpreeUser < ActiveRecord::Base
  has_many :registrations
  has_many :events, through: :registrations
end

class UsersController < StoreController
  skip_before_action :set_current_order, only: :show, raise: false
  prepend_before_action :authorize_actions, only: :new

  include Taxonomies

  def admin?
    role == "admin"
  end

  def spree_user?
    self.is_a?(Spree::User)
  end

  def index
    @users = User.joins(registrations: :event).where(events: {name: 'Event Name'})
  end

  def show
    load_object
    @orders = @user.orders.complete.order('completed_at desc')
    # @spree_users = @user.find(params[:id])
    # @events = @user.events
  end

  def create
    @user = Spree::User.new(user_params)
    Rails.logger.info("Before saving user: #{@user}")
    if @user.save
      Rails.logger.info("User saved successfully: #{@user}")
      if current_order
        session[:guest_token] = nil
      end

      redirect_back_or_default(root_url)
    else
      Rails.logger.info("Le fichier CSS n'a pas pu être chargé")
      Rails.logger.info("Errors: #{@user.errors}")
      render :new
    end
  end

  def edit
    load_object
  end

  def update
    load_object
    if @user.update(user_params)
      spree_current_user.reload
      redirect_url = account_url

      if params[:user][:password].present?
        # this logic needed b/c devise wants to log us out after password changes
        if Spree::Auth::Config[:signout_after_password_change]
          redirect_url = login_url
        else
          bypass_sign_in(@user)
        end
      end
      redirect_to redirect_url, notice: I18n.t('spree.account_updated')
    else
      render :edit
    end
  end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to admin_events_path, notice: "Event deleted successfully."
    end
end

  private

  def user_params
    params.require(:user).permit(Spree::PermittedAttributes.user_attributes | [:email])
  end

  def load_object
    @user ||= Spree::User.find_by(id: spree_current_user&.id)
    authorize! params[:action].to_sym, @user
  end

  def authorize_actions
    authorize! params[:action].to_sym, Spree::User.new
  end

  def accurate_title
    I18n.t('spree.my_account')
  end

