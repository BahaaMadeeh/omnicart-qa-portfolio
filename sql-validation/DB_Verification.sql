-- ============================================================================
-- OmniCart E-Commerce Backend Database Verification Script
-- Author: QA Engineer
-- Purpose: Backend verification queries to validate data integrity post-UI/API execution.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Scenario 1: Verify User Registration & Profile Data Persistence
-- Action: Executed after TC_AUTH_001 / POST /api/v1/auth/register
-- Purpose: Confirm user record created with correct status, hashed password, and default role.
-- ----------------------------------------------------------------------------
SELECT 
    user_id,
    username,
    email,
    user_role,
    account_status,
    created_at
FROM users
WHERE email = 'test.user@example.com';

-- Expected Outcome: 
-- 1 row returned. `user_role` = 'CUSTOMER', `account_status` = 'ACTIVE'.


-- ----------------------------------------------------------------------------
-- Scenario 2: Validate Inventory Stock Deduction Post-Checkout
-- Action: Executed after TC_CHK_007 / POST /api/v1/orders
-- Purpose: Verify product stock is accurately decremented after order completion.
-- ----------------------------------------------------------------------------
-- Step 2A: Check initial stock level before checkout (e.g., Product ID 104)
SELECT product_id, product_name, stock_quantity 
FROM products 
WHERE product_id = 104;

-- Step 2B: Audit stock level after purchasing 2 units of Product 104
SELECT 
    product_id, 
    product_name, 
    stock_quantity AS current_stock,
    (stock_quantity >= 0) AS in_stock_flag
FROM products 
WHERE product_id = 104;

-- Expected Outcome: 
-- `current_stock` equals (initial_stock - 2). `in_stock_flag` is TRUE (1).


-- ----------------------------------------------------------------------------
-- Scenario 3: Verify Order Summary & Payment Calculation Integrity
-- Action: Executed after checkout completion on Web UI or API
-- Purpose: Validate relational join between orders, order_items, and users.
-- ----------------------------------------------------------------------------
SELECT 
    o.order_id,
    o.order_number,
    u.email AS customer_email,
    o.total_amount,
    o.order_status,
    o.created_at,
    COUNT(oi.item_id) AS total_line_items,
    SUM(oi.quantity * oi.unit_price) AS calculated_subtotal
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_number = 'ORD-2026-8891'
GROUP BY o.order_id, o.order_number, u.email, o.total_amount, o.order_status, o.created_at;

-- Expected Outcome: 
-- `calculated_subtotal` matches `o.total_amount`. `order_status` = 'PAID' or 'PROCESSING'.


-- ----------------------------------------------------------------------------
-- Scenario 4: Shopping Cart State Cleanup Upon Successful Order
-- Action: Executed after user completes checkout flow
-- Purpose: Confirm active cart items for the user are cleared or marked checked out.
-- ----------------------------------------------------------------------------
SELECT 
    cart_id, 
    user_id, 
    item_count, 
    is_active
FROM shopping_carts
WHERE user_id = 101 AND is_active = 1;

-- Expected Outcome: 
-- 0 active rows returned, or `item_count` = 0 with `is_active` = 0.


-- ----------------------------------------------------------------------------
-- Scenario 5: Audit Orphaned or Corrupted Records (Negative / Integrity Check)
-- Purpose: Ensure database constraints hold up and no orphan order items exist without a parent order.
-- ----------------------------------------------------------------------------
SELECT 
    oi.item_id, 
    oi.order_id, 
    oi.product_id
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Expected Outcome: 
-- 0 rows returned (confirms foreign key integrity across tables).