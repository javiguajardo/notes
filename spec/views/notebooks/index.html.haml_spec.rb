require 'rails_helper'

RSpec.describe "notebooks/index", type: :view do
  before(:each) do
    assign(:notebooks, [
      Notebook.create!(
        :name => "Name"
      ),
      Notebook.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of notebooks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
