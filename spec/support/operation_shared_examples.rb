# frozen_string_literal: true

RSpec.shared_examples 'a valid operation' do
  it 'is valid' do
    instance = described_class.new(resource: resource, client: client)
    if ENV.fetch('DEBUG', false) && !instance.valid?
      pd instance.errors
      byebug if ENV['DEBUG']
    end
    expect(instance).to be_valid
  end
end

RSpec.shared_examples 'a successful operation' do |stubs: []|
  before do
    stubs = [stubs] unless stubs.is_a?(Array)
    stubs.each do |stub|
      if stub.is_a?(Array)
        send(*stub)
      else
        send(stub)
      end
    end
  end

  it 'is successful' do
    result = described_class.new(resource: resource, client: client).perform
    if ENV.fetch('DEBUG', false) && result.failure?
      byebug
    end
    expect(result).to be_a(LedgerSync::OperationResult::Success)
  end
end

RSpec.shared_examples 'an operation' do
  it_behaves_like 'a valid operation'
end
