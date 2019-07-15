module LedgerSync
  module Adaptors
    module Test
      module Customer
        module Operations
          class Valid < Operation::Create
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                optional(:ledger_id).maybe(:string)
                optional(:email).maybe(:string)
                optional(:name).maybe(:string)
                optional(:phone_number).maybe(:string)
              end
            end

            private

            def operate
              success(response: :foo)
            end
          end
        end
      end
    end
  end
end