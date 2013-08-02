require 'spec_helper'

describe "Static pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe "Home page" do

    before{ visit root_path}

    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

    describe "when not signed-in" do
      before { visit root_path }
      it { should have_content('The news and articles you love, all in one place.') }
    end

    describe "when signed-in" do
      before do
        sign_in user
        visit root_path
      end

      it { should have_content('Welcome')}

      it "should list each section" do
        Section.all.each do |section|
          expect(page).to have_selector('li', text: capitalized_title(section.name))
        end
      end#should list each section
    end#singed in
  end#home page

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact Us')) }
  end

    describe "Privacy Policy page" do
    before { visit privacy_policy_path }

    it { should have_content('Privacy Policy') }
    it { should have_title(full_title('Privacy Policy')) }
  end
end