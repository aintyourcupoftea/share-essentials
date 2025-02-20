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
    <title>Parcel Booking</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: white; }
        .container { background: silver; padding: 10px; border-radius: 5px; max-width: 600px; margin: auto; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); }
        h2 { text-align: center; color: #333; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input, select, textarea { width: 100%; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; }
        input[readonly] { background-color: #eee; cursor: not-allowed; }
        .btn-container { text-align: center; margin-top: 20px; }
        input[type="submit"], input[type="reset"] { padding: 10px; border: none; cursor: pointer; font-size: 16px; border-radius: 5px; }
        input[type="submit"] { background-color: green; color: white; }
        input[type="reset"] { background-color: red; color: white; }
        #credit-card-details { display: none; }
    </style>
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
</head>
<body>
    <div class="container">
        <h2>Book a Parcel Service</h2>
        <form action="ParcelBookingServlet" method="post">
            <fieldset>
                <legend>Sender Information</legend>
                <label>Name:</label>
                <input type="text" name="sender-name" value="<%= senderName %>" readonly>
                <label>Address:</label>
                <textarea name="sender-address" readonly><%= senderAddress %></textarea>
                <label>Contact Details:</label>
                <input type="text" name="sender-contact" value="<%= senderContact %>" readonly>
            </fieldset>
            <fieldset>
                <legend>Receiver Information</legend>
                <label>Name:</label>
                <input type="text" name="receiver-name" required minlength="2" maxlength="50">
                <label>Address:</label>
                <textarea name="receiver-address" required minlength="10"></textarea>
                <label>Pin Code:</label>
                <input type="text" name="receiver-pin-code" required pattern="\d{6}" title="Enter a valid 6-digit Pin Code">
                <label>Contact Details:</label>
                <input type="tel" name="receiver-contact" required pattern="\d{10}" title="Enter a valid 10-digit phone number">
            </fieldset>
            <fieldset>
                <legend>Parcel Details</legend>
                <label>Size & Weight (kg):</label>
                <input type="text" name="size-weight" required pattern="\d+(\.\d{1,2})?" title="Enter a valid number">
                <label>Contents Description:</label>
                <textarea name="contents" required minlength="5"></textarea>
            </fieldset>
            <fieldset>
                <legend>Shipping Options</legend>
                <label>Delivery Speed:</label>
                <select name="delivery-speed" required>
                    <option value="">Select...</option>
                    <option value="standard">Standard</option>
                    <option value="express">Express</option>
                </select>
            </fieldset>
            <fieldset>
                <legend>Date & Time Selection</legend>
                <label>Preferred Date:</label>
                <input type="date" name="date" required>
                <label>Preferred Time:</label>
                <input type="time" name="time" required>
            </fieldset>
            <fieldset>
                <legend>Service Cost & Payment</legend>
                <label>Total Cost :</label>
                <input type="text" name="cost" value="20.00" readonly>
                <label>Payment Method:</label>
                <select name="payment-method" id="payment-method" onchange="showCardDetails()" required>
                    <option value="">Select...</option>
                    <option value="credit-card">Credit Card</option>
                    <option value="paypal">PayPal</option>
                    <option value="bank-transfer">Bank Transfer</option>
                </select>
            </fieldset>
            <fieldset id="credit-card-details">
                <legend>Enter Card Details</legend>
                <label>Card Number:</label>
                <input type="text" name="card-number" pattern="\d{16}" title="Enter a valid 16-digit card number" maxlength="16">
                <label>CVV:</label>
                <input type="text" name="cvv" pattern="\d{3}" title="Enter a valid 3-digit CVV" maxlength="3">
                <label>Expiry Date:</label>
                <input type="month" name="expiry-date">
            </fieldset>
            <div class="btn-container">
                <input type="submit" value="Book Now">
                <input type="reset" value="Reset">
            </div>
        </form>
    </div>
</body>
</html>
