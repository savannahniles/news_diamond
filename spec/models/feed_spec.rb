require 'spec_helper'

describe Feed do

  let(:section) { FactoryGirl.create(:section) }
  before { @feed = section.feeds.build(name: "the New York Times", description: "Lorem ipsum") }

  subject { @feed }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:section_id) }
  it { should respond_to(:section) }
  its(:section) { should eq section }

  it { should be_valid }

  describe "when section_id is not present" do
    before { @feed.section_id = nil }
    it { should_not be_valid }
  end

  describe "when name is blank" do
    before { @feed.name = " " }
    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @feed.description = " " }
    it { should_not be_valid }
  end
end