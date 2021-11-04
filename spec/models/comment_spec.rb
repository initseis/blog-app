require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(name: 'Kevin', photo: 'www.photo.com',
                        bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                        posts_counter: 1)
    @post = Post.create(author_id: @user.id, title: 'React advance',
                        text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                        comments_counter: 1, likes_counter: 3)
    @comment1 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'First Comment')
    @comment2 = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Second Comment')
  end

  it 'update_comments_counter method should update the comments counter of a post' do
    Comment.update_comments_counter(@post)
    expect(@post.comments_counter).to be(2)
  end
end
