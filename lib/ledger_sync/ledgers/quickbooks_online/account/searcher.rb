# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Account
        class Searcher < QuickBooksOnline::Searcher
          def query_string
            "Name LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end