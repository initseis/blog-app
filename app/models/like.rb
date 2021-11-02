class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_likes_counter(post)
    counter = Like.where("post_id = #{post.id}").count
    post.likes_counter = counter
    post.save
  end
end
