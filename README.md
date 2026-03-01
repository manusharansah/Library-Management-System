# Library Management System 

## Overview
A complete relational database implementation for managing library books, members, authors, librarians, and book issues. Built with standard SQL and compatible with MySQL 8.0+.

---

## Files in This Repository
| File | Description |
|------|-------------|
| `library_management.sql` | Full SQL: schema, data, queries, views, transactions |
| `Library Management System.pdf` | Project report|
| `README.md` | This file |

---

## Database Schema (5 Tables)

### Author
| Column | Type | Constraint |
|--------|------|------------|
| author_id | INT | PRIMARY KEY |
| author_name | VARCHAR(100) | NOT NULL |
| nationality | VARCHAR(50) | — |

### Book
| Column | Type | Constraint |
|--------|------|------------|
| book_id | INT | PRIMARY KEY |
| title | VARCHAR(150) | NOT NULL |
| author_id | INT | FK → Author |
| genre | VARCHAR(50) | — |
| price | DECIMAL(8,2) | CHECK > 0 |
| stock | INT | DEFAULT 1, CHECK ≥ 0 |

### Member
| Column | Type | Constraint |
|--------|------|------------|
| member_id | INT | PRIMARY KEY |
| member_name | VARCHAR(100) | NOT NULL |
| phone | VARCHAR(15) | UNIQUE, NOT NULL |
| email | VARCHAR(100) | — |
| join_date | DATE | DEFAULT current date |

### Librarian
| Column | Type | Constraint |
|--------|------|------------|
| librarian_id | INT | PRIMARY KEY |
| librarian_name | VARCHAR(100) | NOT NULL |
| shift | VARCHAR(10) | CHECK (Morning/Evening/Night) |

### Issue
| Column | Type | Constraint |
|--------|------|------------|
| issue_id | INT | PRIMARY KEY |
| book_id | INT | FK → Book |
| member_id | INT | FK → Member |
| librarian_id | INT | FK → Librarian |
| issue_date | DATE | NOT NULL |
| due_date | DATE | CHECK > issue_date |
| return_date | DATE | Nullable (NULL = not returned) |
| fine | DECIMAL(6,2) | DEFAULT 0.00 |

---

## Queries Implemented

| # | Type | Description |
|---|------|-------------|
| Q1 | INNER JOIN | Books with author names |
| Q2 | LEFT JOIN | All members with borrowing history |
| Q3 | RIGHT JOIN | All librarians with issues handled |
| Q4 | COUNT + GROUP BY | Books per author |
| Q5 | SUM + AVG + GROUP BY | Price stats per genre |
| Q6 | COUNT + SUM + HAVING | Fines per member |
| Q7 | Subquery | Books priced above average |
| Q8 | Subquery (IN) | Members with unreturned books |
| Q9 | View | IssueDetails — full issue summary with status |
| Q10 | View | BookStock — available vs. issued copies |
| Q11 | Transaction COMMIT | Issue a book + update stock |
| Q12 | Transaction ROLLBACK | Reject duplicate member insert |
| Q13 | Transaction COMMIT | Return book + calculate fine |

---

## How to Run

```sql
-- In MySQL Workbench or CLI:
SOURCE library_management.sql;
```

Or step-by-step:
1. Run all `CREATE TABLE` statements
2. Run all `INSERT` statements
3. Execute any query block independently

---

## ER Diagram (Textual Description)

```
Author ──< Book >── Issue ──> Member
                      │
                      └────> Librarian
```

- **Author** (1) ─── has many ─── **Book** (M)
- **Book** (M) ─── is issued through ─── **Issue**
- **Member** (1) ─── appears in many ─── **Issue** (M)
- **Librarian** (1) ─── handles many ─── **Issue** (M)

---

## Improvements Over Basic Version
- Added `genre`, `stock`, `email`, `join_date`, `nationality`, `shift` columns
- Added `due_date`, `return_date`, `fine` to Issue table
- Added `CHECK` constraints and `DEFAULT` values throughout
- Added RIGHT JOIN and 3 Transaction demos
- Added `HAVING` clause query
- Two views (IssueDetails with status logic, BookStock with availability)
- Fine auto-calculation using `DATEDIFF` in Transaction Q13
- `CASE` expression inside view for return status

---

*Submitted as part of DBMS Practical Internal Evaluation — March 2026*
