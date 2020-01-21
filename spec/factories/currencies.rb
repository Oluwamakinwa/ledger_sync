# frozen_string_literal: true

FactoryBot.define do
  factory :currency, class: LedgerSync::Currency do
    exchange_rate { 1.5 }
    sequence(:name) { |n| "Test Currency #{rand_id}-#{n}" }
    symbol { 'ZZZ' }
  end
end