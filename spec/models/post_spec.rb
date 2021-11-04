require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'Kevin', photo: 'www.photo.com',
                        bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                        posts_counter: 1)
    @post1 = Post.create(author_id: @user.id, title: 'React advance',
                         text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                         comments_counter: 2, likes_counter: 3)
    @post2 = Post.create(author_id: @user.id, title: 'Rails advance',
                         text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                         comments_counter: 4, likes_counter: 5)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'First Comment')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post1.id, text: 'Second Comment')
  end

  it 'name length less or equal than 250 characters' do
    @post1.title = 't' * 251
    expect(@post1).to_not be_valid
  end

  it 'comments_counter should be greater than zero' do
    expect(@post1).to be_valid
  end

  it 'likes_counter should be greater than zero' do
    expect(@post1).to be_valid
  end

  it 'update_post_counter method should update posts_counter for a user' do
    Post.update_post_counter(@user)
    expect(@user.posts_counter).to be(2)
  end

  it 'most_recent_comments method should return recent comments' do
    comments = Post.most_recent_comments(@post1)
    expect(comments.length).to be(2)
  end
end
