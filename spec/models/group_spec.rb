require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { build(:group) }

  context 'When is new' do
    it { expect(group).to be_status }
  end

  it { is_expected.to have_many(:products).dependent(:destroy) }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to respond_to(:name) }
end
