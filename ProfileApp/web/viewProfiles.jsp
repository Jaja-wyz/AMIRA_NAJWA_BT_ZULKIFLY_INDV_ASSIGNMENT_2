<%@ page import="com.ProfileApp.ProfileBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProfileHub | Manage Student Profiles</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px 20px;
            color: #333;
        }

        .main-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 25px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header-section {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: float 20s linear infinite;
        }

        .header-content {
            position: relative;
            z-index: 2;
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 15px;
        }

        .header-title i {
            font-size: 2.8rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin: 0;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        .controls-section {
            padding: 30px 40px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }

        .stats-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            color: #4facfe;
            line-height: 1;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 14px 30px;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 180px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(86, 171, 47, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(255, 65, 108, 0.4);
        }

        .btn-outline {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.2);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .table-section {
            padding: 40px;
            overflow-x: auto;
        }

        .profiles-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .profiles-table thead {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .profiles-table th {
            color: white;
            font-weight: 700;
            padding: 20px;
            text-align: left;
            border: none;
            position: relative;
            white-space: nowrap;
        }

        .profiles-table th::after {
            content: '';
            position: absolute;
            right: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 1px;
            height: 60%;
            background: rgba(255, 255, 255, 0.3);
        }

        .profiles-table th:last-child::after {
            display: none;
        }

        .profiles-table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #e9ecef;
        }

        .profiles-table tbody tr:hover {
            background: linear-gradient(135deg, rgba(79, 172, 254, 0.05), rgba(0, 242, 254, 0.05));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .profiles-table td {
            padding: 20px;
            border: none;
            border-bottom: 1px solid #e9ecef;
            vertical-align: top;
        }

        .student-name {
            font-weight: 700;
            color: #2c3e50;
            font-size: 1.1rem;
        }

        .student-id {
            background: rgba(79, 172, 254, 0.1);
            padding: 5px 12px;
            border-radius: 20px;
            font-family: monospace;
            font-size: 0.9rem;
            color: #4facfe;
        }

        .email-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .email-link:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .truncate-text {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.5;
            max-height: 3em;
        }

        .action-cell {
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 100px;
            justify-content: center;
        }

        .action-btn-edit {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .action-btn-delete {
            background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%);
            color: white;
        }

        .empty-state {
            padding: 80px 40px;
            text-align: center;
            color: #666;
        }

        .empty-icon {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: #999;
        }

        .messages-section {
            padding: 0 40px 20px;
        }

        .alert {
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            animation: slideIn 0.5s ease-out;
        }

        .alert-success {
            background: linear-gradient(135deg, rgba(86, 171, 47, 0.1), rgba(168, 224, 99, 0.1));
            border-left: 5px solid #56ab2f;
            color: #2d5019;
        }

        .alert-error {
            background: linear-gradient(135deg, rgba(255, 65, 108, 0.1), rgba(255, 75, 43, 0.1));
            border-left: 5px solid #ff416c;
            color: #8a1e2f;
        }

        .alert-icon {
            font-size: 1.5rem;
        }

        .search-filter {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 300px;
        }

        .search-input {
            width: 100%;
            padding: 15px 20px;
            border-radius: 50px;
            border: 2px solid #e9ecef;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .search-input:focus {
            outline: none;
            border-color: #4facfe;
            box-shadow: 0 5px 20px rgba(79, 172, 254, 0.2);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0% {
                transform: translate(0, 0) rotate(0deg);
            }
            100% {
                transform: translate(50px, 50px) rotate(360deg);
            }
        }

        @media (max-width: 992px) {
            .header-section {
                padding: 30px 20px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .table-section {
                padding: 20px;
            }
            
            .profiles-table {
                font-size: 0.9rem;
            }
            
            .profiles-table th,
            .profiles-table td {
                padding: 15px 10px;
            }
            
            .btn {
                min-width: 150px;
                padding: 12px 20px;
            }
            
            .action-buttons {
                justify-content: center;
            }
            
            .search-box {
                min-width: 100%;
            }
        }

        @media (max-width: 768px) {
            .profiles-table {
                display: block;
            }
            
            .profiles-table thead {
                display: none;
            }
            
            .profiles-table tbody tr {
                display: block;
                margin-bottom: 20px;
                border: 1px solid #e9ecef;
                border-radius: 12px;
                padding: 20px;
            }
            
            .profiles-table td {
                display: block;
                text-align: left;
                border: none;
                padding: 10px 0;
                position: relative;
            }
            
            .profiles-table td::before {
                content: attr(data-label);
                position: absolute;
                left: 0;
                top: 10px;
                font-weight: 700;
                color: #4facfe;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .profiles-table td {
                padding-left: 150px;
                min-height: 40px;
            }
            
            .action-cell {
                justify-content: center;
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #e9ecef;
            }
            
            .action-btn {
                min-width: 80px;
                padding: 8px 15px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Section -->
        <div class="header-section">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-users"></i>
                    <div>
                        <h1>Student Profiles Management</h1>
                        <p class="subtitle">View, manage, and organize all student profiles in one place</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Messages Section -->
        <div class="messages-section">
            <% 
                // Success message from servlet attribute
                String successMessage = (String) request.getAttribute("successMessage");
                if (successMessage != null) {
            %>
                <div class="alert alert-success" id="successAlert">
                    <div class="alert-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div>
                        <strong>Success!</strong> 
                        <% 
                            if ("deleted".equals(successMessage)) {
                                out.print("Profile deleted successfully!");
                            } else if ("updated".equals(successMessage)) {
                                out.print("Profile updated successfully!");
                            } else {
                                out.print(successMessage);
                            }
                        %>
                    </div>
                </div>
            <% } %>
            
            <% 
                // Success message from URL parameter
                String successParam = request.getParameter("success");
                if (successParam != null && successMessage == null) {
            %>
                <div class="alert alert-success" id="successAlert">
                    <div class="alert-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div>
                        <strong>Success!</strong> 
                        Profile <%= "deleted".equals(successParam) ? "deleted" : "updated" %> successfully!
                    </div>
                </div>
            <% } %>

            <% 
                // Error message from servlet attribute
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <div class="alert alert-error" id="errorAlert">
                    <div class="alert-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div>
                        <strong>Error:</strong> <%= errorMessage %>
                    </div>
                </div>
            <% } %>
            
            <% 
                // Error message from URL parameter
                String errorParam = request.getParameter("error");
                if (errorParam != null && errorMessage == null) {
            %>
                <div class="alert alert-error" id="errorAlert">
                    <div class="alert-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div>
                        <strong>Error:</strong> <%= errorParam %>
                    </div>
                </div>
            <% } %>
        </div>

        <!-- Controls Section -->
        <div class="controls-section">
            <div class="stats-bar">
                <div class="stat-item">
                    <i class="fas fa-user-graduate"></i>
                    <div>
                        <div class="stat-number" id="totalProfiles">
                            <%
                                List<ProfileBean> profiles = (List<ProfileBean>) request.getAttribute("profiles");
                                if (profiles != null) {
                                    out.print(profiles.size());
                                } else {
                                    out.print("0");
                                }
                            %>
                        </div>
                        <div>Total Students</div>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <a href="profileForm.html" class="btn btn-success">
                        <i class="fas fa-user-plus"></i> Add New Profile
                    </a>
                    <a href="index.html" class="btn btn-outline">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                </div>
            </div>

            <div class="search-filter">
                <div class="search-box">
                    <input type="text" 
                           class="search-input" 
                           id="searchInput" 
                           placeholder="Search by name, student ID, or program...">
                </div>
            </div>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <%
                if (profiles != null && !profiles.isEmpty()) {
            %>
            <table class="profiles-table" id="profilesTable">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-user"></i> Student Name</th>
                        <th><i class="fas fa-id-card"></i> Student ID</th>
                        <th><i class="fas fa-graduation-cap"></i> Program</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-heart"></i> Hobbies</th>
                        <th><i class="fas fa-comment"></i> Introduction</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ProfileBean p : profiles) {
                            String name = p.getName() != null ? p.getName() : "";
                            String studentId = p.getStudentId() != null ? p.getStudentId() : "";
                            String program = p.getProgramme() != null ? p.getProgramme() : "";
                            String email = p.getEmail() != null ? p.getEmail() : "";
                            String hobbies = p.getHobbies() != null ? p.getHobbies() : "";
                            String intro = p.getIntroduction() != null ? p.getIntroduction() : "";
                    %>
                    <tr class="profile-row" data-search="<%= name.toLowerCase() %> <%= studentId.toLowerCase() %> <%= program.toLowerCase() %>">
                        <td data-label="ID">
                            <span class="student-id"><%= p.getId() %></span>
                        </td>
                        <td data-label="Student Name">
                            <div class="student-name"><%= name %></div>
                        </td>
                        <td data-label="Student ID">
                            <code><%= studentId %></code>
                        </td>
                        <td data-label="Program">
                            <%= program %>
                        </td>
                        <td data-label="Email">
                            <a href="mailto:<%= email %>" class="email-link">
                                <i class="fas fa-envelope"></i> <%= email %>
                            </a>
                        </td>
                        <td data-label="Hobbies">
                            <div class="truncate-text">
                                <%= hobbies.isEmpty() ? "-" : hobbies %>
                            </div>
                        </td>
                        <td data-label="Introduction">
                            <div class="truncate-text">
                                <%= intro.isEmpty() ? "-" : intro %>
                            </div>
                        </td>
                        <td data-label="Actions">
                            <div class="action-cell">
                                <a href="EditServlet?id=<%= p.getId() %>" 
                                   class="action-btn action-btn-edit"
                                   title="Edit Profile">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="DeleteServlet?id=<%= p.getId() %>" 
                                   class="action-btn action-btn-delete"
                                   onclick="return confirmDelete('<%= name.replace("'", "\\'") %>')"
                                   title="Delete Profile">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                } else {
            %>
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="fas fa-user-slash"></i>
                </div>
                <h3>No Student Profiles Found</h3>
                <p style="margin-bottom: 30px; font-size: 1.1rem; color: #999;">
                    The database is currently empty. Start by adding your first student profile!
                </p>
                <a href="profileForm.html" class="btn btn-success" style="font-size: 1.1rem; padding: 15px 40px;">
                    <i class="fas fa-plus-circle"></i> Create First Profile
                </a>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <script>
        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(() => {
                    alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateX(20px)';
                    setTimeout(() => alert.remove(), 500);
                }, 5000);
            });
            
            // Search functionality
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keyup', function() {
                    const searchTerm = this.value.toLowerCase();
                    const rows = document.querySelectorAll('.profile-row');
                    
                    rows.forEach(row => {
                        const searchData = row.getAttribute('data-search');
                        if (searchData.includes(searchTerm)) {
                            row.style.display = '';
                            row.style.animation = 'fadeIn 0.3s ease';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                });
            }
        });
        
        // Enhanced delete confirmation
        function confirmDelete(studentName) {
            return confirm(`Are you sure you want to delete "${studentName}"?\n\nThis action cannot be undone.`);
        }
        
        // Add row hover effects
        document.querySelectorAll('.profile-row').forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.cursor = 'pointer';
            });
        });
        
        // Quick view functionality (optional)
        document.querySelectorAll('.student-name').forEach(name => {
            name.addEventListener('click', function() {
                const row = this.closest('.profile-row');
                if (row) {
                    // Add your quick view logic here
                    console.log('View profile:', row.querySelector('.student-id').textContent);
                }
            });
        });
        
        // Update stats with animation
        function animateStatCounter(element) {
            const target = parseInt(element.textContent);
            let current = 0;
            const increment = target / 50; // 50 steps
            
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target;
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current);
                }
            }, 20);
        }
        
        // Animate the stat counter when page loads
        setTimeout(() => {
            const statElement = document.getElementById('totalProfiles');
            if (statElement) {
                animateStatCounter(statElement);
            }
        }, 500);
    </script>
</body>
</html>