<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dbcon.ConDB" %>
<%
    // Retrieve search parameters from request
    String userId = request.getParameter("userId");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    List<Map<String, String>> bookings = new ArrayList<>();

    try {
        Connection con = new ConDB().getCon();
        String sql = "SELECT booking_id, preferred_date, receiver_name, receiver_address, total_cost FROM Parcel_Booking WHERE 1=1";

        if (userId != null && !userId.trim().isEmpty()) {
            sql += " AND booking_id = ?";
        }
        if (startDate != null && !startDate.trim().isEmpty() && endDate != null && !endDate.trim().isEmpty()) {
            sql += " AND preferred_date BETWEEN ? AND ?";
        }

        PreparedStatement pstmt = con.prepareStatement(sql);
        int paramIndex = 1;

        if (userId != null && !userId.trim().isEmpty()) {
            pstmt.setInt(paramIndex++, Integer.parseInt(userId));
        }
        if (startDate != null && !startDate.trim().isEmpty() && endDate != null && !endDate.trim().isEmpty()) {
            pstmt.setDate(paramIndex++, java.sql.Date.valueOf(startDate));
            pstmt.setDate(paramIndex++, java.sql.Date.valueOf(endDate));
        }

        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, String> booking = new HashMap<>();
            booking.put("id", rs.getString("booking_id"));
            booking.put("date", rs.getString("preferred_date"));
            booking.put("receiver", rs.getString("receiver_name"));
            booking.put("address", rs.getString("receiver_address"));
            booking.put("amount", rs.getString("total_cost"));
            bookings.add(booking);
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
    <title>Booking History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: black;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #333;
            color: white;
        }
        .search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }
        input, select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 8px 15px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
            background-color: green;
            color: white;
        }
        button:hover {
            background-color: darkblue;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="welcome">Welcome, <span id="username">User</span></div>
        <button class="logout-btn" onclick="location.href='login.jsp'">Logout</button>
    </div>

    <div class="container">
        <h2>Booking History</h2>

        <form method="GET" action="bookingHistory.jsp">
            <div class="search-container">
                <label>User ID:</label>
                <input type="text" name="userId" placeholder="Enter Booking ID">
                
                <label>Start Date:</label>
                <input type="date" name="startDate">

                <label>End Date:</label>
                <input type="date" name="endDate">

                <button type="submit">Search</button>
            </div>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking Date</th>
                    <th>Receiver Name</th>
                    <th>Delivered Address</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <% if (bookings.isEmpty()) { %>
                    <tr><td colspan="5">No bookings found.</td></tr>
                <% } else {
                    for (Map<String, String> booking : bookings) { %>
                        <tr>
                            <td><%= booking.get("id") %></td>
                            <td><%= booking.get("date") %></td>
                            <td><%= booking.get("receiver") %></td>
                            <td><%= booking.get("address") %></td>
                            <td><%= booking.get("amount") %></td>
                        </tr>
                    <% }
                } %>
            </tbody>
        </table>
    </div>
</body>
</html>
