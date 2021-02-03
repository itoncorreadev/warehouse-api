require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build(:product) }

  context 'When is new' do
    it { expect(product).not_to be_product_type }
    it { expect(product).to be_status}
  end

  it { is_expected.to belong_to(:group) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :group_id }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:category) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:product_type) }
  it { is_expected.to respond_to(:measure) }
  it { is_expected.to respond_to(:min) }
  it { is_expected.to respond_to(:med) }
  it { is_expected.to respond_to(:max) }
  it { is_expected.to respond_to(:location) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:group_id) }
end
