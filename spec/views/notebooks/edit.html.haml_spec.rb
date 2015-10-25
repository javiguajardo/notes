require 'rails_helper'

RSpec.describe "notebooks/edit", type: :view do
  before(:each) do
    @notebook = assign(:notebook, Notebook.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit notebook form" do
    render

    assert_select "form[action=?][method=?]", notebook_path(@notebook), "post" do

      assert_select "input#notebook_name[name=?]", "notebook[name]"
    end
  end
end
