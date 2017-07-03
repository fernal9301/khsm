require 'rails_helper'

RSpec.feature 'USER answers wrong', type: :feature do
  let!(:user) { FactoryGirl.create :user, name: 'Саша', id: 1, balance: 200 }

  let!(:questions) do
    (0..14).to_a.map do |i|
      FactoryGirl.create(
        :question, level: i,
        text: "Когда была куликовская битва номер #{i}?",
        answer1: '1380', answer2: '1381', answer3: '1382', answer4: '1383'
      )
    end
  end

  before(:each) do
    login_as user
  end

  scenario 'successfully' do
    visit '/'

    click_link 'Новая игра'

    expect(page).to have_current_path '/games/1'

    expect(page).to have_content 'Когда была куликовская битва номер 0?'

    click_link '1380'
    click_link '1380'
    click_link '1380'
    click_link '1381'

    expect(page).to have_current_path '/users/1'

    expect(page).to have_content 'проигрыш'
    expect(page).to have_content 'Игра закончена, ваш приз 0 ₽'
    #save_and_open_page
  end
end
