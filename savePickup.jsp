<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbcon.ConDB" %>

<%
    String bookingId = request.getParameter("bookingId");
    String pickupDate = request.getParameter("pickupDate");
    String pickupTime = request.getParameter("pickupTime");
    boolean success = false;

    if (bookingId != null && pickupDate != null && pickupTime != null) {
        try {
            Connection con = new ConDB().getCon();
            String sql = "INSERT INTO Parcel_Scheduling (booking_id, pickup_date, pickup_time) VALUES (?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bookingId);
            pstmt.setString(2, pickupDate);
            pstmt.setString(3, pickupTime);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                success = true;
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
    <title>Pickup Confirmation</title>
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
            max-width: 400px;
            box-shadow: 0 0 50px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .message {
            font-size: 18px;
            color: <%= success ? "green" : "red" %>;
        }
        button {
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            background-color: blue;
            color: white;
            margin-top: 20px;
        }
        button:hover {
            background-color: darkblue;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="message">
            <% if (success) { %>
                Pickup scheduled successfully for Booking ID: <b><%= bookingId %></b> on <b><%= pickupDate %></b> at <b><%= pickupTime %></b>.
            <% } else { %>
                Failed to schedule pickup. Please try again.
            <% } %>
        </div>
        <button onclick="location.href='pickupScheduling.jsp'">Back</button>
    </div>
</body>
</html>
