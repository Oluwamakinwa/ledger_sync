# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Customer::Serializer do
  let(:customer) do
    build(
      :quickbooks_online_customer,
      ledger_id: id,
      DisplayName: name,
      PrimaryPhone: create(
        :quickbooks_online_primary_phone,
        FreeFormNumber: phone_number
      ),
      PrimaryEmailAddr: create(
        :quickbooks_online_primary_email_addr,
        Address: email
      )
    )
  end
  let(:id) { '123' }
  let(:name) { 'test_name' }
  let(:email) { 'test_email' }
  let(:phone_number) { 'test_phone_number' }

  let(:h) do
    {
      'DisplayName' => name,
      'PrimaryPhone' => {
        'FreeFormNumber' => phone_number
      },
      'PrimaryEmailAddr' => {
        'Address' => email
      },
      'Id' => id
    }
  end

  describe '#serialize' do
    it do
      serializer = described_class.new
      expect(serializer.serialize(resource: customer)).to eq(h)
    end
  end
end
