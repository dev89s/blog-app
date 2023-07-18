require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'Get /index' do

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
      user = User.create! name: 'Second user', photo: 'somephotourl.com', bio: 'some bio', posts_counter: 0
      get "/users/#{user.id}"
      assert_response :success
    end

    it 'renders the correct template' do
      user = User.create! name: 'Second user', photo: 'somephotourl.com', bio: 'some bio', posts_counter: 0
      get "/users/#{user.id}"
      expect(response).to render_template('users/show')
    end

    it 'includes the correct user name' do
      user = User.create! name: 'Second user', photo: 'somephotourl.com', bio: 'some bio', posts_counter: 0
      get "/users/#{user.id}"
      expect(response.body).to include('some bio')
    end
  end
end
