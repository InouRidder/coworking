require 'rails_helper'

feature 'Freelancer views the waiting list' do

  scenario 'views the page' do
    visit root_path

    expect(page).to have_content("Waiting list")
    expect(page).to have_content("Desks")
  end

  scenario 'with confirmed email' do
    create(:desk)
    request = create(:request, status: 'confirmed')
    request.accept!

    visit root_path

    expect(page).to have_content(request.registration.email)
  end

  # scenario 'existing email' do
  #   create(:registration, email: 'cool@beans.fr')

  #   fill_in_form_with 'cool@beans.fr', 'Inou', 'Freelancer web dev learning french and code!', '+33712121212'

  #   expect(page).to have_content('Email has already been taken')
  # end

  # scenario 'invalid phone' do
  #   fill_in_form_with 'cool@beans.fr', 'Inou', 'Freelancer web dev learning french and code!', '+33212'

  #   expect(page).to have_content('Phone is invalid')
  # end

  # scenario 'invalid bio' do
  #   fill_in_form_with 'cool@beans.fr', 'Inou', '', '+33712121212'

  #   expect(page).to have_content('Bio is too short')
  # end
end
