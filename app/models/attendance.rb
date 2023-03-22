class Attendance < ApplicationRecord
      def self.get_event_and_registration_data
    self.find_by_sql("SELECT events.name AS event_name, registrations.spree_user_id
                      FROM events
                      INNER JOIN registrations
                      ON events.id = registrations.event_id")
  end
end
