require 'rails_helper'

RSpec.describe "Admin", type: :system do
  fixtures :all
  before do
    driven_by(:rack_test)
    @admin = users(:admin)
    visit new_user_session_path
    sign_in @admin
  end

  it "allows admin to log in" do
    visit posts_path

    expect(page).to have_text("Posts")
  end

  it "allows admin to sign in and view all fans" do
    visit users_path

    expect(page).to have_text("Fans")
  end

  it "allows admin to sign in and view all transactions" do
    visit subscribers_path

    expect(page).to have_text("Transactions")
  end

  it "allows admin to create a post" do
    visit posts_path

    expect(page).to have_text("Posts")

    first(".new-post-button").click

    expect(page).to have_text("New Post")

    fill_in "Title", with: "New Post"
    fill_in "Description", with: "Post Description"
    attach_file "post[content_image]", file_fixture("image.png")

    click_on "Create Post"

    expect(page).to have_text("New Post")
  end

  it "prevents admin to create a post without a post attachment" do
    visit posts_path

    expect(page).to have_text("Posts")

    first(".new-post-button").click

    expect(page).to have_text("New Post")

    fill_in "Title", with: "New Post"
    fill_in "Description", with: "Post Description"

    click_on "Create Post"

    expect(page).to have_text("Content image can't be blank")
  end
  
  it "allows admin to edit a post" do
    visit posts_path
    
    expect(page).to have_text("Posts")
    
    first(".post").click
    
    expect(page).to have_text("Example")
    
    first(".edit-post-button").click
    
    expect(page).to have_text("Edit Post")
    
    fill_in "Title", with: "Updated Title"
    
    click_on "Update Post"
    
    expect(page).to have_text("Updated Title")
  end
  
    it "allows admin to delete a post" do
      visit posts_path
  
      expect(page).to have_text("Posts")
  
      first(".post").click
  
      expect(page).to have_text("Example")
  
      first(".delete-post-button").click
  
      expect(page).to have_text("Posts")
    end
  
  it "allows admin to delete a comment from a post" do
    visit posts_path

    expect(page).to have_text("Posts")

    first(".post").click

    expect(page).to have_text("Example")

    first(".delete-comment-button").click

    expect(page).to have_text("No comments")
  end
  
end