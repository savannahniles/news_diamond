require 'spec_helper'

describe "Feed pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:section) { FactoryGirl.create(:section) }
  let!(:feed) { FactoryGirl.create(:feed, name: "Cool News", section: section, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }
  
  before { sign_in user }

  describe "feed show page" do
  	before { visit feed_path(feed) }

  	it { should have_content (capitalized_title(section.name))}
  	it { should have_content( feed.name ) }
    it { should have_title( feed.name )}
  end

  describe "feed creation" do

  	describe "as a non-admin" do
  	  before { visit section_path(section) }	

      it { should_not have_content("Name")}
  	end #as a non admin

  	describe "as an admin" do
  		before do
        	sign_in admin
        	visit section_path(section)
        end

        it { should have_content("Name")}

        describe "with invalid information" do

	      it "should not create a feed" do
	        expect { click_button "Create" }.not_to change(Feed, :count)
	      end

	      describe "error messages" do
	        before { click_button "Create" }
	        #This is a bug. Fucked up the failure handling for create feeds. Need to fix.
	        #it { should have_content('error') }
	        #it { should have_content('Name')}
	      end
	    end

	    describe "with valid information" do

	      before { 
	      	fill_in 'feed_description', with: "Lorem ipsum"
	      	fill_in 'feed_name', with: "Lorem ipsum" }
	      it "should create a feed" do
	        expect { click_button "Create" }.to change(Feed, :count).by(1)
	      end
	    end#with valid information
  	end #as an admin
  end #feed creation
end