# EmployeeManagement

This application is using:
* Rails: 7.1.2
* Ruby 3.1.2

## Database
* Postgresql

### Create database
Before running the migrations we need to create a database.
Connecto to Postgres DB and run the following command.
```
rails db:create
```

### Configure database
There is an example DB configuration file `database.yml` placed in `config` folder.

* Create ENV variable for DATABASE_USERNAME  and DATABASEPASSWORD

### Run migrations
```
rails db:migrate
```

## Run the application
```
rails s
```

## API for Create Employee
```
POST
#{base_url}/api/v1/employees

Example body data

{
  "employee": {
    "employee_id": "123CK",
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe8@example.com",
    "phone_numbers": ["9134567896", "9876543216"],
    "doj": "2023-05-17",
    "salary": 600000
  }
}

```

## API for get employee Tax deduction
```
GET
#{base_url}/api/v1/employees/tax_deduction

Example body data

{
    "employee_id": "123CI"
}

```
