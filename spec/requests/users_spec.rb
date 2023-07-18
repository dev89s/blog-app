require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'Get /index' do
    before(:context) do
      if User.all.length == 0
        user = User.create name: 'Sasan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student from Iran.', posts_counter: 0
      end
    end
    it 'renders successful response' do
      get '/users'
      assert_response :success
    end

    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template('users/index')
    end

    it 'includes the correct user name' do
      get users_url(User.first)
      expect(response.body).to include('Sasan')
    end
  end

  describe 'Get /show' do
    it 'get a user' do
      get users_url(User.first)
      assert_response :success
    end

    it 'renders the correct template' do
      get "/users/#{User.first.id}"
      expect(response).to render_template('users/show')
    end

    it 'includes the correct user name' do
      get "/users/#{User.first.id}"
      expect(response.body).to include('Student from Iran.')
    end
  end
end
