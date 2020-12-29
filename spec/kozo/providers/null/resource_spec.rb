# frozen_string_literal: true

RSpec.describe Kozo::Providers::Null::Resource do
  subject(:resource) { described_class.new }

  it "has a provider" do
    expect(described_class.provider_name).to eq "null"
  end
end