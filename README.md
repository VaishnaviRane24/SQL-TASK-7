# SQL-TASK-7

# Task 7 – Creating and Using SQL Views

## Objective

The goal of this task was to **create and use SQL Views** in a relational database to demonstrate **data abstraction, reusability, and security**.

---

## Tools Used

* **MySQL Workbench** – For database design, query execution, and view creation.
* **MySQL Server** – To store and process the data.

---

## Database Structure

**Database Name:** `ShopDB`

**Tables:**

1. **Customers** – Stores customer details.
2. **Products** – Stores product catalog and pricing.
3. **Orders** – Tracks orders placed by customers.
4. **OrderDetails** – Links orders with purchased products.

---

## Implemented Views

### 1. `customer_order_details`

* **Purpose:** Displays detailed order information, including customer name, product, quantity, and total price.
* **Key Joins:**

  * `Customers` → `Orders` → `OrderDetails` → `Products`
* **Example Use:**

```sql
SELECT * FROM customer_order_details WHERE CustomerID = 9;
```

---

### 2. `high_value_customers`

* **Purpose:** Identifies customers whose **total purchase amount** exceeds `1000`.
* **Logic:** `SUM(o.Amount)` grouped by customer.
* **Example Use:**

```sql
SELECT * FROM high_value_customers ORDER BY LifetimeValue DESC;
```

---

### 3. `active_customers`

* **Purpose:** Shows only active customers (`IsActive = TRUE`).
* **Security:** Uses `WITH CHECK OPTION` to ensure only active customers can be added or updated through the view.
* **Example Use:**

```sql
SELECT * FROM active_customers;
```

---

## Key Concepts Learned

* **View Creation:** Using `CREATE VIEW` with complex joins.
* **Data Abstraction:** Views hide table complexity from end-users.
* **Security:** `WITH CHECK OPTION` restricts invalid updates.
* **Aggregation in Views:** Using `SUM()` and `GROUP BY` inside views.
* **Foreign Keys:** Maintaining referential integrity.

---
