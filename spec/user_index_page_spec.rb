require 'rails_helper'

RSpec.describe 'in Index page', type: :system do
  before(:all) do
    @first_user = User.create(name: 'Kevin', photo: 'http://lorempixel.com/100/100/',
                              bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                              posts_counter: 0, email: 'kevin@gmail.com', password: '234234', confirmed_at: Time.now)
    @second_user = User.create(name: 'Jose', photo: 'http://lorempixel.com/100/100/',
                               bio: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                               posts_counter: 0, email: 'jose@gmail.com', password: '123123', confirmed_at: Time.now)
    @first_post = Post.create(title: 'Post 1', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @second_post = Post.create(title: 'Post 2', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @third_post = Post.create(title: 'Post 3', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    @fourth_post = Post.create(title: 'Post 4', text: 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Aut officia repudiandae exe.',
                author_id: @first_user.id, comments_counter: 0, likes_counter: 0)
    Comment.create(text: 'This is the first comment', author_id: @second_user.id, post_id: @fourth_post.id)
    Comment.create(text: 'This is the second comment', author_id: @first_user.id, post_id: @fourth_post.id)
  end

  describe 'I can see' do
    it 'the username of all other users' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'the profile picture for each user' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      visit users_path
      expect(page.first('.profile-photo-img')['src']).to have_content(users[0].photo)
    end

    it 'the number of posts each user has written' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      visit users_path
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
  end

  describe 'when i click on a user, ' do
    it 'I am redirected to that user\'s show page' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(current_path).to eql(user_path(id: users[0].id))
    end
  end
end
