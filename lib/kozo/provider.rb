# frozen_string_literal: true

module Kozo
  class Provider
    class_attribute :provider_name

    def setup; end

    def ==(other)
      provider_name == other.provider_name
    end
  end
end
