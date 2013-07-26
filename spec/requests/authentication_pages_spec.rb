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

      it { should have_title(user.first_name) } 
      it { should have_link('Your Subscriptions',     href: user_path(user)) }
      it { should have_link('Account Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should_not have_link('Users', href: users_path) }

      describe "nav for an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before { sign_in admin }

        it { should have_link('Users', href: users_path) }
        it { should have_link('Sections', href: sections_path) }
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
      end#in the users controller

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

        describe "submitting to the create action" do
          before { patch section_path(section) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "trying to visit the edit Section page" do
          before { post sections_path }
          it { should have_title('') }
        end

        describe "submitting to the update action" do
          before { patch section_path(section) }
          specify { expect(response).to redirect_to(root_path) }
        end

        describe "Trying to access the sections index page" do
          before { visit sections_path }
          it { should have_title('') }
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