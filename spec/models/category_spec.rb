require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  context 'When is new' do
    it { expect(category).to be_status }
  end

  it { is_expected.to have_many(:products) }

  it { is_expected.to validate_presence_of :description }

  it { is_expected.to respond_to(:description) }
end
