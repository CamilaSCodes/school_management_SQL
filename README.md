# School Database Management 

## Database schema and collection of SQL scripts tailored for managing data within an educational context

The School Database Management repository provides a comprehensive solution for managing data within an educational context. It includes database schema definitions, SQL scripts for initializing the database, inserting sample data, performing queries, and implementing advanced functionality using functions and triggers.

[![repo](https://img.shields.io/badge/repo-teal?style=plastic&logo=github&logoColor=008080&labelColor=white)](https://github.com/CamilaSCodes/court_management_SQL) &ensp; Court Database Management &emsp; | &emsp;  [![repo](https://img.shields.io/badge/repo-teal?style=plastic&logo=github&logoColor=008080&labelColor=white)](https://github.com/CamilaSCodes/school_management_SQL) &ensp; **School Database Management**

## Overview

In today's dynamic educational landscape, efficient management of student data, course offerings, and faculty resources is crucial for academic institutions to thrive. However, manual record-keeping and disparate data sources often lead to inefficiencies, hindering administrative processes and decision-making.

The School Database Management project addresses these challenges by providing a robust database schema and a suite of SQL scripts tailored for educational institutions. By implementing this solution, institutions can streamline their administrative workflows, improve data accuracy, and gain actionable insights for strategic planning.

## Schema

### Conceptual Model 

<div align="center">

![Conceptual Model](https://github.com/CamilaSCodes/school_management_SQL/blob/main/images/conceptual_model.png) 

</div>

### Logical Model 

<div align="center">

![Logical Model](https://github.com/CamilaSCodes/school_management_SQL/blob/main/images/logical_model.png) 

</div>

### Entity Relationship Diagram

<div align="center">

![EDR](https://github.com/CamilaSCodes/school_management_SQL/blob/main/images/ERD-school-management.png) 

</div>

## Scripts

### create.sql
   
This script is responsible for initializing the database structure. It begins by dropping the database if it already exists to ensure a clean slate. Then, it creates a new database named "school-management-DB" with specified settings such as encoding, locale, and owner. These settings ensure that the database is configured appropriately for storing data related to school management.

### tables.sql
   
The "tables.sql" script defines the database schema by creating tables for storing various entities relevant to school management. It creates tables for:
* Students (alunos): Stores information about students, including their names, birthdates, addresses, contact details, etc.
* Courses (disciplinas): Holds details of courses offered, such as course names and IDs, along with the ID of the professor teaching each course.
* Professors (professores): Contains information about professors, including their names, birthdates, contact details, etc.
* Enrollments (matriculas): Records the enrollment of students in courses, with references to student and course IDs.

### insert.sql

This script inserts sample data into the tables created in the previous script. It provides realistic data examples for students, professors, courses, and enrollments. Each INSERT statement adds a new record to the respective table, simulating a populated database environment. This sample data allows users to explore the functionality of the system and run queries against real-world scenarios.

### queries.sql

The "queries.sql" script contains a series of SQL queries designed to extract insights and perform analysis on the school management data. Each query serves a specific analytical purpose:
* Retrieving student information (SELECT * FROM alunos).
* Counting enrollments (SELECT COUNT(DISTINCT cd_matricula_ma) FROM matriculas).
* Calculating averages (SELECT AVG(date_part('Year', age(CURRENT_DATE,dt_nascimento_al))) FROM alunos).
* Identifying patterns within the data (e.g., finding professors with 'Leal' in their names).

### scripts.sql

The scripts.sql file contains database functions and triggers. Database functions encapsulate reusable logic that can be executed within SQL statements. Triggers are special types of stored procedures that are automatically executed in response to specific events, such as INSERT, UPDATE, or DELETE operations on tables.

In this file:

* A script creates a view named `ver_informacoes`, which presents detailed information about students, including gender, enrollment date, enrolled discipline, and respective professor. Results are ordered by discipline name and student name in descending order.
* A trigger and function combination is provided to track changes made to specific fields in the `alunos` table. It logs these changes into the `logs_usuarios` table, providing accountability and auditability for data modifications.
* Another trigger and function combination automate the process of recording changes made to specific fields in the `disciplinas` table and manage the enrollment process for students in those disciplines by creating entries in the `matriculas` table.

## Usage

**1. Database Setup:**

  * Execute the `create.sql` script to initialize the database structure. This will create a new PostgreSQL database named "school-management-DB" with the required settings.
  * Run the `tables.sql` script to define the database schema by creating tables for students, courses, professors, and enrollments.

**2. Populate Sample Data:**

  * Use the `insert.sql` script to insert sample data into the database tables. This will provide realistic data examples for students, professors, courses, and enrollments.

**3. Analyzing Data:**

  * Explore the `queries.sql` script, which contains SQL queries designed to extract insights and perform analysis on the school management data. Run these queries to gain valuable information from your database.

**4. Advanced Functionality:**

  * Check out the `scripts.sql` file, which contains database functions and triggers. These can be utilized to automate tasks, track changes, and perform advanced operations on the database.

**5. Gain Insights:**

  * Optionally, refer to the [conceptual](https://github.com/CamilaSCodes/school_management_SQL/blob/main/conceptual_model.brM3)  and [logical](https://github.com/CamilaSCodes/school_management_SQL/blob/main/logical_model.brM3) models created using BRModelo and the [ERD](https://github.com/CamilaSCodes/school_management_SQL/blob/main/ERD-school-management.pgerd) created using PostgreSQL for further insights into the database structure.

## Technologies
![PostgreSQL Badge](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=fff&style=for-the-badge)

