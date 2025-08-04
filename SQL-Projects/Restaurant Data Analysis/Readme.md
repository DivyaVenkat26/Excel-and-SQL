# Restaurant SQL Analysis Project

## Objective
This project explores how customers are responding to a new restaurant menu using structured query analysis. It involves analyzing menu details, order behavior, and linking both datasets for meaningful insights.

---

## Dataset Files (under `/data/`)
- `menu_items.csv`: Contains details of each item on the new menu (name, category, price, etc.)
- `order_details.csv`: Transactional data showing which items were ordered and when
- `data_dictionary.csv`: Describes the schema of the database tables

---

## Project Files
- `restaurant_sql_analysis.pptx`: Final presentation containing SQL queries, result snapshots, and key insights

---

## Project Objectives

### Objective 1: Explore the Menu (`menu_items`)
- Count total items
- Find least and most expensive items
- Count Italian dishes and find their pricing trends
- Calculate average dish price by category

### Objective 2: Analyze Order Data (`order_details`)
- Identify the range of order dates
- Count total orders and items sold
- Find largest orders (by item count)
- Analyze frequency of large orders

### Objective 3: Combine and Analyze (`menu_items` + `order_details`)
- Join datasets to find most and least ordered items (with categories)
- Discover top 5 highest-spending orders
- Deep-dive into the highest order and purchasing behavior

---

## Key Insights
- Italian dishes are popular but show wide price variation
- A small set of orders contribute disproportionately to total revenue
- Some high-priced items are rarely ordered — indicating pricing friction

---

##  Tools Used
- SQL (MySQL)
- PowerPoint (for presenting insights)

---
