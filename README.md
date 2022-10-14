# Pewlett_Hackard_Analysis

## Overview of the Anaylsis
The goal of our analysis is to determine the number of employees that are reaching their retirement age. This data will be used to forecast how many roles will need to be filled as well as which employees can be eligible for internal mentoring. We use PostGresSQL to create tables and relationships to query large datasets. 

## Results

To being this analysis, we use QuickDBD to map out our database. Below is the code:

    ```
    Departments
    -
    dept_no varchar pk fk - Dept_Emp.dept_no
    dept_name varchar

    Employees
    -
    emp_no int pk fk -< Dept_Emp.emp_no
    birth_date date
    first_name varchar
    last_name varchar
    gender varchar
    hire_date date

    Managers
    -
    dept_no varchar pk fk - Departments.dept_no
    emp_no int pk fk - Employees.emp_no
    from_date date
    to_date date

    Salaries
    -
    emp_no int pk fk - Employees.emp_no
    salary int
    form_date date
    to_date date

    Dept_Emp
    -
    dept_no varchar pk fk -< Employees.emp_no
    emp_no int pk fk - Salaries.emp_no
    from_date date
    to_date date

    Titles
    -
    emp_no int pk fk -< Employees.emp_no
    title varchar 
    from_date date
    to_date date
    ```

Next, we need to create tables and relationships within the tables in our SQL database. Below is an example of two tables being created:

    ```
    -- Creating tables for PH-EmployeeDB
    CREATE TABLE departments (
        dept_no VARCHAR(4) NOT NULL,
        dept_name VARCHAR(40) NOT NULL,
        PRIMARY KEY (dept_no),
        UNIQUE (dept_name)
    );

    CREATE TABLE employees (
	    emp_no INT NOT NULL,
        birth_date DATE NOT NULL,
        first_name VARCHAR NOT NULL,
        last_name VARCHAR NOT NULL,
        gender VARCHAR NOT NULL,
        hire_date DATE NOT NULL,
        PRIMARY KEY (emp_no)
    );
    ```

Following the formation of our schema, the data must be imported from our CSV files. This is easily done within pgAdmin by right-clicking on each table and importing the corresponding data. We can then check, within the query editior, if the data imported successfully by typing: 
    
    ```
    SELECT * FROM 'table';
    ```

Lastly, we can run queries on the data. This is used to filter data within different table into one seperate sheet. An example of this is using the following code to return a count of employees in each department: 

    ```
    -- Employee count by department number
    SELECT COUNT(ce.emp_no), de.dept_no
    FROM current_emp as ce
    LEFT JOIN dept_emp as de
    ON ce.emp_no = de.emp_no
    GROUP BY de.dept_no;
    ```


## Summary

