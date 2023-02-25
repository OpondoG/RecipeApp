require 'rails_helper'

RSpec.feature 'Public Recipes', type: :feature do
  before :each do
    @user = User.create(name: 'John Doe', email: 'johnmail@email.com', password: '123456', confirmed_at: Time.now)
    @recipe = Recipe.create(user: @user, name: 'Empirial Broth', preparation_time: 5, cooking_time: 5,
                            description: 'Not the greatest food but Maarva made it special', public: true)

    visit new_user_session_path

    within('#new_user') do
      fill_in 'user_email', with: 'johnmail@email.com'
      fill_in 'user_password', with: '123456'
    end
    click_button 'Log in'
  end

  it 'visits public recipes' do
    visit public_recipes_path
    expect(page).to have_content 'Empirial Broth'
  end
end
