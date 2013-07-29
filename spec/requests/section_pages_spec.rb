require 'spec_helper'

describe "Section pages" do

  subject { page }

  describe "Section show page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:section) { FactoryGirl.create(:section) }
    let!(:f1) { FactoryGirl.create(:feed, name: "Cool News", section: section, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.") }
    let!(:f2) { FactoryGirl.create(:feed, name: "Sweet Blog", section: section, description: "Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor.") }

    before do
      sign_in user
      visit section_path(section)
    end

    it { should have_content( capitalized_title(section.name) ) }
    it { should have_title(capitalized_title(section.name) )}

    describe "list of feeds in section" do
      it { should have_content(f1.name) }
      it { should have_content(f1.description) }
      it { should have_content(f2.name) }
      it { should have_content(f2.description) }
      it { should have_content(section.feeds.count) }
    end
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
        fill_in "Name",         with: "Example Section"
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
      before do
        fill_in "Name",             with: new_name
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