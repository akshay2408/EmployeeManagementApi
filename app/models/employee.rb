class Employee < ApplicationRecord
  validates :first_name, :last_name, :phone_numbers, :doj, :salary, presence: true
  validates :email, :employee_id, presence: true, uniqueness: true

  validate :unique_mobile_numbers

  private

  def unique_mobile_numbers
    if phone_numbers.present?
      if phone_numbers.uniq.length != phone_numbers.length
        errors.add(:phone_numbers, 'must be unique within the array')
      end

      if phone_numbers.blank?
        errors.add(:phone_numbers, 'cannot be blank')
      end
      existing_numbers = Employee.where.not(id: nil).where("ARRAY[?]::text[] <@ phone_numbers", phone_numbers).pluck(:phone_numbers).flatten
      duplicates = phone_numbers & existing_numbers
      errors.add(:phone_numbers, "mobile numbers #{duplicates.join(', ')} are already in use") if duplicates.present?
    end
  end
end
