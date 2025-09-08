# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { build(:request) }

  context 'When is new' do
    it { expect(request).not_to be_status }
  end

  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :description }

  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:request_type) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:document_type) }
  it { is_expected.to respond_to(:document_code) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:supplier_id) }
  it { is_expected.to respond_to(:product_id) }
  it { is_expected.to respond_to(:department_id) }
  it { is_expected.to respond_to(:user_id) }
end
