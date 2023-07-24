require 'rails_helper'

RSpec.describe 'User index', type: :users do
  scenario 'can see the user photo' do
    user = User.first
    visit "/users/#{user.id}"
    expect(page.has_selector?('img.user-image')).to be(true)
    image = find('img', class: 'user-image')
    expect(image[:src]).to eq(user.photo)
  end

  scenario 'can see username' do
    user = User.first
    visit "/users/#{user.id}"

    expect(page).to have_content(user.name)
  end

  scenario 'can see number of posts' do
    user = User.first
    visit "/users/#{user.id}"

    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  scenario 'can see user bio' do
    user = User.first
    visit "/users/#{user.id}"

    expect(page).to have_content(user.bio)
  end

  scenario 'can see last three posts' do
    user = User.includes(:posts).find_by(name: 'Sasan')
    posts = user.posts

    visit "/users/#{user.id}"

    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'can see the show all posts button' do
    user = User.find_by(name: 'Sasan')

    visit "/users/#{user.id}"
    show_all_btn = all('input[type="Submit"]').filter { |input| input.value == 'Show All Posts'}
    expect(show_all_btn.length).to eq(1)
  end

  scenario 'When I click on a posts Show post button, I\'m redirected to that posts show page' do
    user = User.includes(:posts).find_by(name: 'Sasan')
    post = user.posts.first
    visit "/users/#{user.id}"
    page.find(id: "post-#{post.id}").click
    expect(page).to have_current_path("/users/#{user.id}/posts/#{post.id}")
  end

  scenario 'When I click on Show All Posts button, I\'m redirected to user\'s posts index page' do
    user = User.find_by(name: 'Sasan')

    visit "/users/#{user.id}"
    show_all_btn = all('input[type="Submit"]').filter { |input| input.value == 'Show All Posts'}
    expect(show_all_btn.length).to eq(1)
  end
end
