# Agriculture Data Management

_A system designed to digitize, organize, and enhance the management of agricultural data for improved efficiency and decision-making._

## **Introduction**

This project, **Agriculture Data Management**, was developed to digitize and modernize the management of agricultural data. The process began with the transformation of a physical **Agriculture Form** traditionally used for collecting information into a structured, digital online form. The objective was to eliminate manual data handling, reduce errors, and enable better data analysis and reporting.

---

## Project Overview

The main goal of this project is to design and implement a database system that supports the efficient collection, storage, and management of agricultural data. This work includes:

1. **Understanding the Physical Form**: The project started with analyzing the existing physical **Agriculture Form**. This form contained detailed fields used by agricultural organizations for managing farmer, land, and production data.

2. **Miniworld Definition**: A conceptual representation of the domain was created to ensure every key aspect of the agricultural data process was captured.

3. **Database Modeling**:
    - **Conceptual Model**: A high-level view of the database structure was designed to represent entities and their relationships.
    - **Logical Model**: Converted the conceptual model into a logical schema for relational databases.
    - **Physical Model**: Implemented the logical schema into a SQL-compatible database.

4. **Database Implementation**:
    - Structured the database into normalized tables.
    - Created procedures, triggers, and views for efficient data management.
    - Pre-populated data to mimic real-world scenarios for testing and analysis.

5. **Query and Reporting**: Developed SQL queries and views for:
    - Accessing farmer details.
    - Fetching reports on properties, products, and demands.
    - Monitoring updates using triggers to maintain logs of changes.

---

## Files in the Repository

The repository is structured as follows:

- **sql/schema.sql**: Contains the database schema, including all tables, primary and foreign keys, and constraints.
- **sql/inserts.sql**: Includes a stored procedure to populate the database with test data (up to 10,000 records).
- **sql/procedures_and_triggers.sql**: Defines triggers and procedures for logging updates and automating data population.
- **sql/queries_and_views.sql**: Includes example queries and views to demonstrate the use of the database.
- **docs/agriculture_form**: A scanned or digital copy of the original physical agriculture form used as a basis for this project.
- **docs/miniworld_description**: A description of the miniworld designed for the project.
- **docs/conceptual_model**: The conceptual database design.
- **docs/logical_model**: The logical database schema.
- **docs/physical_model**: The physical implementation details of the database.

---

## Key Features

- **Normalization**: The database structure is fully normalized to reduce redundancy and improve efficiency.
- **Triggers and Logs**: Changes to key tables are automatically logged for traceability.
- **Comprehensive Data Representation**: The schema captures key aspects such as:
  - Farmers and their demographics.
  - Property ownership and land use.
  - Technical staff assignments.
  - Social organization affiliations.
  - Agricultural products and demands.
- **Pre-populated Data**: The database is seeded with synthetic data to simulate real-world scenarios for testing.

---

## Usage Instructions

1. Clone this repository:
    ```bash
    git clone https://github.com/math-hrque/agriculture-data-management.git
    ```
2. Import the database schema (`sql/schema.sql`) into your SQL-compatible database.
3. Run the data population script (`sql/inserts.sql`) to populate the database.
4. Execute the procedures and triggers script (`sql/procedures_and_triggers.sql`) to set up logging and automation.
5. Explore the queries and views provided in `sql/queries_and_views.sql`.

---

## How It Works

This database system supports:
- Storing detailed information about farmers, their families, and properties.
- Logging updates to ensure data integrity.
- Enabling complex queries to analyze agricultural data for decision-making.

---

## Future Improvements

- Integrate a front-end web application for farmers and administrators.
- Add advanced analytics features using tools like Power BI or Tableau.
- Implement API endpoints for easier integration with external systems.
