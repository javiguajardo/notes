require 'rails_helper'

RSpec.describe "notebooks/show", type: :view do
  before(:each) do
    @notebook = assign(:notebook, Notebook.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
