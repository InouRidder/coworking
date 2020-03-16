puts 'Running seeds in development'

puts 'Cleaning DB'

Request.destroy_all
Contract.destroy_all

Desk.destroy_all
User.destroy_all
Registration.destroy_all


puts 'Creating 10 Desks'

10.times { FactoryBot.create(:desk) }

puts 'Creating 15 requests & registrations'

15.times do
  status = Request::STATUSES.keys.select { |state| state != :accepted }.sample
  FactoryBot.create(:request, status: status.to_s)
end

puts "Accepting #{Request.confirmed.count} requests, creating their contracts"

# Request.confirmed.map(&:accept!)
