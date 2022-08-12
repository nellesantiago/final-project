require 'rails_helper'

RSpec.describe Comment, type: :model do
  fixtures :all
  subject {
    Comment.new(
    message: "Comment",
    post_id: posts(:post2).id,
    user_id: users(:fan).id,
  )
}
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a message" do
    subject.message = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a post" do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

end
