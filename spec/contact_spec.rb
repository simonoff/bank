require 'spec_helper'

require 'bank/contact'

RSpec.describe Bank::Contact do
  let(:iban) { Bank::IBAN.new('FR14 2004 1010 0505 0001 3M026 06') }
  let(:bic) { Bank::BIC.new('BYLADEM1203') }
  let(:contact) { Bank::Contact.new(iban, bic) }

  it 'should validate' do
    expect(contact.valid?).to be_truthy
  end

  it 'should have the right types' do
    expect(contact.iban).to be_a Bank::IBAN
    expect(contact.bic).to be_a Bank::BIC
  end

  it 'should export to_h' do
    expect(contact.to_h).to eq({
                                 iban: 'FR1420041010050500013M02606',
                                 bic:  'BYLADEM1203'
                               })
  end

  it 'should export to_a' do
    expect(contact.to_a).to eq(['FR1420041010050500013M02606', 'BYLADEM1203'])
  end
end
