require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(name: 'Kevin', photo: 'www.photo.com',
                        bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                        posts_counter: 1)
    @post = Post.create(author_id: @user.id, title: 'React advance',
                        text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                        comments_counter: 1, likes_counter: 1)
    @like1 = Like.create(author_id: @user.id, post_id: @post.id)
    @like2 = Like.create(author_id: @user.id, post_id: @post.id)
  end

  it 'update_likes_counter method should update the likes counter of a post' do
    Like.update_likes_counter(@post)
    expect(@post.likes_counter).to be(2)
  end
end
