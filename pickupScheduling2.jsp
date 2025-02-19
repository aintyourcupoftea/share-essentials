<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbcon.ConDB" %>
<%
    String bookingId = request.getParameter("bookingId");
    boolean isValidBooking = false;

    if (bookingId != null && !bookingId.trim().isEmpty()) {
        try {
            Connection con = new ConDB().getCon();
            String sql = "SELECT booking_id FROM Parcel_Booking WHERE booking_id = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bookingId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                isValidBooking = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pickup Scheduling</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: rgb(100, 126, 112);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 5px;
            max-width: 600px;
            box-shadow: 0 0 50px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #333;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
            text-align: left;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            background-color: green;
            color: white;
            width: 100%;
        }
        button:hover {
            background-color: darkgreen;
        }
        .confirmation {
            margin-top: 20px;
            padding: 10px;
            background: #e8f5e9;
            color: #2e7d32;
            border-radius: 5px;
            font-weight: bold;
            display: none;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Pickup Scheduling</h2>
        
        <form method="GET" action="pickupScheduling.jsp">
            <label for="booking-id">Enter Booking ID:</label>
            <input type="text" name="bookingId" maxlength="12" placeholder="Enter 12-digit Booking ID" required>
            <button type="submit">Search</button>
        </form>

        <% if (bookingId != null) { %>
            <% if (isValidBooking) { %>
                <form method="POST" action="savePickup.jsp">
                    <input type="hidden" name="bookingId" value="<%= bookingId %>">
                    
                    <label for="pickup-date">Select Pickup Date:</label>
                    <input type="date" name="pickupDate" min="<%= java.time.LocalDate.now() %>" required>

                    <label for="pickup-time">Select Pickup Time:</label>
                    <input type="time" name="pickupTime" required>

                    <button type="submit">Save</button>
                </form>
            <% } else { %>
                <div class="error">Invalid Booking ID! Please enter a valid ID.</div>
            <% } %>
        <% } %>
    </div>
</body>
</html>
