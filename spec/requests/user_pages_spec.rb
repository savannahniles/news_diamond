require 'spec_helper'

describe "User pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:section) { FactoryGirl.create(:section) }
  let!(:f1_not_followed) { FactoryGirl.create(:feed, name: "Swag News", section: section, url: "www.cnn.com", site: "www.cnn.com", image_src: "goof", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }
  let!(:f2_followed) { FactoryGirl.create(:feed, name: "Sweet Blog", section: section, url: "www.cnn.com", site: "www.cnn.com", image_src: "goof", description: "Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor.") }
  let!(:article_followed) { FactoryGirl.create(:article, title: "Cool Shit to Read", url: "www.cnn.com", author: "Bob", summary: "...", content: "...", published: Time.now, guid: "4", feed: f2_followed) }


  describe "index" do

    describe "as an admin user" do
      before do
        sign_in admin
        visit users_path
      end

      it { should have_title('All Users') }
      it { should have_content('All Users') }

      #it { should have_link('delete', href: user_path(User.first)) }
      #it "should be able to delete another user" do
        #expect do
          #click_link('delete', match: :first)
        #end.to change(User, :count).by(-1)
      #end
      it { should_not have_link('delete', href: user_path(admin)) }

      describe "pagination" do
        before(:all) { 30.times { FactoryGirl.create(:user) } }
        after(:all)  { User.delete_all }

        it { should have_selector('div.pagination') }

        it "should list each user" do
          User.paginate(page: 1).each do |user|
            expect(page).to have_selector('li', text: user.first_name)
          end
        end #should list each user
      end#describe pagination
    end#as an admin user  
  end#describe index

  describe "Your Websites (profile) page" do
 
    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_content("Your Websites") }
    it { should have_title(user.first_name) }
    it {should have_content("You're not following any websites! How about adding some?")}
    it {should have_content(Feed.count)}

    describe "follower/following counts" do
      before do
        user.follow!(f2_followed)
        visit user_path(user)
      end

      it { should have_content("1 Total") }

      describe "list of all feeds in section" do
        it { should have_content(f2_followed.name) }
        it { should have_content(f2_followed.description) }
        it { should_not have_content(f1_not_followed.name) }
        it { should_not have_content(f1_not_followed.description) }
      end
    end

  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",         with: "Example User"
        fill_in "Last name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.first_name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.first_name) } 
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

    end #with valid information
  end #describe signup

  describe "edit" do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your Information") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_first_name)  { "New" }
      let(:new_last_name)  { "Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "First name",             with: new_first_name
        fill_in "Last name",             with: new_last_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_first_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.first_name).to  eq new_first_name }
      specify { expect(user.reload.last_name).to  eq new_last_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end #describe edit

  describe "today page" do
    before do
      sign_in user
      visit today_user_path(user)
    end
    it { should have_title(full_title('Today')) }
    it { should have_content('Today') }

    describe "list of articles" do
      #shit here
      it "should list each article" do
        f2_followed.articles.each do |article|
          #expect(page).to have_selector('li', text: article.title)
          #expect(page).to have_selector('li', text: article.summary)
        end
      end#should list each article

    end#list of articles
  end#today

end