require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { build(:request) }

  context 'When is new' do
    it { expect(request).not_to be_status }
  end

  it { is_expected.to validate_presence_of :product_id }
  it { is_expected.to validate_presence_of :department_id }
  it { is_expected.to validate_presence_of :date }

  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:request_type) }
  it { is_expected.to respond_to(:document) }
  it { is_expected.to respond_to(:document_code) }
  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:unit_price) }
  it { is_expected.to respond_to(:total_price) }
  it { is_expected.to respond_to(:observation) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:product_id) }
  it { is_expected.to respond_to(:department_id) }

end
