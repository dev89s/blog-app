require 'rails_helper'

describe Post, type: :model do
  subject {
    first_user = User.create(name: 'Sasan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student from Iran.', posts_counter: 0)
    first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0)
  }

  before { subject.save }

  it 'creation is successful' do
    expect(subject).to be_valid
  end

  it 'title must not be blank' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not be blank' do
    subject.title = "Lorem ipsum dolor sit, amet consectetur adipisicing elit.
    Eius dolorum velit modi suscipit unde dignissimos alias deserunt beatae sit
    vitae corrupti illum ad ratione, voluptas nobis. Velit nisi soluta sint.
    Lorem ipsum dolor sit, amet consectetur adipisicing elit. Eius dolorum
    velit modi suscipit unde dignissimos alias deserunt beatae sit vitae
    corrupti illum ad ratione, voluptas nobis. Velit nisi soluta sint."
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be integer' do
    subject.comments_counter = 1.2
    expect(subject).to_not be_valid
  end

  it 'comments_counter must not be negative' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be bigger or equal to 0' do
    subject.comments_counter = 0
    expect(subject).to be_valid
    subject.comments_counter = 200
    expect(subject).to be_valid
  end

  it 'likes_counter must be integer' do
    subject.likes_counter = 1.2
    expect(subject).to_not be_valid
  end

  it 'likes_counter must not be negative' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be bigger or equal to 0' do
    subject.likes_counter = 0
    expect(subject).to be_valid
    subject.likes_counter = 200
    expect(subject).to be_valid
  end

end
