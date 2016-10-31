module AccountsLogs
    extend ActiveSupport::Concern

    included do
        after_update :add_logs
    end

    def add_logs
        Log.create!(user_id: id, message: "#{email} Logged in!") if last_sign_in_at_changed?
    end
end
