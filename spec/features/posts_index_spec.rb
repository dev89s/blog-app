require 'rails_helper'

RSpec.describe 'User index', type: :posts do
  scenario 'can see the user photo' do
    user = User.first
    visit "/users/#{user.id}/posts"
    expect(page.has_selector?('img.user-image')).to be(true)
    image = find('img', class: 'user-image')
    expect(image[:src]).to eq(user.photo)
  end

  scenario 'can see username' do
    user = User.first
    visit "/users/#{user.id}/posts"

    expect(page).to have_content(user.name)
  end

  scenario 'can see number of posts' do
    user = User.first
    visit "/users/#{user.id}/posts"

    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  scenario 'can see a posts title of posts' do
    user = User.includes(:posts).first
    posts = user.posts
    visit "/users/#{user.id}/posts"
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario 'can see some of the posts body of posts' do
    user = User.includes(:posts).first
    posts = user.posts
    visit "/users/#{user.id}/posts"
    posts.each do |post|
      expect(page).to have_content(post.text[0, 50])
    end
  end

  scenario 'can see first comments of a post' do
    user = User.first
    post = Post.includes(:comments).find_by(author_id: user.id)
    if post.comments.empty?
      Comment.create(text: 'A comment', author_id: user.id, post_id: post.id)
      post = Post.includes(:comments).find_by(author_id: user.id)
    end
    comments = post.comments.limit(3).order(created_at: :desc)
    visit "/users/#{user.id}/posts"
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  scenario 'can see how many comments a post has' do
    user = User.first
    post = Post.includes(:comments).find_by(author_id: user.id)
    comments = post.comments
    visit "/users/#{user.id}/posts"
    expect(page).to have_content("Comments: #{comments.length}")
  end

  scenario 'can see how many likes a post has' do
    user = User.first
    post = Post.includes(:likes).find_by(author_id: user.id)
    if post.likes.empty?
      Like.create(author_id: user.id, post_id: post.id)
      post = Post.includes(:likes).find_by(author_id: user.id)
    end
    likes = post.likes
    visit "/users/#{user.id}/posts"
    expect(page).to have_content("Likes: #{likes.length}")
  end

  scenario 'When I click on a posts Show post button, I\'m redirected to that posts show page' do
    user = User.includes(:posts).find_by(name: 'Sasan')
    post = user.posts.first
    visit "/users/#{user.id}/posts"
    page.find(id: "post-#{post.id}").click
    expect(page).to have_current_path("/users/#{user.id}/posts/#{post.id}")
  end
end
