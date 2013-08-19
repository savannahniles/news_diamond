require 'spec_helper'

describe Section do

  before do 
  	@section = Section.new(name: "Example Section", rank: "1", image_src: "src") 
  end

  subject { @section }

  it { should respond_to(:name) }
  it { should respond_to(:feeds) }
  it { should respond_to(:rank) }
  it { should respond_to(:image_src) }


  it { should be_valid }

  describe "when name is not present" do
    before { @section.name = " " }
    it { should_not be_valid }
  end

  describe "when rank is not present" do
    before { @section.rank = " " }
    it { should_not be_valid }
  end

  describe "when image_src is not present" do
    before { @section.image_src = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @section.name = "a" * 51 }
    it { should_not be_valid }
  end

describe "when name is already taken" do
    before do
      section_with_same_name = @section.dup
      section_with_same_name.name = @section.name.upcase
      section_with_same_name.save
    end

    it { should_not be_valid }
  end
end