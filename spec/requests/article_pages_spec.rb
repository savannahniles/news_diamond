require 'spec_helper'

describe "Article pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:section) { FactoryGirl.create(:section) }
  let!(:feed) { FactoryGirl.create(:feed, name: "Cool News", section: section, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }
  let!(:article) { FactoryGirl.create(:article, title: "Cool Shit to Read", url: "www.cnn.com", author: "Bob", summary: "...", content: "...", published: Time.now, guid: "4", feed: feed) }
  
  before { sign_in user }

  describe "Show article page" do
    before { visit article_path(article) }

    it { should have_title( article.title )}
    it { should have_content (capitalized_title(section.name))}
    it { should have_content( feed.name ) }
    it { should have_content( article.title ) }

    describe "delete links" do

      it { should_not have_link('Delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit article_path(article)
        end

        it { should have_link('Delete', href: article_path(article)) }
        it "should be able to delete an article" do
          expect do
            click_link('Delete', match: :first)
          end.to change(Article, :count).by(-1)
        end
      end
    end

  end


end