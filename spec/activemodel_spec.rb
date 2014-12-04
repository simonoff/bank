require 'spec_helper'

class Company
  include ActiveModel::Model

  attr_accessor :iban, :name
  validates :iban, iban: true

  def persisted?
    false
  end
end

class Person
  include ActiveModel::Model

  attr_accessor :iban
  validates :iban, iban: true, allow_nil: true

  def persisted?
    false
  end
end

RSpec.describe IbanValidator do
  let(:model) { ::Company.new }

  it 'should be valid' do
    model.iban = 'FR1420041010050500013M02606'
    expect(model.valid?).to be_truthy
  end

  it 'should not be valid' do
    model.iban = 'FR1420041010050500013'
    expect(model.valid?).to be_falsey
    expect(model.errors[:iban]).to include 'is invalid'
  end

  it 'should not validate with nil value' do
    expect(model.iban).to be_nil
    expect(model.valid?).to be_falsey
  end

  it 'should not use the validator with option allow_nil: true' do
    person = Person.new
    expect(person.iban).to be_nil
    expect(person.valid?).to be_truthy
  end
end
