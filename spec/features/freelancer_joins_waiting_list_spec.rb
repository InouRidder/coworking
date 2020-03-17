require 'rails_helper'

feature 'Visitor joins the waiting list' do
  scenario 'with valid params' do
    fill_in_form_with 'valid@example.com', 'Inou', 'Freelancer web dev learning french and code!', '+33712121212'

    expect(page).to have_content("Confirm your email to get on the waiting list")
  end

  scenario 'with invalid email' do
    fill_in_form_with 'not-an-email', 'Inou', 'Freelancer web dev learning french and code!', '+33712121212'

    expect(page).to have_content('Email is invalid')
  end

  scenario 'existing email' do
    create(:registration, email: 'cool@beans.fr')

    fill_in_form_with 'cool@beans.fr', 'Inou', 'Freelancer web dev learning french and code!', '+33712121212'

    expect(page).to have_content('Email has already been taken')
  end

  scenario 'invalid phone' do
    fill_in_form_with 'cool@beans.fr', 'Inou', 'Freelancer web dev learning french and code!', '+33212'

    expect(page).to have_content('Phone is invalid')
  end

  scenario 'invalid bio' do
    fill_in_form_with 'cool@beans.fr', 'Inou', '', '+33712121212'

    expect(page).to have_content('Bio is too short')
  end

  def fill_in_form_with(email, name, bio, phone)
    visit new_registration_path
    fill_in 'Email', with: email
    fill_in 'Name', with: name
    fill_in 'Bio', with: bio
    fill_in 'Phone', with: phone
    click_button 'Apply'
  end
end
