public void createParcelSchedulingTable() {
    String sql = "CREATE TABLE Parcel_Scheduling (" +
                 "id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, " +
                 "booking_id INT NOT NULL, " +  // Changed from VARCHAR(12) to INT to match Parcel_Booking
                 "pickup_date DATE NOT NULL, " +
                 "pickup_time TIME NOT NULL, " +
                 "FOREIGN KEY (booking_id) REFERENCES Parcel_Booking(booking_id) ON DELETE CASCADE)";

    try (Connection con = getCon(); Statement stmt = con.createStatement()) {
        stmt.executeUpdate(sql);
        System.out.println("Table Parcel_Scheduling created successfully!");
    } catch (SQLException | ClassNotFoundException e) {
        if (e.getMessage().contains("already exists")) {
            System.out.println("Table already exists.");
        } else {
            e.printStackTrace();
        }
    }
}
