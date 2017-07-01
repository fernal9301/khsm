require 'rails_helper'

RSpec.feature 'USER looks game rating', type: :feature do
  let!(:user) { FactoryGirl.create(:user, name: 'Настя', balance: '100') }


  scenario 'successfully' do
    visit '/'

    expect(page).to have_content 'Настя'
    expect(page).to have_content '100'
    #save_and_open_page
  end
end
