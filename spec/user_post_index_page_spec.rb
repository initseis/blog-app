require 'rails_helper'

RSpec.describe 'in user post index page', type: :system do
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
    it 'the profile picture for each user' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page.find('.profile-photo-img')['src']).to have_content(user.photo)
    end

    it 'the user\'s username' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content(user.name)
    end

    it 'the number of posts the user has written' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it 'a post\'s title' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content(user.posts.first.title)
    end

    it 'some of the post\'s body' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content(user.posts.first.text)
      expect(page).to have_content(user.posts.last.text)
    end

    it 'the first comment on a post' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content(user.posts.last.comments.first.text)
    end

    it 'how many comments a post has' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content("Comments: #{user.posts.first.comments_counter}")
    end

    it 'how many likes a post has' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_content("Likes: #{user.posts.first.likes_counter}")
    end

    it 'a section for pagination if there are more posts then fit on the view' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      expect(page).to have_button('Pagination')
    end
  end

  describe 'when i click' do
    it 'on a post, it redirects me to that post\'s show page' do
      visit new_user_session_path
      fill_in 'email', with: 'kevin@gmail.com'
      fill_in 'password', with: '234234'
      click_button 'Log in'
      user = User.find_by(name: 'Kevin')
      click_link user.name
      click_link 'See all posts'
      click_link user.posts.first.title
      expect(current_path).to eql(user_post_path(id: user.posts.first.id, user_id: user.id))
    end
  end
end
