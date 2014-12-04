require 'spec_helper'

RSpec.describe Bank::BIC do
  let(:bic) { ::Bank::BIC.new('ABNACHZ8XXX') }

  it 'returns the right bank code' do
    expect(bic.bank_code).to eq 'ABNA'
  end

  it 'returns the right country code' do
    expect(bic.country_code).to eq 'CH'
  end

  it 'returns the right location code' do
    expect(bic.location_code).to eq 'Z8'
  end

  it 'returns the right branch code' do
    expect(bic.branch_code).to eq 'XXX'
  end

  [8, 11].each do |len|
    context 'x' * len do
      it 'has a valid length' do
        expect(::Bank::BIC.new('x' * len).valid_length?).to be_truthy
      end
    end
  end

  1.upto(20) do |len|
    if len != 8 && len != 11
      context 'x' * len do
        it 'has a valid length' do
          expect(::Bank::BIC.new('x' * len).valid_length?).to be_falsey
        end
      end
    end
  end

  %w(UCJAES2MXXX ABAGATWWXXX UCJAES2MXXX).each do |code|
    context code do
      it 'has a valid format' do
        expect(::Bank::BIC.new(code).valid_format?).to be_truthy
      end
    end
  end

  [
    '12341234'
  ].each do |code|
    context code do
      it 'has an invalid format' do
        expect(::Bank::BIC.new(code).valid_format?).to be_falsey
      end
    end
  end

end
