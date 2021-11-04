# frozen_string_literal: true

require "hcloud"

RSpec.describe Kozo::Providers::HCloud::Resources::Server do
  subject(:resource) { build(:hcloud_server, name: "old_name", location: "fsn") }

  let(:server_class) { class_double("HCloud::Server") }
  let(:server) { instance_double("HCloud::Server") }

  before { stub_const("HCloud::Server", server_class) }

  it { is_expected.to respond_to :name, :name= }
  it { is_expected.to respond_to :image, :image= }
  it { is_expected.to respond_to :server_type, :server_type= }
  it { is_expected.to respond_to :location, :location= }
  it { is_expected.to respond_to :datacenter, :datacenter= }

  it { is_expected.to respond_to :user_data, :user_data= }
  it { is_expected.to respond_to :labels, :labels= }

  it { is_expected.to respond_to :firewalls, :firewalls= }
  it { is_expected.to respond_to :networks, :networks= }
  it { is_expected.to respond_to :ssh_keys, :ssh_keys= }
  it { is_expected.to respond_to :volumes, :volumes= }

  it { is_expected.to respond_to :automount, :automount= }
  it { is_expected.to respond_to :start_after_create, :start_after_create= }

  it "has a name" do
    expect(described_class.resource_name).to eq "hcloud_server"
  end

  describe "#refresh!" do
    it "refreshes name" do
      allow(server_class)
        .to receive(:find)
        .with(resource.id)
        .and_return OpenStruct.new(name: "new_name")

      resource.refresh!

      expect(resource.name).to eq "new_name"
    end
  end

  describe "#create!" do
    it "creates a resource" do
      server = OpenStruct.new(id: 12_345, name: "new_name", location: "fsn", datacenter: "fsn-dc1", create: true)

      allow(server_class)
        .to receive(:new)
        .with(including(name: "old_name", location: "fsn"))
        .and_return server

      allow(server)
        .to receive(:create)

      resource.create!

      expect(server)
        .to have_received(:create)

      expect(resource.id).to eq 12_345
      expect(resource.name).to eq "new_name"
      expect(resource.location).to eq "fsn"
      expect(resource.datacenter).to eq "fsn-dc1"
    end
  end

  describe "#update!" do
    it "updates a resource" do
      server = OpenStruct.new(name: "new_name", update: true)

      allow(server_class)
        .to receive(:find)
        .with(resource.id)
        .and_return server

      allow(server)
        .to receive(:update)

      resource.update!

      expect(server)
        .to have_received(:update)

      expect(server.name).to eq "old_name"
    end

    describe "#destroy!" do
      it "destroys a resource" do
        allow(server_class)
          .to receive(:find)
          .with(resource.id)
          .and_return server

        allow(server)
          .to receive(:delete)

        resource.destroy!

        expect(server)
          .to have_received(:delete)
      end
    end
  end
end