import 'dart:io';

abstract class Employee {
  late String name;
  late double salary;

  void calculateSalary();
}


class BaseEmployee implements Employee {
  @override
  late String name;
  late double salary;

  BaseEmployee(this.name, this.salary);

  @override
  void calculateSalary() {
    print('$name\'s salary: $salary');
  }
}

class FullTimeEmployee extends BaseEmployee {
  FullTimeEmployee(String name, double salary) : super(name, salary);

  @override
  void calculateSalary() {
    salary *= 1.2; 
    print('$name\'s salary (Full Time): $salary');
  }
}


class PartTimeEmployee extends BaseEmployee {
  PartTimeEmployee(String name, double salary) : super(name, salary);

  @override
  void calculateSalary() {
    salary *= 0.8;
    print('$name\'s salary (Part Time): $salary');
  }
}

void main() {
  List<Employee> employees = [
    FullTimeEmployee('Alice', 5000),
    FullTimeEmployee('Bob', 6000),
    PartTimeEmployee('Charlie', 2000),
    PartTimeEmployee('Diana', 2500),
  ];

  bool exit = false;
  while (!exit) {
    print('Employee Management System');
    print('1. View Employees and Salaries');
    print('2. Add Employee');
    print('3. Remove Employee');
    print('4. Increase Salary');
    print('5. Deduct Salary');
    print('6. Exit');

    stdout.write('Enter your choice: ');
    var choice = int.tryParse(stdin.readLineSync() ?? '');
    switch (choice) {
      case 1:
        print('Employee Details:');
        for (var employee in employees) {
          employee.calculateSalary();
        }
        break;
      case 2:
        stdout.write('Enter employee name: ');
        var name = stdin.readLineSync() ?? '';
        stdout.write('Enter employee salary: ');
        var salary = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
        stdout.write('Is the employee full-time? (yes/no): ');
        var isFullTime = stdin.readLineSync()?.toLowerCase() == 'yes';
        if (isFullTime) {
          employees.add(FullTimeEmployee(name, salary));
        } else {
          employees.add(PartTimeEmployee(name, salary));
        }
        print('Employee added successfully.');
        break;
      case 3:
        stdout.write('Enter employee name to remove: ');
        var nameToRemove = stdin.readLineSync() ?? '';
        employees.removeWhere((employee) => employee.name == nameToRemove);
        print('Employee removed successfully.');
        break;
      case 4:
        stdout.write('Enter employee name to increase salary: ');
        var nameToIncrease = stdin.readLineSync() ?? '';
        stdout.write('Enter the amount to increase: ');
        var amountToIncrease = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
        var employeeToIncrease =
            employees.firstWhere((employee) => employee.name == nameToIncrease, orElse: () => BaseEmployee('', 0.0));
        employeeToIncrease.salary += amountToIncrease;
        print('Salary increased successfully.');
        break;
      case 5:
        stdout.write('Enter employee name to deduct salary: ');
        var nameToDeduct = stdin.readLineSync() ?? '';
        stdout.write('Enter the amount to deduct: ');
        var amountToDeduct = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
        var employeeToDeduct =
            employees.firstWhere((employee) => employee.name == nameToDeduct, orElse: () => BaseEmployee('', 0.0));
        employeeToDeduct.salary -= amountToDeduct;
        print('Salary deducted successfully.');
        break;
      case 6:
        exit = true;
        break;
      default:
        print('Invalid choice. Please enter a number from 1 to 6.');
    }
  }
}
