require 'spec_helper'

describe Feed do

  let(:section) { FactoryGirl.create(:section) }
  before { @feed = section.feeds.build(name: "the New York Times", description: "Lorem ipsum", url: "www.cnn.com", site: "www.cnn.com", image_src: "foo") }

  subject { @feed }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:site) }
  it { should respond_to(:image_src) }
  it { should respond_to(:section_id) }
  it { should respond_to(:section) }
  its(:section) { should eq section }
  it { should respond_to(:relationships) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:users) }
  it { should respond_to(:articles) }

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

  describe "with blank url" do
    before { @feed.url = " " }
    it { should_not be_valid }
  end

  describe "with blank site" do
    before { @feed.site = " " }
    it { should_not be_valid }
  end

  describe "with blank image_src" do
    before { @feed.image_src = " " }
    it { should_not be_valid }
  end

  describe "article associations" do

    before { @feed.save }
    let!(:older_article) do
      FactoryGirl.create(:article, title: "Lorem Ipsum", url: "www.cnn.com", author: "Billy Bob", summary: "Hello", content: "Helloooo", feed: @feed, published: 1.day.ago)
    end
    let!(:newer_article) do
      FactoryGirl.create(:article, title: "Lorem Ipsum", url: "www.cnn.com", author: "Billy Bob", summary: "Hello", content: "Helloooo", feed: @feed, published: 1.hour.ago)
    end

    it "should have the right articles in the right order" do
      expect(@feed.articles.to_a).to eq [newer_article, older_article]
    end
  end#article associations

end