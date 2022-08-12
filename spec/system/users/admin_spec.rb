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

  it "allows admin to delete a post" do
    visit posts_path

    expect(page).to have_text("Posts")

    first(".post").click

    expect(page).to have_text("Sample")

    first(".delete-post-button").click

    expect(page).to have_text("Posts")
  end

  it "allows admin to delete a comment from a post" do
    visit posts_path

    expect(page).to have_text("Posts")

    first(".post").click

    expect(page).to have_text("Sample")

    first(".delete-comment-button").click

    expect(page).to have_text("No comments")
  end
  
end