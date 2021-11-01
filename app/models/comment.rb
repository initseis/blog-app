class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_comments_counter(post)
    counter = Comment.where("post_id = #{post.id}").count
    post.comments_counter = counter
    post.save
  end
end
