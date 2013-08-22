require 'spec_helper'

describe Article do

  let(:section) {FactoryGirl.create(:section)}
  let!(:feed) { FactoryGirl.create(:feed, name: "Sweet Blog", section: section, url: "www.cnn.com", site: "www.cnn.com", image_src: "goof", description: "Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor.") }
  before { @article = feed.articles.build(title: "Lorem ipsum", url: "www.cnn.com", author: "Bob", summary: "Lorem Ipsum", content: "Lorem Ipsum", published: Time.now) }

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:author) }
  it { should respond_to(:summary) }
  it { should respond_to(:content) }
  it { should respond_to(:published) }
  it { should respond_to(:feed_id) }
  it { should respond_to(:guid) }
  it { should respond_to(:feed) }
  its(:feed) { should eq feed }

  it { should be_valid }

  describe "when feed_id is not present" do
    before { @article.feed_id = nil }
    it { should_not be_valid }
  end

end
