# 🐛 OmniCart Jira Defect & Bug Report Logs

**Project:** OmniCart E-Commerce Platform  
**Repository Module:** Backend & Frontend Quality Assurance  
**Document Version:** 1.0  
**Author:** QA Lead / Engineer  

---

## 📌 Defect Metrics & Summary

| Issue Key    | Severity | Priority | Component            | Defect Title                                                          | Status |
| :---         | :---     | :---     | :---                 | :---                                                                  | :--- |
| **OMNI-101** | Critical | High     | Mobile UI / Checkout | Mobile Viewport: Cart Badge Overlaps Checkout Button on Small Screens | Open |
| **OMNI-102** | Major    | High     | REST API / Auth      | 500 Internal Server Error on Invalid Auth Payload Structure           | Open |
| **OMNI-103** | Medium   | Medium   | DB / Inventory       | Stock Quantity Displays Negative Value on Race Condition Purchases    | In Review |

---

## Bug Report 1: OMNI-101 (Mobile Viewport Defect)

* **Issue Key:** `OMNI-101`
* **Summary:** Mobile Viewport: Shopping Cart Badge Overlaps Checkout Button on Narrow Screens (< 390px)
* **Type:** Bug
* **Component:** Mobile Web UI / Responsive Layout
* **Severity:** Critical (Blocks checkout flow on smaller devices)
* **Priority:** High
* **Environment:** iPhone 13 Mini / iPhone SE (375x667 Viewport), iOS 17.2, Safari & Chrome Mobile Emulation

### Description
On screens with a viewport width of 375px or smaller, adding more than 2 items to the shopping cart causes the cart badge notification container to wrap incorrectly. The fixed position container overlaps the primary **"Checkout"** call-to-action button, preventing user touch events from registering on the checkout button.

### Steps to Reproduce
1. Open Chrome DevTools (`F12`) and toggle the Device Toolbar (`Ctrl + Shift + M`).
2. Set dimensions to **iPhone SE** (Width: `375px`, Height: `667px`).
3. Navigate to `https://www.saucedemo.com/` and log in as `standard_user`.
4. Add 3 items to the cart.
5. Tap the Cart icon in the upper-right header to navigate to `/cart.html`.
6. Scroll to the bottom of the page and attempt to tap the **"Checkout"** button.

### Expected Result
* The Cart Badge remains confined within the top header area.
* The "Checkout" button remains unobstructed with a clear, tappable surface ($\ge 44 \times 44\text{px}$).

### Actual Result
* The cart item container extends past its container boundary (`div.cart_contents_container`).
* The floating element overlaps the **"Checkout"** button, capturing touch events and preventing navigation to `/checkout-step-one.html`.

### Console / Inspect Logs
```text
[Layout shift warning] Element 'div.shopping_cart_badge' caused layout shift (CLS: 0.24).
[Pointer Event Error] Pointer event <PointerEvent> intercepted by overlapping child element div.cart_item_label.

### Visual Proof/Screenshot Mockup

+------------------------------------------+
|  [≡]  Swag Labs            [🛒(3)]       |  <-- Header
+------------------------------------------+
|  YOUR CART                               |
|  - Sauce Labs Backpack     $29.99        |
|  - Sauce Labs Bike Light   $9.99         |
|  - Sauce Labs Bolt T-Shirt $15.99        |
|                                          |
|  +------------------------------------+  |
|  |  [ CONTINUE SHOPPING ]             |  |
|  |  +------------------------------+  |  |
|  |  | [ CHECKOUT ] (OVERLAPPED!)   |  |  |  <-- Defect: Overlapping div blocks click
|  +--+------------------------------+--+  |
+------------------------------------------+

## Bug Report 2: OMNI-102 (REST API Backend Error)

* **Issue Key:** `OMNI-102`
* **Summary:** POST /auth returns 500 Internal Server Error instead of 400 Bad Request when JSON key is malformed
* **Type:** Bug
* **Component:** REST API / Authentication Service
* **Severity:** Major
* **Priority:** High
* **Environment:** Postman v10.22 / Staging Environment (https://restful-booker.herokuapp.com/auth)

### Description
When submitting an authentication request to /auth with a missing or malformed JSON key (e.g., "user_name" instead of "username"), the server responds with a 500 Internal Server Error unhandled exception rather than a gracefully formatted 400 Bad Request validation error response.

### Steps to Reproduce
1. In Postman, create a new POST request to https://restful-booker.herokuapp.com/auth.
2. Add Header: Content-Type: application/json.
3. Set raw JSON body with malformed key name:
    {
    "invalid_user_key": "admin",
    "password": "password123"
    }
4. Click Send

### Expected Result
* Status Code: 400 Bad Request or 422 Unprocessable Entity
* Response Body:
{
    "status": 400,
    "error": "Bad Request",
    "message": "Required field 'username' is missing."
}

### Actual Result
* Status Code: 500 Internal Server Error
* Response Body:

    <!DOCTYPE html>
    <html lang="en">
    <head><title>500 Internal Server Error</title></head>
    <body>
        <h1>Internal Server Error</h1>
        <pre>NullPointerException: Cannot read field "username" because "authRequest" is null</pre>
    </body>
    </html>

### Server Execution Logs

2026-08-11T02:15:04.128Z [ERROR] [AuthService]: Exception caught in Thread-14
java.lang.NullPointerException: Field 'username' missing in payload parsing
    at com.omnicart.auth.controller.AuthController.login(AuthController.java:42)
    at com.omnicart.auth.controller.AuthController$$FastClassBySpringCGLIB.invoke(<generated>)

## Bug Report 3: OMNI-103 (SQL / Database Consistency Defect)

* **Issue Key:** `OMNI-103`
* **Summary:** Stock inventory count falls below zero (stock_quantity < 0) during concurrent user checkout
* **Type:** Bug
* **Component:** QL Database / Inventory Management Engine
* **Severity:** Medium
* **Priority:** Medium
* **Environment:** PostgreSQL 15.2 / Backend Order Processing Service

### Description

When two users perform checkout simultaneously for an item with only 1 unit remaining in stock, the inventory table fails to apply row locking. Both transactions complete successfully, resulting in stock_quantity = -1 in the database.

### SQL Verification Query

    When two users perform checkout simultaneously for an item with only 1 unit remaining in stock, the inventory table fails to apply row locking. Both transactions complete successfully, resulting in stock_quantity = -1 in the database.

### Query Result Output

product_id |     product_name     | stock_quantity 
------------+----------------------+----------------
        104 | Sauce Labs Backpack  |             -1
(1 row)

### Root Cause Analysis

The inventory update statement in the order service lacks an explicit WHERE stock_quantity >= quantity check or database table lock (SELECT ... FOR UPDATE), allowing concurrent transactions to bypass stock availability verification.