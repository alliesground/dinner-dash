require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:categories) }
    it { should validate_presence_of :title }
    it { should validate_presence_of :desc }
    it { should validate_uniqueness_of :title }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end
end
