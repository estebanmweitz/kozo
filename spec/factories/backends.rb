# frozen_string_literal: true

FactoryBot.define do
  factory :backend, class: "Kozo::Backend" do
    initialize_with { new(configuration, directory) }

    configuration { build(:configuration) }
    directory { FFaker::Filesystem.directory }
  end
end
