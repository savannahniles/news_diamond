require 'spec_helper'

describe Relationship do

  let(:user) { FactoryGirl.create(:user) }
  let(:feed) { FactoryGirl.create(:feed) }
  let(:relationship) { user.relationships.build(feed_id: feed.id) }

  subject { relationship }

  it { should be_valid }

  describe "follower methods" do
    it { should respond_to(:user) }
    it { should respond_to(:feed) }
    its(:user) { should eq user }
    its(:feed) { should eq feed }
  end

  describe "when feed id is not present" do
    before { relationship.feed_id = nil }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { relationship.user_id = nil }
    it { should_not be_valid }
  end
end
