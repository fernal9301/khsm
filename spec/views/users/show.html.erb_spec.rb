require 'rails_helper'

# Тест на шаблон users/show.html.erb

RSpec.describe 'users/show', type: :view do
  context '#usual user' do
    let(:user) { FactoryGirl.build(:user, name: 'Светлана') }

    it 'renders player name' do
      assign(:user, user)

      render

      expect(rendered).to match 'Светлана'
    end

    it 'renders player link to change name & password' do
      assign(:user, user)

      allow(view).to receive(:current_user).and_return(user)
      render

      expect(rendered).to match 'Сменить имя и пароль'
    end

    it 'renders player games' do
      assign(:user, user)

      stub_template 'users/_game.html.erb' => 'User game goes here'
      render partial: 'users/game'

      expect(rendered).to match /User game goes here/
    end
  end

  context '#anonymous' do
    let(:user) { FactoryGirl.build(:user, name: 'Светлана') }

    it 'not render link to change name & password' do
      assign(:user, user)

      allow(view).to receive(:current_user).and_return(nil)
      render

      expect(rendered).not_to match 'Сменить имя и пароль'
    end
  end
end