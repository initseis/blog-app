require 'rails_helper'

RSpec.describe 'in a post page', js: true, type: :system do
  before(:all) do
    @first_user = User.create(name: 'Kevin', photo: 'http://lorempixel.com/100/100/',
                              bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudi.',
                              posts_counter: 0, email: 'kevin@gmail.com', password: '234234', confirmed_at: Time.now)
    @second_user = User.create(name: 'Jose', photo: 'http://lorempixel.com/100/100/',
                               bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudi.',
                               posts_counter: 0, email: 'jose@gmail.com', password: '123123', confirmed_at: Time.now)
    @first_post = Post.create(title: 'Post 1', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(title: 'Post 2', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(title: 'Post 3', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                              author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @fourth_post = Post.create(title: 'Post 4', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit.',
                               author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    Comment.create(text: 'This is the first comment', author_id: @second_user.id, post_id: @fourth_post.id)
    Comment.create(text: 'This is the second comment', author_id: @first_user.id, post_id: @fourth_post.id)
  end

  describe 'I can see' do
    it 'the post\'s title' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.posts.last.title)
    end

    it 'who wrote the post' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.name)
    end

    it 'how many comments it has' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content("Comments: #{user.posts.last.comments_counter}")
    end

    it 'how many likes it has' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content("Likes: #{user.posts.last.likes_counter}")
      click_button 'Like'
      expect(page).to have_content("Likes: #{user.posts.last.likes_counter}")
    end

    it 'the post body' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      expect(page).to have_content(user.posts.last.text)
    end

    it 'the username of each commentor' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      user.posts.last.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'the comment each commentor left' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      user.posts.last.comments.each do |comment|
        expect(page).to have_content("#{comment.author.name}: #{comment.text}")
      end
    end
  end
end
