# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Operation do
  include AdaptorHelpers

  let(:operation) { test_customer_create_operation }

  subject { operation }

  it { expect { described_class.new }.to raise_error(NoMethodError) } # Operation is a module

  describe '#add_after_operation' do
    it do
      op = test_customer_update_operation
      subject.add_after_operation(op)
      expect(subject.after_operations).to eq([op])
    end
  end

  describe '#add_before_operation' do
    it do
      op = test_customer_update_operation
      subject.add_before_operation(op)
      expect(subject.before_operations).to eq([op])
    end
  end

  describe '#create?' do
    it do
      subject.perform
      expect(subject).to be_create
    end
  end

  describe '#failure?' do
    it do
      subject.perform
      expect(subject).not_to be_failure
    end
  end

  describe '#find?' do
    it do
      subject.perform
      expect(subject).not_to be_find
    end
  end

  describe '#perform' do
    subject { operation.perform }

    it { expect(subject).to be_success }

    it do
      allow(operation).to receive(:operate) { raise LedgerSync::Error.new(message: 'Test') }
      expect(subject).to be_failure
      expect(subject.error.message).to eq('Test')
    end

    # TODO: This fails on test adaptor because there is no error parser, and maybe it's QBO-only to have one?
    xit do
      headers = double('headers')
      allow(headers).to receive(:values_at).with(any_args) { [] }
      response = double(
        'response',
        body: {},
        headers: headers
      )
      allow(operation).to receive(:operate) { raise OAuth2::Error, OAuth2::Response.new(response) }
      expect(subject).to be_failure
      expect(subject.error.message).to eq('Test')
    end
  end

  describe '#success?' do
    it do
      subject.perform
      expect(subject).to be_success
    end
  end

  describe '#update?' do
    it do
      subject.perform
      expect(subject).not_to be_update
    end
  end

  describe '#valid?' do
    it do
      subject.perform
      expect(subject).not_to be_valid
    end
  end
end
