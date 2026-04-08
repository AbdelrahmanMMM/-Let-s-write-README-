# 🚴 Bike Store ETL Pipeline (Big Data Project)

## 📌 Overview

This project demonstrates an end-to-end **Big Data ETL pipeline** using modern data engineering tools.
It simulates a real-world workflow starting from relational databases to a data warehouse for analytics.

---

## 🏗️ Architecture

MariaDB → Sqoop → HDFS (Staging) → Spark → Hive (Data Warehouse)

---

## 🛠️ Tech Stack

* **Database:** MariaDB
* **Ingestion:** Sqoop
* **Storage:** Hadoop HDFS
* **Processing:** Apache Spark
* **Data Warehouse:** Apache Hive

---

## 📂 Project Structure

```
bike-store-etl/
│
├── spark/
│   └── bike_store_etl_pipeline.ipynb
│
├── sqoop/
│   └── sqoop_commands.txt
│
├── hive/
│   └── hive_queries.sql
│
├── README.md
```

---

## 📊 Dataset

* Source: Bike Store dataset (Kaggle)
* Domains:

  * Sales (orders, customers, order_items)
  * Production (products, brands, categories, stocks)

---

## 🔄 ETL Pipeline

### 1. Data Ingestion (MariaDB → HDFS)

* Loaded CSV data into MariaDB
* Handled foreign key dependencies
* Used Sqoop to import data into HDFS staging zone

Example:

```bash
sqoop import \
--connect jdbc:mysql://localhost:3306/sales \
--username root \
--password **** \
--table orders \
--target-dir /staging/orders \
--delete-target-dir
```

---

### 2. Data Transformation (Spark)

* Read data from HDFS (no headers)
* Renamed columns using schema
* Converted data types (string → date)
* Created calculated column:

```python
total_price = quantity * list_price * (1 - discount)
```

* Joined multiple tables:

  * orders
  * order_items
  * customers
  * products

---

### 3. Data Aggregation (KPIs)

Generated key business insights:

* 📊 **Sales per Store**
* 🏆 **Top Products by Revenue**
* 👥 **Top Customers by Spending**

---

### 4. Data Warehouse (Hive)

* Created database: `bike_dw`
* Stored results using Spark `saveAsTable()`
* Built:

  * Managed tables
  * External tables

Example:

```sql
CREATE EXTERNAL TABLE bike_dw.sales_kpi_ext (
    store_id INT,
    total_sales DOUBLE,
    total_orders BIGINT
)
STORED AS PARQUET
LOCATION '/user/hive/warehouse/bike_dw.db/sales_kpi';
```

---

## 📊 Sample Output

| store_id | total_sales | total_orders |
| -------- | ----------- | ------------ |
| 1        | 1605823.03  | 1006         |
| 2        | 5215751.27  | 3195         |
| 3        | 867542.24   | 521          |

---

## ⚡ Challenges & Solutions

### 🔹 Missing Headers in HDFS

* Solved using manual column renaming in Spark

### 🔹 Data Type Mismatch (INT vs BIGINT)

* Fixed by aligning Spark and Hive schemas

### 🔹 Limited VM Resources

* Reduced shuffle partitions
* Avoided unnecessary caching

### 🔹 HBase Integration (Optional)

* Attempted integration using Hive StorageHandler
* Faced ZooKeeper and HBase service issues
* Gained understanding of distributed dependencies

---

## ▶️ How to Run the Project

1. Load dataset into MariaDB
2. Use Sqoop to import data into HDFS
3. Run Spark notebook/script for transformations
4. Save results into Hive tables
5. Query results using Spark SQL or Hive

---

## 🎯 Key Learnings

* Built a full ETL pipeline using Big Data tools
* Understood staging → transformation → warehouse architecture
* Gained hands-on experience with Spark joins and aggregations
* Learned how to debug distributed system issues

---

## 🚀 Future Improvements

* Complete Hive ↔ HBase integration
* Add Airflow for orchestration
* Optimize performance using partitioning
* Build dashboards (Power BI / Tableau)

---

## 👨‍💻 Author

Abdelrahman Malek
Aspiring Data Engineer / BI Developer
