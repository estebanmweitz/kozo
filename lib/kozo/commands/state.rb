# frozen_string_literal: true

module Kozo
  module Commands
    class State < Kozo::Command
      self.description = "Manage and manipulate state"

      attr_reader :subcommand

      def initialize(*args, configuration: nil)
        subcommand = args.shift

        raise UsageError unless subcommand

        klass = "Kozo::Commands::State::#{subcommand.camelize}".safe_constantize

        raise UsageError, "unknown subcommand: state #{subcommand}" unless klass

        @subcommand = klass.new(*args, configuration: configuration)
      end

      def start
        subcommand
          .start
      end
    end
  end
end
