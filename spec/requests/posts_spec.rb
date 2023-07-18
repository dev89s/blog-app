require 'rails_helper'

RSpec.describe Post, type: :request do
  before(:context) do
    if Post.all.length == 0
      Post.create author: User.first, title: 'Needed title', text: 'Needed text', likes_counter: 0, comments_counter: 0
    end
  end
  describe 'Get /users/:user_id/posts' do
    it 'renders successfully' do
      get "/users/#{User.first.id}/posts"
      assert_response :success
    end

    it 'renders the correct template' do
      get "/users/#{User.first.id}/posts"
      expect(response).to render_template('posts/index')
    end

    it 'renders the correct template' do
      get "/users/#{User.first.id}/posts"
      expect(response.body).to include('Needed title')
    end
  end

  describe 'Get /users/:user_id/posts/:id' do
    it 'renders successfully' do
      get "/users/#{User.first.id}/posts/#{Post.first.id}"
      assert_response :success
    end

    it 'renders the correct template' do
      get "/users/#{User.first.id}/posts/#{Post.first.id}"
      expect(response).to render_template('posts/show')
    end

    it 'renders the correct template' do
      get "/users/#{User.first.id}/posts/#{Post.first.id}"
      expect(response.body).to include('Needed title')
    end
  end
end
