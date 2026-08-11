# 🛒 OmniCart E-Commerce Quality Assurance Portfolio

![QA Status](https://img.shields.io/badge/QA_Status-Passing-brightgreen?style=for-the-badge)
![Test Framework](https://img.shields.io/badge/Testing-Manual_%7C_API_%7C_SQL-blue?style=for-the-badge)
![Documentation](https://img.shields.io/badge/Docs-Jira_%7C_Markdown-orange?style=for-the-badge)

Welcome to the **OmniCart QA Portfolio** repository! This project showcases end-to-end Quality Assurance methodologies applied to a modern, multi-platform e-commerce application. 

It covers the complete Software Testing Life Cycle (STLC)—from business requirement analysis and viewport-responsive manual test design to client-server API testing, database integrity verification, and detailed defect reporting.

---

## 📌 Project Architecture & Portfolio Deliverables

This repository is organized into four core deliverable modules:

```text
omnicart-qa-portfolio/
│
├── test-cases/
│   └── Web_Mobile_Test_Cases.md       # Phase 1: Web & Mobile Manual Test Suite
│
├── postman/
│   ├── OmniCart_API_Collection.json    # Phase 2: Postman REST API Test Collection
│   └── README.md                       # API Endpoint Documentation & Test Execution
│
├── sql-validation/
│   └── DB_Verification.sql            # Phase 3: SQL Backend Data Integrity Scripts
│
└── bug-reports/
    └── Jira_Defect_Logs.md            # Phase 4: Jira Bug Reports with Logs & Mockups
```
---

## 🛠️ Tools & Technologies Used

---

* **Test Management & Planning:** Markdown, Jira-style formatting
* **Web & Mobile Testing:** Chrome DevTools, Safari Responsive Viewport Emulation
* **API Testing:** Desktop / Web Client, RESTful JSON Payloads
* **Database Verification:** SQL (PostgreSQL / MySQL compatible)
* **Version Control:** Git, Github

---

## 🚀 Module Summaries & Key Deliverables

---

### 1.🧪 Manual Web & Mobile Test Cases (test-cases/)

* **Focus:** Cross-browser desktop (1920x1080) and responsive mobile viewport testing (iPhone 14 Pro, Pixel 7, iPad Mini).

* **Coverage:** Functional authentication, product catalog sorting, mobile layout responsiveness, cart touch targets, and end-to-end checkout validation.

* **Key Artifact:** Web_Mobile_Test_Cases.md

---

### 2.🔌 REST API Client-Server Testing (postman/)

* **Focus:** Direct backend interface testing using Postman against REST endpoints (/auth, /booking).

* **Coverage:**
        * **POST /auth:** Authentication token generation & header validation.
        * **GET /booking:** JSON array response structure validation.
        * **POST /booking:** Payload schema creation and field verification.
        * **DELETE /booking/:** id: Security header check verifying 403 Forbidden on unauthorized deletion attempts.

* **Key Artifacts:** OmniCart_API_Collection.json & postman/README.md

---

### 3.🗄️ SQL Backend Database Verification (sql-validation/)

* **Focus:** Data integrity, relational constraints, and inventory calculation audit post-UI/API execution.

* **Coverage:**
            * User record creation and password hashing verification.
            * Inventory stock deduction audit (stock_quantity decrements after checkout).
            * Relational JOINs across orders, users, and order_items tables to verify price calculations.
            * Negative testing for orphaned order records (LEFT JOIN ... WHERE parent IS NULL).

* **Key Artifact:** DB_Verification.sql

---

### 4. 🐛 Jira Defect Logging & Analysis (bug-reports/)

* **Focus:** Production-ready bug reporting formatted with actionable developer details.

* **Coverage:**
           * **OMNI-101 (Critical):** Mobile layout shift overlapping checkout call-to-action buttons.
           * **OMNI-102 (Major):** REST API unhandled 500 Internal Server Error exception on malformed JSON payload.
           * **OMNI-103 (Medium):** Database race condition allowing negative stock counts (stock_quantity < 0).
        
* **Key Artifact:** Jira_Defect_Logs.md

---

### 👨‍💻 Author

 **Bahaa Madeeh**

---