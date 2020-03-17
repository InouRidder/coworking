puts 'Running seeds in development'

puts 'Cleaning DB'

Request.destroy_all
Contract.destroy_all

Desk.destroy_all
User.destroy_all
Registration.destroy_all


puts 'Creating 30 Desks'

30.times { FactoryBot.create(:desk) }

puts 'Creating 50 requests & registrations'

50.times do
  status = Request::STATUSES.keys.select { |state| state != :accepted }.sample
  FactoryBot.create(:request, status: status.to_s)
end

to_confirm = rand(0..(Request.confirmed.count))
puts "randomly accepting #{to_confirm} requests, creating their contracts"

Request.confirmed.sample(to_confirm).map(&:accept!)
