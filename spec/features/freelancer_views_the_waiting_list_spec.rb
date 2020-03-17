require 'rails_helper'

feature 'Freelancer views the waiting list' do

  scenario 'views the page' do
    visit root_path

    expect(page).to have_content("Waiting list")
    expect(page).to have_content("Desks")
  end

  scenario 'unconfirmed email views waiting list' do
    create(:desk)
    request = create(:request, status: 'unconfirmed')

    visit root_path

    expect(page).not_to have_content(request.registration.email)
  end

  scenario 'with confirmed email on the waiting list' do
    create(:desk)
    request = create(:request, status: 'confirmed')

    visit root_path
    within '#waiting-list' do
      expect(page).to have_content(request.registration.email)
    end
  end

  scenario 'request accepted, freelancer has a desk' do
    create(:desk)
    request = create(:request, status: 'confirmed')
    request.accept!

    visit root_path

    within '#desks' do
      expect(page).to have_content(request.registration.email)
    end
  end
end
