require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Kevin', photo: 'www.photo.com',
                        bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                        posts_counter: 2)
  end

  it 'name should be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be greater than zero' do
    @user.posts_counter = 0
    expect(@user).to be_valid
  end

  it 'most_recent_posts method should return zero posts' do
    posts = User.most_recent_posts(@user)
    expect(posts.length).to be(0)
  end
end
