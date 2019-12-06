# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'
Gem.find_files('ledger_sync/adaptors/netsuite_rest/ledger_serializer_type/**/*.rb').each { |path| require path } # require adaptor-specific types

module LedgerSync
  module Adaptors
    module NetSuiteREST
      class LedgerSerializer < Adaptors::LedgerSerializer
        def self.api_resource_path
          "resource/#{api_resource_type}"
        end

        def self.api_resource_type(val = nil)
          raise 'api_resource_type already set' if @api_resource_type.present? && val.present?

          @api_resource_type ||= val
        end
      end
    end
  end
end
