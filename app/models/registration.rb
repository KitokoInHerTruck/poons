class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :spree_user, class_name: 'Spree::User'
end
