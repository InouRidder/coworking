class Email::ExpireRequestsJob < ApplicationJob
  queue_as :default

  def perform
    Request.unconfirmed.each do |request|
      days_since_last_email = (Date.today - request.last_confirmation_email_sent_at).to_i

      if days_since_last_email > 3.months
        request.expired!
      end
    end
  end
end
