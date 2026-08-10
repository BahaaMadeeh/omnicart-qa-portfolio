# ?? OmniCart Manual Test Case Suite (Web & Mobile)

**Project:** OmniCart E-Commerce Platform  
**Target Application:** https://www.saucedemo.com/  
**Document Version:** 1.0  
**Author:** Bahaa Madeeh 

---

## ?? Test Suite Summary

| Module ID  | Module Name                          | Web Specs                  | Mobile Specs            | Total Cases |
| :---       | :---                                 | :---                       | :---                    | :--- |
| **MOD-01** | User Authentication & Authorization  | Chrome Desktop (1920x1080) | iPhone 14 Pro (393x852) | 2 |
| **MOD-02** | Product Catalog & Responsive Layout  | Firefox Desktop (1440x900) | Pixel 7 (412x915)       | 2 |
| **MOD-03** | Shopping Cart & Touch Responsiveness | Chrome Desktop (1920x1080) | iPad Mini (744x1133)    | 2 |
| **MOD-04** | E2E Checkout Flow & Validation       | Edge Desktop (1920x1080)   | iPhone 14 Pro (393x852) | 2 |

---

## Module 1: User Authentication & Authorization (MOD-01)

### TC_AUTH_001: Standard User Login Verification
* **Test Case ID:** `TC_AUTH_001`
* **Target Platform:** Web Desktop (Google Chrome - 1920x1080)
* **Priority:** Critical
* **Type:** Functional / Positive
* **Pre-conditions:** User navigates to `https://www.saucedemo.com/` with a clean browser session.

**Test Steps:**
1. Enter `standard_user` into Username field.
2. Enter `secret_sauce` into Password field.
3. Click Login button.

**Expected Results:**
* Redirected to `/inventory.html`.
* Header displays "Swag Labs" logo.

---

### TC_AUTH_002: Mobile Locked-out User Error Message
* **Test Case ID:** `TC_AUTH_002`
* **Target Platform:** Mobile Viewport (iPhone 14 Pro - 393x852)
* **Priority:** High
* **Type:** Functional / Negative

**Test Steps:**
1. Navigate to `https://www.saucedemo.com/` on iPhone 14 Pro viewport.
2. Enter `locked_out_user` and `secret_sauce`.
3. Tap Login button.

**Expected Results:**
* Error container displays: `Epic sadface: Sorry, this user has been locked out.`.
* Fits within 393px width without horizontal scrolling.
