require 'rails_helper'

RSpec.describe 'User index', type: :users do
  scenario 'can see username of all other users' do
    visit 'users#index'
    users = User.all

    users.each do |user|
      expect(page).to have_content(user.name)
    end
  end
  scenario 'all users have photos' do
    visit 'users#index'
    users = User.all

    users.each do |user|
      images = all('img').map { |img| img[:src] }
      expect(images.include?(user.photo)).to be(true)
    end
  end

  scenario 'see the number of posts each user have' do
    visit 'users#index'
    users = User.all

    users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  scenario 'when I click on "show user" a user i\'m redirected to user page' do
    users = User.all
    users.each do |user|
      visit 'users#index'
      user_link = "/users/#{user.id}"
      click_link('Show user', href: user_link)
      expect(page).to have_current_path(user_link)
    end
  end
end
