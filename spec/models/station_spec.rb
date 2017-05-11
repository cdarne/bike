require 'rails_helper'

RSpec.describe Station, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_numericality_of(:latitude) }

    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_numericality_of(:longitude) }

    it { is_expected.to validate_presence_of(:available_bikes) }
    it { is_expected.to validate_numericality_of(:available_bikes).only_integer }
  end
end
