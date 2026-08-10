# 🔌 OmniCart REST API Test Suite

This directory contains the Postman API collection for testing client-server interactions against the Restful-Booker mock service.

## 📌 Tested Endpoints & Scenarios

| Endpoint     | Method   | Expected Status | Description |
| :---         | :---     | :---            | :--- |
| `/auth`      | `POST`   | `200 OK`        | Authenticates admin credentials and returns session token. |
| `/booking`   | `GET`    | `200 OK`        | Retrieves full list of booking IDs. |
| `/booking`   | `POST`   | `200 OK`        | Creates a new booking record with valid JSON payload. |
| `/booking/1` | `DELETE` | `403 Forbidden` | Verifies security block when deleting without auth headers. |

## 🚀 How to Run in Postman
1. Install [Postman](https://www.postman.com/).
2. Import `OmniCart_API_Collection.json`.
3. Click **Run Collection** to execute all request assertions in sequence.