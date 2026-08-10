```markdown
# 📋 Software Test Plan: OmniCart E-Commerce Platform

**Document ID:** TP-OMNI-2026-V1  
**Author:** QA Engineer  
**Status:** Approved  

---

## 1. Introduction
The objective of this Test Plan is to define the QA strategy, execution scope, test environments, and criteria for the OmniCart E-Commerce application. The goal is to ensure application stability across Web interfaces, Mobile responsive viewports, and backend client-server communications.

---

## 2. Scope of Testing

### 2.1 In-Scope Features
* **User Authentication:** Login, registration, session storage, and unauthorized page access handling.
* **Product Management:** Search, category filters, product details view.
* **Cart & Checkout:** Adding items, cart drawer responsiveness, price calculations, order placement.
* **REST API Testing:** Authentication endpoints (`/auth`), booking/cart payload validation, status code checks.
* **Database Verification:** Data persistence checks post-transaction (Order records, Inventory stock adjustments).

### 2.2 Out-of-Scope
* Production third-party payment gateway processing (sandboxed/mocked).
* Performance and Load Testing.

---

## 3. Test Strategy & Methodology

The project follows the **Agile Scrum** development framework:
* **Sprint Cycle:** 2-Week Sprints with Continuous Testing.
* **Testing Levels:** 
  * **System Testing:** End-to-end UI testing on Web and Mobile Viewports.
  * **Integration Testing:** API endpoint validation via Postman and Client-Server network payload checks.
  * **Backend Verification:** Executing SQL queries after UI actions to confirm backend state integrity.
* **Defect Lifecycle:** Open ➔ In Review ➔ In Fix (Dev) ➔ Ready for QA ➔ Re-tested & Closed.

---

## 4. Test Environment Specifications

| Component | Specification |
| :--- | :--- |
| **Web Browsers** | Google Chrome (v126+), Mozilla Firefox (v125+) |
| **Mobile Emulation** | Chrome DevTools (iPhone 14 Pro: 393x852, Pixel 7: 412x915) |
| **API Client** | Postman Desktop Client (v10+) |
| **Database Engine** | SQLite 3 / DBeaver DB Client |
| **Defect Tracking** | Jira Software (Agile Scrum Board) |

---

## 5. Entry & Exit Criteria

### Entry Criteria
1. Requirements and acceptance criteria are defined.
2. Target application URL and Postman API endpoints are accessible.
3. Sample database seeded with baseline user and inventory data.

### Exit Criteria
1. 100% of planned Critical and High priority test cases executed.
2. 0 Critical (Blocker) defects remain open.
3. All identified defects logged in Jira with reproduction steps, network logs, and screenshots.