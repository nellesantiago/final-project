require 'rails_helper'

RSpec.describe "Fans", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @fan = users(:fan)
    visit new_user_session_path
    sign_in @fan
  end

  it "allows fan to log in" do
    visit dashboard_index_path
    
    expect(page).to have_text("Feed")
  end

  it "allows fan to view sketches" do
    visit dashboard_sketches_path

    expect(page).to have_text("Maia")
  end

  it "allows fan to view tutorials" do
    visit dashboard_tutorials_path

    expect(page).to have_text("Maia")
  end

  it "allows fan to view plans" do
    visit plans_path

    expect(page).to have_text("Pricing")
  end

  it "allows fan to like a post" do
    visit dashboard_index_path

    expect(page).to have_text("Sample")

    expect{first('.like-post-button').click}.to change{Like.count}.by(1)

 end

  it "allows fan to unlike a post" do
    visit dashboard_index_path
    
    expect(page).to have_text("Liked")
  
    expect{first('.unlike-post-button').click}.to change{Like.count}.by(-1)
  end

  it "allows fan to add a comment to a post" do
    visit dashboard_index_path

    first('.comment').click

    expect(page).to have_text("Sample")

    fill_in "Add a comment...", with: "New Comment"

    expect{click_on "Post"}.to change{Comment.count}.by(1)
  end

  it "prevents fan to add a comment to a post without a message" do
    visit dashboard_index_path

    first('.comment').click

    expect(page).to have_text("Sample")

    expect{click_on "Post"}.to change{Comment.count}.by(0)
  end

  it "allows a fan to delete a comment from a post" do
    visit dashboard_index_path

    first('.comment').click

    expect(page).to have_text("comment")

    expect{first('.delete-comment-button').click}.to change{Comment.count}.by(-1)
  end
  
end