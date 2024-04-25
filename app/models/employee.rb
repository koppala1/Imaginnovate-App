class Employee < ApplicationRecord
  validates :employee_id, :first_name, :last_name, :email, :phone_numbers, :doj, :salary, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
  validates :phone_numbers, presence: true
  validates :salary, numericality: { greater_than: 0 }
end

