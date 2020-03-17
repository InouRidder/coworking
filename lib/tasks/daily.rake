namespace :daily do
  desc "Run the daily tasks"
  task run: :environment do

    puts 'Expiring old requests...'
    Requests::ExpireRequestsJob.perform_now

    puts 'Requesting confirmation from confirmed requests in the waiting list'
    Requests::RequestConfirmationsJob.perform_now

    puts 'Renewing or expiring contracts...'
    Contracts::RenewJob.perform_now

    puts 'Distributing free desks...'
    Desks::DistributionJob.perform_now

    puts "That's it for today!"
  end
end
