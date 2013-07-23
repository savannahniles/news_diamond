require 'spec_helper'

describe "Section pages" do

  subject { page }

  describe "Section page" do
    let(:section) { FactoryGirl.create(:section) }
    before { visit section_path(section) }

    it { should have_content( capitalized_title(section.name) ) }
    it { should have_title(section.name) }
  end

  describe "Add Section page" do
    before { visit new_section_path }

    it { should have_content('Add Section') }
    it { should have_title(full_title('Add Section')) }
  end

  describe "Adding a section" do

    before { visit new_section_path }

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
    end
  end
end