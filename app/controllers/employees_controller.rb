class EmployeesController < ApplicationController
  #before_action :set_employee, only: [:show, :update, :destroy]

  def index
    @employees = Employee.all
    render json: @employees
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
  end

   def show
   @employee = Employee.all
   render json: @employee
  end

 def tax_deduction
    current_financial_year_start = Date.new(Date.today.year, 4, 1)
    current_financial_year_end = Date.new(Date.today.year + 1, 3, 31)

    employees = Employee.where("doj >= ? AND doj <= ?", current_financial_year_start, current_financial_year_end)

    tax_deductions = employees.map do |employee|
      total_salary = calculate_total_salary(employee)
      tax_amount, cess_amount = calculate_tax_and_cess(total_salary)
      
      {
        employee_code: employee.employee_code,
        first_name: employee.first_name,
        last_name: employee.last_name,
        yearly_salary: total_salary,
        tax_amount: tax_amount,
        cess_amount: cess_amount
      }
    end

    render json: tax_deductions
  end

def calculate_total_salary(employee)
    total_months = ((Date.today.year * 12 + Date.today.month) - (employee.doj.year * 12 + employee.doj.month)) + 1
    total_salary = employee.salary * total_months
    total_salary
  end


def calculate_tax_and_cess(yearly_salary)
    tax_amount = 0
    cess_amount = 0

    if yearly_salary <= 250000
      tax_amount = 0
    elsif yearly_salary <= 500000
      tax_amount = (yearly_salary - 250000) * 0.05
    elsif yearly_salary <= 1000000
      tax_amount = 12500 + (yearly_salary - 500000) * 0.1
    else
      tax_amount = 62500 + (yearly_salary - 1000000) * 0.2
    end

    if yearly_salary > 2500000
      cess_amount = (yearly_salary - 2500000) * 0.02
    end

    [tax_amount, cess_amount]
  end


 private

  def set_employee
   #@employee = Employee.find(params[:id])
    @employee = Employee.find(params[:id]) if params[:id].present?
  end

  def employee_params
    params.permit(:employee_id, :first_name, :last_name, :email, :phone_numbers, :doj, :salary)
  end

end #Class End
