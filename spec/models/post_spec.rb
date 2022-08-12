require 'rails_helper'

RSpec.describe Post, type: :model do
  subject {
    Post.new(
      title: "Title",
      description: "Description"
    )
  }

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end


  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
end
