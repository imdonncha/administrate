require "rails_helper"
require "administrate/field/string"

describe "fields/select/_form", type: :view do
  it "sets required attribute if required" do
    customer = build(:customer)
    string = instance_double(
      "Administrate::Field::String",
      attribute: :name,
      required?: true
    )

    render(
      partial: "fields/string/form",
      locals: { field: string, f: form_builder(customer) },
    )

    expect(rendered).to have_css(
      %{input[type=text][required=required]}
    )
  end

  def form_builder(object)
    ActionView::Helpers::FormBuilder.new(
      object.model_name.singular,
      object,
      build_template,
      {},
    )
  end

  def build_template
    Object.new.tap do |template|
      template.extend ActionView::Helpers::FormHelper
      template.extend ActionView::Helpers::FormOptionsHelper
    end
  end
end
