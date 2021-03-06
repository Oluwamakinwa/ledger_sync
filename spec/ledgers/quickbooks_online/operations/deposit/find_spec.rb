# frozen_string_literal: true

require 'spec_helper'

support :operation_shared_examples,
        :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Deposit::Operations::Find do
  include QuickBooksOnlineHelpers

  let(:account) do
    LedgerSync::Ledgers::QuickBooksOnline::Account.new(
      ledger_id: '123',
      name: 'Test',
      account_type: 'bank',
      account_sub_type: 'cash_on_hand'
    )
  end

  let(:department) do
    LedgerSync::Ledgers::QuickBooksOnline::Department.new(ledger_id: '123')
  end

  let(:resource) do
    LedgerSync::Ledgers::QuickBooksOnline::Deposit.new(
      ledger_id: '123',
      account: account,
      department: department,
      currency: FactoryBot.create(
        :quickbooks_online_currency
      ),
      memo: 'Memo 1',
      transaction_date: Date.new(2019, 9, 1),
      line_items: []
    )
  end
  let(:client) { quickbooks_online_client }

  it_behaves_like 'an operation'
  it_behaves_like 'a successful operation',
                  stubs: :stub_find_deposit
end
