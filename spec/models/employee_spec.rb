require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "#validations" do
    let!(:existing_employee) { create(:employee, phone_numbers: ['1234567890']) }

    it "does not allow blank first_name" do
      employee = build(:employee, first_name: nil)
      expect(employee).to be_invalid
    end

    it "does not allow blank last_name" do
      employee = build(:employee, last_name: nil)
      expect(employee).to be_invalid
    end

    it "does not allow duplicate mobile numbers within the array" do
      employee = build(:employee, phone_numbers: ['1234567890', '1234567890'])
      expect(employee).to be_invalid
      expect(employee.errors[:phone_numbers]).to include('must be unique within the array')
    end

    it "does not allow blank mobile numbers" do
      employee = build(:employee, phone_numbers: [])
      expect(employee).to be_invalid
    end

    it "does not allow mobile numbers already in use" do
      employee = build(:employee, phone_numbers: ['1234567890'])
      expect(employee).to be_invalid
    end

    it "allows valid mobile numbers" do
      employee = build(:employee, phone_numbers: ['9876543210'])
      expect(employee).to be_invalid
    end
  end
end
