require 'rails_helper'

RSpec.describe 'in user show page', type: :system do
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
    it 'the user\'s profile picture' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page.find('.profile-photo-img')['src']).to have_content(users[0].photo)
    end

    it 'the user\'s username' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].name)
    end

    it 'the number of posts the user has written' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content("Number of posts: #{users[0].posts_counter}")
    end

    it 'the user\'s bio' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      users = User.all
      click_link users[0].name
      expect(page).to have_content(users[0].bio)
    end

    it 'the user\'s first 3 posts' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      expect(page).to have_content(user.posts[3].title)
      expect(page).to have_content(user.posts[2].title)
      expect(page).to have_content(user.posts[1].title)
      expect(page).to_not have_content(user.posts[0].title)
    end

    it 'a button that lets me view all of a user\'s posts' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      expect(page).to have_link('See all posts')
    end
  end

  describe 'when i click' do
    it 'a user\'s post, it redirects me to that post\'s shot page' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link user.posts.last.title
      expect(current_path).to eql(user_post_path(id: user.posts.last.id, user_id: user.id))
    end
  end
end
