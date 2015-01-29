require 'user_spec_helper'

RSpec.describe App::User, type: :feature do
  context 'user detail' do
    it 'needs to be authorized before accessing' do
      visit '/profile'
      expect(page.status_code).to be 401
    end

    context 'when logged' do
      before :each do
        visit 'login'
        fill_in 'account', with: 'pepe'
        fill_in 'password', with: 'pepe'
        click_button 'login'
      end

      it 'shows welcome message' do
        expect(page).to have_content 'You were logged in pepe'
      end
    end
  end

  context 'logging in' do
    it 'has login page' do
      visit 'login'
      expect(page.status_code).to be 200
    end

    it 'can log in an user' do
      visit 'login'
      fill_in 'account', with: 'pepe'
      fill_in 'password', with: 'pepe'
      click_button 'login'
      expect(page.status_code).to be 200
    end
  end

  context 'logging out', focus: true do
    before :each do
      visit 'login'
      fill_in 'account', with: 'pepe'
      fill_in 'password', with: 'pepe'
      click_button 'login'
    end

    it 'can log out user' do
      visit 'logout'
      expect(page.status_code).to eq 200
    end

    it 'shows that user was logged out' do
      visit 'logout'
      expect(page).to have_content('User logged out')
    end
  end
end
