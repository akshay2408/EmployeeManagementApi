require 'rails_helper'

RSpec.describe Api::V1::EmployeesController, type: :controller do
  let(:employee) { create(:employee) }

  describe "POST create" do
    it "creates a new employee" do
      expect {
        post :create, params: {
          employee: {
            employee_id: '123',
            first_name: 'John',
            last_name: 'Doe',
            email: 'john.doe@example.com',
            doj: '2023-01-01',
            salary: 50000.0,
            phone_numbers: ['1234567890', '9876543210']
          }
        }, format: :json
      }.to change(Employee, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "GET tax_deduction" do
    it "returns tax deduction" do
      get :tax_deduction, params: { employee_id: employee.employee_id }, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end
