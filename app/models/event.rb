class Event < ApplicationRecord
    has_many :registrations
    has_many :spree_users, through: :registrations
    has_many :attendees, through: :registrations, source: :spree_user, class_name: 'Spree::User'
end
