require 'rails_helper'

RSpec.describe Post, type: :model do
  subject {
    @file = fixture_file_upload(Rails.root.join('spec/fixtures/files', 'image.png'), 'image/png')
    Post.new(
      title: "Title",
      description: "Description",
      content_image: @file
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an attachment" do
    subject.content_image = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end


  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
end
