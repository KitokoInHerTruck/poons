class Admin::BaseController < ApplicationController
    before_action :authenticate_spree_user!
    layout 'admin'

  private

  def authenticate_user!
    unless current_spree_user && current_spree_user.admin?
      redirect_to root_path, alert: "Vous n'avez pas accès à cette section."
    end
  end
end