

class Employee

  attr_reader :name, :salary

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end


end


class Manager < Employee

  attr_reader :employees, :salary

  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    multiplier * get_employees_salary(self)
  end

  def get_employees_salary(employee)
    total_salary = 0
    employee.employees.each do |sub_employee|
      total_salary += sub_employee.salary

      unless sub_employee.class == Employee || sub_employee.employees.empty?
        total_salary += get_employees_salary(sub_employee)
      end
    end

    total_salary
  end

end

if $PROGRAM_NAME == __FILE__
  daniel = Employee.new("Daniel", "Student", 100, "Jonathan")
  jorge = Employee.new("Jorge", "Student", 50, "Jonathan")
  jonathan = Manager.new("Jonathan", "Instructor", 300, "Kush")
  jonathan.employees << daniel
  jonathan.employees << jorge
  kush = Manager.new("Kush", "CEO", 1000, nil)
  kush.employees << jonathan

  puts kush.bonus(2)
end