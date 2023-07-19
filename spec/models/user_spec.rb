require 'rails_helper'

describe User, type: :model do
  subject { User.create(id: 1, name: 'Sasan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student from Iran.', posts_counter: 0) }

  before { subject.save }

  it 'user creation is successful' do
    expect(subject).to be_valid
  end

  it 'name should not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should not be empty' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'posts_counter not be blank' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter be bigger or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'posts_counter be bigger or equal to 0' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  it 'posts_counter be bigger or equal to 0' do
    subject.posts_counter = 200
    expect(subject).to be_valid
  end

  it 'posts_counter be integer' do
    subject.posts_counter = 1.2
    expect(subject).to_not be_valid
  end
end
