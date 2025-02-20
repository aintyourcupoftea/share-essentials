
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ParcelPro Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        :root {
            --primary: #5e60ce;
            --primary-dark: #4e54c8;
            --primary-light: #7678ed;
            --secondary: #64dfdf;
            --dark: #2b2d42;
            --light: #f8f9fa;
            --gray: #e9ecef;
            --danger: #ef476f;
            --success: #06d6a0;
            --warning: #ffd166;
            --info: #118ab2;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            color: var(--dark);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar Styles */
        .navbar {
            background: linear-gradient(to right, var(--primary), var(--primary-dark));
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .brand i {
            font-size: 1.8rem;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-welcome {
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .user-avatar {
            width: 2.5rem;
            height: 2.5rem;
            background-color: var(--primary-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .logout-btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .logout-btn:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        /* Main Content */
        .dashboard-container {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            flex-grow: 1;
            width: 100%;
        }

        /* Dashboard Header */
        .dashboard-header {
            margin-bottom: 2rem;
            text-align: center;
        }

        .dashboard-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .dashboard-header p {
            color: #6c757d;
        }

        /* Main Dashboard Sections */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
        }

        /* Actions Section */
        .actions-section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.6rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .action-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-align: center;
            position: relative;
        }

        .action-card:hover {
            transform: translateY(-5px);
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background-color: var(--primary);
        }

        .action-card.booking::before {
            background-color: var(--primary);
        }

        .action-card.tracking::before {
            background-color: var(--info);
        }

        .action-card.history::before {
            background-color: var(--warning);
        }

        .action-card.support::before {
            background-color: var(--success);
        }

        .action-icon {
            font-size: 3rem;
            margin: 2rem 0 1rem;
            color: var(--dark);
        }

        .action-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .action-description {
            color: #6c757d;
            font-size: 0.95rem;
            padding: 0 1.5rem;
            margin-bottom: 1rem;
        }

        .action-link {
            display: block;
            padding: 1rem;
            background-color: var(--gray);
            color: var(--dark);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
        }

        .action-link:hover {
            background-color: var(--primary);
            color: white;
        }
        
        @media (max-width: 768px) {
           
            
            .dashboard-container {
                padding: 1rem;
            }
            
            .action-cards {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 576px) {
            
            .action-cards {
                grid-template-columns: 1fr;
            }
            
            .user-welcome span {
                display: none;
            }
        }
    </style>
</head>
<body>
<%
    HttpSession session2 = request.getSession();
    String username = (String) session2.getAttribute("username");
%>
<nav class="navbar">
    <div class="brand">
        <i class="fas fa-box"></i>
        <span>ParcelPro</span>
    </div>
    <div class="user-section">
        <div class="user-welcome">
            <div class="user-avatar">JD</div>
            <span id="username"><%= username %></span>
        </div>
        <form action="CustomerLogin.html">
            <button type="submit" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </button>
        </form>
    </div>
</nav>

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1>Welcome to your Dashboard</h1>
        <p>Track your parcels, book new shipments, and manage your deliveries all in one place.</p>
    </div>


    <div class="dashboard-grid">
        <div class="dashboard-main">
            <div class="actions-section">
                <h2 class="section-title">
                    <i class="fas fa-tachometer-alt"></i>
                    Quick Actions
                </h2>

                <div class="action-cards">
                    <div class="action-card booking">
                        <div class="action-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <h3 class="action-title">Book a Parcel</h3>
                        <p class="action-description">Create a new shipping request for your package</p>
                        <a href="/PMS/src/main/webapp/parcelBooking.jsp" class="action-link">Book Now</a>
                    </div>

                    <div class="action-card tracking">
                        <div class="action-icon">
                            <i class="fas fa-search-location"></i>
                        </div>
                        <h3 class="action-title">Track Parcel</h3>
                        <p class="action-description">Check the current status of your shipment</p>
                        <a href="TrackingCustomer.html" class="action-link">Track Now</a>
                    </div>

                    <div class="action-card history">
                        <div class="action-icon">
                            <i class="fas fa-history"></i>
                        </div>
                        <h3 class="action-title">Booking History</h3>
                        <p class="action-description">View all your previous shipping requests</p>
                        <a href="BookingHistory.html" class="action-link">View History</a>
                    </div>

                    <div class="action-card support">
                        <div class="action-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h3 class="action-title">Customer Support</h3>
                        <p class="action-description">Need help? Contact our support team</p>
                        <a href="CustomerSupport.html" class="action-link">Get Support</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>