# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  let(:department) { build(:department) }

  context 'When is new' do
    it { expect(department).to be_status }
  end

  it { is_expected.to validate_presence_of :description }

  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:status) }
end
