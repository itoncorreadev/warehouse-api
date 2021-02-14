require 'rails_helper'

RSpec.describe Detail, type: :model do
  let(:detail) { build(:detail) }

  it { is_expected.to validate_presence_of :product_id }
  it { is_expected.to validate_presence_of :request_id }
  it { is_expected.to validate_presence_of :quantity }

  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:unit_price) }
  it { is_expected.to respond_to(:total_price) }
  it { is_expected.to respond_to(:observation) }
  it { is_expected.to respond_to(:product_id) }
  it { is_expected.to respond_to(:request_id) }

end
