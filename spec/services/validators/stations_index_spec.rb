require 'rails_helper'

RSpec.describe Validators::StationsIndex, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_numericality_of(:latitude) }

    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_numericality_of(:longitude) }

    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_numericality_of(:radius) }

    it { is_expected.to validate_presence_of(:empty) }
    it { is_expected.to validate_inclusion_of(:empty).in_array(%w(true false)) }
  end

  describe 'unpermitted params' do
    it 'sets a base error' do
      v = Validators::StationsIndex.new({ plop: :test })
      expect(v.errors.values).to eq([['unknown_parameters: plop']])
    end
  end
end
