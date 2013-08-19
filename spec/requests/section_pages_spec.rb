require 'spec_helper'

describe "Section pages" do

  subject { page }

  describe "Section show page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:section) { FactoryGirl.create(:section) }
    let!(:f1_not_followed) { FactoryGirl.create(:feed, name: "Cool News", section: section, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }
    let!(:f2_followed) { FactoryGirl.create(:feed, name: "Awesome Website!", section: section, description: "This is one sick Website!") }
    let!(:article_followed) { FactoryGirl.create(:article, title: "Cool Shit to Read", url: "www.cnn.com", author: "Bob", summary: "...", content: "...", published: Time.now, guid: "4", feed: f2_followed) }

    before do
      sign_in user
      user.follow!(f2_followed)
      visit section_path(section)
    end

    it { should have_content( capitalized_title(section.name) ) }
    it { should have_title(capitalized_title(section.name) )}
    it { should have_content('1 website')}

    describe "list of feed icons" do
      #bug??????????
      #it { should have_link(href: feed_path(f2_followed)) }
      it { should_not have_link(href: feed_path(f1_not_followed)) }
    end

    describe "list of articles" do
      #shit here
      it "should list each article" do
        f2_followed.articles.each do |article|
          expect(page).to have_selector('li', text: article.title)
          expect(page).to have_selector('li', text: article.summary)
        end
      end#should list each article

    end#list of articles

  end#section show page

  describe "Add Section page" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_section_path
    end

    it { should have_content('Add Section') }
    it { should have_title(full_title('Add Section')) }
  end

  describe "Adding a section" do
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit new_section_path
    end

    let(:submit) { "Create section" }

    describe "with invalid information" do
      it "should not create a section" do
        expect { click_button submit }.not_to change(Section, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example Section"
        fill_in "Rank",             with: "1"
        fill_in "Image src",        with: "new_image_src"
      end

      it "should create a section" do
        expect { click_button submit }.to change(Section, :count).by(1)
      end
    end#with valid info
  end#adding a section

  describe "edit" do
    let(:section) { FactoryGirl.create(:section) }
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit edit_section_path(section)
    end

    describe "page" do
      it { should have_content("Update Section") }
      it { should have_title("Edit section") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      ####it { should have_content('error') }
    end#with invalid

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_image_src)  { "new_image_src" }
      let(:new_rank)  { "4" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Rank",             with: new_rank
        fill_in "Image src",             with: new_name
        click_button "Save changes"
      end

      it { should have_title(capitalized_title(new_name) )}
      it { should have_selector('div.alert.alert-success') }
      specify { expect(section.reload.name).to  eq new_name.downcase }
    end#with valid
  end#edit

  describe "sections index page" do
    let(:section) { FactoryGirl.create(:section) }
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in admin
      visit sections_path
    end

      it { should have_title('All Sections') }
      it { should have_content('All Sections') }
      it { should have_link('Add a New Section', href: new_section_path) }

      it "should list each section" do
        Section.all.each do |section|
          expect(page).to have_selector('li', text: capitalized_title(section.name))
          expect(page).to have_link('Edit', href: edit_section_path(section))
        end
      end
  end#index

end