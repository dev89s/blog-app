require 'rails_helper'

RSpec.describe 'User index', type: :posts do
  scenario 'I can see post\'s title' do
    user = User.includes(:posts).first
    post = user.posts.first
    visit "/users/#{user.id}/posts/#{post.id}"
    expect(page).to have_content post.title
  end

  scenario 'I can see post\'s author' do
    user = User.includes(:posts).first
    post = user.posts.first
    visit "/users/#{user.id}/posts/#{post.id}"
    expect(page).to have_content "Author: #{user.name}"
  end

  scenario 'can see how many comments a post has' do
    user = User.first
    post = Post.includes(:comments).find_by(author_id: user.id)
    if post.comments.length == 0
      Comment.create(text: "A comment", author_id: user.id, post_id: post.id)
      post = Post.includes(:comments).find_by(author_id: user.id)
    end
    comments = post.comments
    visit "/users/#{user.id}/posts/#{post.id}"
    expect(page).to have_content("Comments: #{comments.length}")
  end

  scenario 'can see how many likes a post has' do
    user = User.first
    post = Post.includes(:likes).find_by(author_id: user.id)
    if post.likes.length == 0
      Like.create(author_id: user.id, post_id: post.id)
      post = Post.includes(:likes).find_by(author_id: user.id)
    end
    likes = post.likes
    visit "/users/#{user.id}/posts/#{post.id}"
    expect(page).to have_content("Likes: #{likes.length}")
  end

  scenario 'can see body of post' do
    user = User.includes(:posts).first
    post = user.posts.first
    visit "/users/#{user.id}/posts/#{post.id}"
    expect(page).to have_content(post.text)
  end

  scenario 'can see username of each commenter' do
    user = User.first
    post = Post.includes(:comments).find_by(author_id: user.id)
    if post.comments.length == 0
      Comment.create(text: "A comment", author_id: user.id, post_id: post.id)
      post = Post.includes(:comments).find_by(author_id: user.id)
    end
    visit "/users/#{user.id}/posts/#{post.id}"
    comment = find('div.comment-container')

    expect(comment).to have_content(user.name)
  end

  scenario 'can see text of each comment' do
    user = User.first
    post = Post.includes(:comments).find_by(author_id: user.id)
    if post.comments.length == 0
      Comment.create(text: "A comment", author_id: user.id, post_id: post.id)
      post = Post.includes(:comments).find_by(author_id: user.id)
    end
    comment = post.comments.first
    visit "/users/#{user.id}/posts/#{post.id}"
    comment_el = all('div.comment-container')[0]
    expect(comment_el).to have_content(comment.text)
  end
end
