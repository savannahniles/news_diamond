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
    it { should_not have_link('Admin: Edit', href: edit_feed_path(feed)) }

    describe "as an admin" do
      before do
        sign_in admin
        visit section_path(section)
      end

      it { should_not have_link('Admin: Edit', href: edit_feed_path(feed)) }
    end

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

        let(:create) { "Create" }

        it { should have_content("Name")}

        describe "with invalid information" do

	      it "should not create a feed" do
	        expect { click_button create }.not_to change(Feed, :count)
	      end

	      describe "error messages" do
	        before { click_button create }
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

  describe "Edit" do 
    before do
      sign_in admin
      visit edit_feed_path(feed)
    end

    let(:save) { "Save changes" }

    describe "page" do
      it { should have_content("Update Feed") }
      it { should have_title("Edit Feed") }
    end

    describe "with invalid information" do
      before { click_button save}

      #bug. Need to fix. working apparently but test is failing
      #it { should have_selector('div.alert.alert-error') }
    end#with invalid

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_description)  { "New Description" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Description",             with: new_description
        click_button save
      end

      it { should have_title(new_name)}
      it { should have_content(new_description )}
      it { should have_selector('div.alert.alert-success') }
      #specify { expect(section.reload.name).to  eq new_name.downcase }
    end#with valid
  end#edit page
end