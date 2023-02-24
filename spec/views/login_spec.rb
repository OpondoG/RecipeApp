require 'rails_helper'

RSpec.feature 'Log In', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', email: 'john@email.com', password: '123456', confirmed_at: Time.now)
    visit new_user_session_path
  end

  it 'should not sign me in when the credentials are not correct' do
    within('#new_user') do
      fill_in 'user_email', with: 'noemail@email.com'
      fill_in 'user_password', with: '123456'
    end
    click_button 'Log in'
    expect(current_path).to match new_user_session_path
    expect(page).to have_content 'Invalid Email or password'
  end
end
