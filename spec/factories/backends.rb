# frozen_string_literal: true

FactoryBot.define do
  factory :backend, class: "Kozo::Backend" do
    initialize_with { new(configuration, directory) }

    configuration { build(:configuration) }
    directory { FFaker::Filesystem.directory }
  end

  factory :memory_backend, parent: :backend, class: "Kozo::Backends::Memory"

  factory :local_backend, parent: :backend, class: "Kozo::Backends::Local" do
    directory { Dir.mktmpdir }
  end

  factory :git_backend, parent: :backend, class: "Kozo::Backends::Git" do
    directory { Dir.mktmpdir }
  end
end
