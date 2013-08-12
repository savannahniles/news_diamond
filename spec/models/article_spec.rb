require 'spec_helper'

describe Article do

  let(:section) {FactoryGirl.create(:section)}
  let!(:feed) { FactoryGirl.create(:feed, name: "Cool News", section: section, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }
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
