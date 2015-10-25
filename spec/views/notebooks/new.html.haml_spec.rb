require 'rails_helper'

RSpec.describe "notebooks/new", type: :view do
  before(:each) do
    assign(:notebook, Notebook.new(
      :name => "MyString"
    ))
  end

  it "renders new notebook form" do
    render

    assert_select "form[action=?][method=?]", notebooks_path, "post" do

      assert_select "input#notebook_name[name=?]", "notebook[name]"
    end
  end
end
