  module Api
    module V1
      class EmployeesController < ApplicationController
        skip_before_action :verify_authenticity_token, only: [:create]
        before_action :set_employee, only: [:tax_deduction]

        def create
          @employee = Employee.new(employee_params)

          if @employee.save
            render json: @employee, status: :created
          else
            render json: @employee.errors, status: :unprocessable_entity
          end
        end

        def tax_deduction
          yearly_salary = calculate_yearly_salary(@employee)
          tax_amount = calculate_tax(yearly_salary)
          cess_amount = calculate_cess(yearly_salary)

          render json: {
            employee_code: @employee.employee_id,
            first_name: @employee.first_name,
            last_name: @employee.last_name,
            yearly_salary: yearly_salary,
            tax_amount: tax_amount,
            cess_amount: cess_amount,
          }
        end

        private

        def calculate_yearly_salary(employee)
          monthly_salary = employee.salary
          total_working_days = (Date.today - employee.doj).to_i
          company_salary = (employee.salary * 12) / 365
          (company_salary * total_working_days).to_i
        end

        def calculate_tax(yearly_salary)
          case yearly_salary
          when 0..250000
            0
          when 250001..500000
            0.05 * (yearly_salary - 250000)
          when 500001..1000000
            0.1 * (yearly_salary - 500000) + 12500
          else
            0.2 * (yearly_salary - 1000000) + 12500 + 50000
          end
        end

        def calculate_cess(yearly_salary)
          additional_cess_threshold = 2500000
          additional_cess_rate = 0.02

          additional_cess = [yearly_salary - additional_cess_threshold, 0].max * additional_cess_rate

          additional_cess.round
        end

        def set_employee
          @employee = Employee.find_by(employee_id: params[:employee_id])
        end

        def employee_params
          params.require(:employee).permit(
            :employee_id,
            :first_name,
            :last_name,
            :email,
            :doj,
            :salary,
            phone_numbers: []
          )
        end
      end
    end
  end
