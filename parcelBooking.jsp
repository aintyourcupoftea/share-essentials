<%@ page import="dbcon.ConDB, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve username from session
    String username2 = (String) session.getAttribute("username");
    
    // Initialize sender details
    String senderName = "";
    String senderAddress = "";
    String senderContact = "";
    
    // Fetch sender details from the database
    try {
        Connection con = new ConDB().getCon();
        PreparedStatement ps = con.prepareStatement("SELECT CustomerName, Address, Mobno FROM Customer_Registration WHERE Username = ?");
        ps.setString(1, username2);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            senderName = rs.getString("CustomerName");
            senderAddress = rs.getString("Address");
            senderContact = rs.getString("Mobno");
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parcel Pro - Book a Parcel</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f4f8;
            color: #333;
        }
        .navbar {
            background-color: #2c3e50;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            color: #ecf0f1;
            font-size: 1.5rem;
            font-weight: bold;
            text-decoration: none;
        }
        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .logout-btn:hover {
            background-color: #c0392b;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 2rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #34495e;
        }
        input[type="text"],
        input[type="tel"],
        input[type="date"],
        input[type="time"],
        select,
        textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="tel"]:focus,
        input[type="date"]:focus,
        input[type="time"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #3498db;
        }
        input[readonly] {
            background-color: #ecf0f1;
            cursor: not-allowed;
        }
        .btn-container {
            text-align: center;
            margin-top: 2rem;
        }
        .btn {
            padding: 0.75rem 2rem;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #2980b9;
            color: white;
        }
        .btn-primary:hover {
            background-color: #3498db;
        }
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
            margin-left: 1rem;
        }
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="#" class="navbar-brand">Parcel Pro</a>
        <button class="logout-btn">Logout</button>
    </nav>

    <div class="container">
        <h1>Book a Parcel</h1>
        <form action="ParcelBookingServlet" method="post">
            <fieldset>
                <legend>Sender Information</legend>
                <div class="form-group">
                    <label for="sender-name">Name:</label>
                    <input type="text" id="sender-name" name="sender-name" value="<%= senderName %>" readonly>
                </div>
                <div class="form-group">
                    <label for="sender-address">Address:</label>
                    <textarea id="sender-address" name="sender-address" readonly><%= senderAddress %></textarea>
                </div>
                <div class="form-group">
                    <label for="sender-contact">Contact Details:</label>
                    <input type="text" id="sender-contact" name="sender-contact" value="<%= senderContact %>" readonly>
                </div>
            </fieldset>
            <fieldset>
                <legend>Receiver Information</legend>
                <div class="form-group">
                    <label for="receiver-name">Name:</label>
                    <input type="text" id="receiver-name" name="receiver-name" required minlength="2" maxlength="50">
                </div>
                <div class="form-group">
                    <label for="receiver-address">Address:</label>
                    <textarea id="receiver-address" name="receiver-address" required minlength="10"></textarea>
                </div>
                <div class="form-group">
                    <label for="receiver-pin-code">Pin Code:</label>
                    <input type="text" id="receiver-pin-code" name="receiver-pin-code" required pattern="\d{6}" title="Enter a valid 6-digit Pin Code">
                </div>
                <div class="form-group">
                    <label for="receiver-contact">Contact Details:</label>
                    <input type="tel" id="receiver-contact" name="receiver-contact" required pattern="\d{10}" title="Enter a valid 10-digit phone number">
                </div>
            </fieldset>
            <fieldset>
                <legend>Parcel Details</legend>
                <div class="form-group">
                    <label for="size-weight">Size & Weight (kg):</label>
                    <input type="text" id="size-weight" name="size-weight" required pattern="\d+(\.\d{1,2})?" title="Enter a valid number">
                </div>
                <div class="form-group">
                    <label for="contents">Contents Description:</label>
                    <textarea id="contents" name="contents" required minlength="5"></textarea>
                </div>
            </fieldset>
            <fieldset>
                <legend>Shipping Options</legend>
                <div class="form-group">
                    <label for="delivery-speed">Delivery Speed:</label>
                    <select id="delivery-speed" name="delivery-speed" required>
                        <option value="">Select...</option>
                        <option value="standard">Standard</option>
                        <option value="express">Express</option>
                    </select>
                </div>
            </fieldset>
            <fieldset>
                <legend>Date & Time Selection</legend>
                <div class="form-group">
                    <label for="preferred-date">Preferred Date:</label>
                    <input type="date" id="preferred-date" name="date" required>
                </div>
                <div class="form-group">
                    <label for="preferred-time">Preferred Time:</label>
                    <input type="time" id="preferred-time" name="time" required>
                </div>
            </fieldset>
            <fieldset>
                <legend>Service Cost & Payment</legend>
                <div class="form-group">
                    <label for="total-cost">Total Cost:</label>
                    <input type="text" id="total-cost" name="cost" value="20.00" readonly>
                </div>
                <div class="form-group">
                    <label for="payment-method">Payment Method:</label>
                    <select id="payment-method" name="payment-method" required onchange="showCardDetails()">
                        <option value="">Select...</option>
                        <option value="credit-card">Credit Card</option>
                        <option value="paypal">PayPal</option>
                        <option value="bank-transfer">Bank Transfer</option>
                    </select>
                </div>
            </fieldset>
            <fieldset id="credit-card-details" style="display: none;">
                <legend>Enter Card Details</legend>
                <div class="form-group">
                    <label for="card-number">Card Number:</label>
                    <input type="text" id="card-number" name="card-number" pattern="\d{16}" title="Enter a valid 16-digit card number" maxlength="16">
                </div>
                <div class="form-group">
                    <label for="cvv">CVV:</label>
                    <input type="text" id="cvv" name="cvv" pattern="\d{3}" title="Enter a valid 3-digit CVV" maxlength="3">
                </div>
                <div class="form-group">
                    <label for="expiry-date">Expiry Date:</label>
                    <input type="month" id="expiry-date" name="expiry-date">
                </div>
            </fieldset>
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Book Now</button>
                <button type="reset" class="btn btn-secondary">Reset</button>
            </div>
        </form>
    </div>

    <script>
        function showCardDetails() {
            var paymentMethod = document.getElementById("payment-method").value;
            var cardDetails = document.getElementById("credit-card-details");
            if (paymentMethod === "credit-card") {
                cardDetails.style.display = "block";
            } else {
                cardDetails.style.display = "none";
            }
        }
    </script>
</body>
</html>
