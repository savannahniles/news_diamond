require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Try again?') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end #with invalid info

	describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_content(user.first_name) } 
      it { should have_link('Your Websites',     href: user_path(user)) }
      it { should have_link('Today',     href: today_user_path(user)) }
      it { should have_link('Account Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should_not have_link('Users', href: users_path) }

      describe "nav for an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before { sign_in admin }

        it { should have_link('Users', href: users_path) }
        it { should have_link('Sections', href: sections_path) }
        it { should have_link('Website',       href: feeds_path) }
      end

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
      
    end #with valid information
  end #describe signin

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:section) {FactoryGirl.create(:section)}
      let!(:feed) { FactoryGirl.create(:feed, name: "Cool News", section: section, url: "www.cnn.com/rss", site: "www.cnn.com", image_src: "goof", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }  
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end#after signing in
      end#when attempting to visit protected page

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') } #####
        end

        describe "visiting the today page" do
          before { visit today_user_path(user) }
          it { should have_title('Sign in') }
        end
      end#in the users controller

      describe "in the Section controller" do

        describe "visiting the new Section page" do
          before { visit new_section_path }
          it { should have_title('Sign in') }
        end

        describe "submitting to the create action" do
          before { post sections_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the edit Section page" do
          before { visit edit_section_path(section) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch section_path(section) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the sections index" do
          before { visit sections_path }
          it { should have_title('Sign in') }
        end
      end#in the sections controller

      describe "in the Feeds controller" do

        describe "visiting the new Feed page" do
          before { visit new_feed_path }
          it { should have_title('Sign in') }
        end

        describe "submitting to the create action" do
          before { post feeds_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the edit Feed page" do
          before { visit edit_feed_path(feed) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch feed_path(feed) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the feeds index" do
          before { visit feeds_path }
          it { should have_title('Sign in') }
        end
      end# in the feeds controller

      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "in the Articles controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "as wrong user" do
	      let(:user) { FactoryGirl.create(:user) }
	      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
	      before { sign_in user, no_capybara: true }

	      describe "visiting Users#edit page" do
	        before { visit edit_user_path(wrong_user) }
	        it { should_not have_title(full_title('Edit user')) }
	      end

	      describe "submitting a PATCH request to the Users#update action" do
	        before { patch user_path(wrong_user) }
	        specify { expect(response).to redirect_to(root_path) }
	      end

	    end#as the wrong user

      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }
        let(:section) { FactoryGirl.create(:section) }
        let!(:feed) { FactoryGirl.create(:feed, name: "Cool News", section: section, url: "www.cnn.com/rss", site: "www.cnn.com", image_src: "goof", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }          
        let!(:article) { FactoryGirl.create(:article, title: "Cool Shit to Read", url: "www.cnn.com", author: "Bob", summary: "...", content: "...", published: Time.now, guid: "4", feed: feed) }

        before { sign_in non_admin, no_capybara: true }

        describe "Trying to access the user index page" do
          before { visit users_path }
          it { should have_title('') }
        end

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "trying to visit the new Section page" do
          before { get new_section_path }
          it { should have_title('') }
        end

        describe "submitting to the section create action" do
          before { patch section_path(section) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "trying to visit the edit Section page" do
          before { post sections_path }
          it { should have_title('') }
        end

        describe "submitting to the section update action" do
          before { patch section_path(section) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "Trying to access the sections index page" do
          before { visit sections_path }
          it { should have_title('') }
        end

        describe "trying to visit the new Feed page" do
          before { get new_feed_path }
          it { should have_title('') }
        end

        describe "submitting to the feed create action" do
          before { patch feed_path(feed) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "trying to visit the edit Feed page" do
          before { post feeds_path }
          it { should have_title('') }
        end

        describe "submitting to the feed update action" do
          before { patch feed_path(feed) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete article_path(article) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end#as a non-admin user

    end#for non signed in users

    describe "for signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user, no_capybara: true }

      describe "using a 'new' action" do
          before { get new_user_path }
          it { should have_title('') }
      end

      describe "using a 'create' action" do
          before { post users_path }
          it { should have_title('') }      
      end         
    end#for signed in users
  end#authorization

end