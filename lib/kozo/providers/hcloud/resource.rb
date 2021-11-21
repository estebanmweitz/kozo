# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      class Resource < Kozo::Resource
        self.provider_name = "hcloud"

        attribute :id, type: :integer

        protected

        def refresh
          resource = resource_class.find(id)

          attribute_names
            .excluding(:id)
            .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        end

        def create
          resource = resource_class.new(**attributes.except(:id))
          resource.create

          attribute_names
            .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        end

        def update
          resource = resource_class.find(id)

          attribute_names
            .excluding(:id)
            .each { |attr| resource.send(:"#{attr}=", send(attr)) }

          resource.update

          attribute_names
            .excluding(:id)
            .each { |attr| send(:"#{attr}=", resource.send(attr)) }
        end

        def destroy
          resource = resource_class.find(id)
          resource.delete
        end

        private

        def resource_class
          "HCloud::#{self.class.name.demodulize}".constantize
        end
      end
    end
  end
end
