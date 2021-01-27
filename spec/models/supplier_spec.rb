require 'rails_helper'

RSpec.describe Supplier, type: :model do
  let(:supplier) { build(:supplier) }

  it { is_expected.to validate_presence_of :description }

  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:type_document) }
  it { is_expected.to respond_to(:document) }
  it { is_expected.to respond_to(:address) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:comment) }
end
