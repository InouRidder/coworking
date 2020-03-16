# Preview all emails at http://localhost:3000/rails/mailers/request
class RequestPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request/send_confirm_interest
  def send_confirm_interest
    RequestMailer.send_confirm_interest
  end

end
