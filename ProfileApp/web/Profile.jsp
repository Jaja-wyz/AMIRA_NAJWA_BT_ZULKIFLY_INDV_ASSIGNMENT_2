<%@ page import="com.ProfileApp.ProfileBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Saved Successfully</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .success-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 700px;
            overflow: hidden;
            animation: slideUp 0.5s ease-out;
        }

        .success-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
        }

        .success-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .success-header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .success-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            animation: bounce 1s infinite alternate;
        }

        .profile-details {
            padding: 40px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .detail-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            border-left: 5px solid #4facfe;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .detail-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .detail-label {
            font-size: 0.9rem;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .detail-value {
            font-size: 1.2rem;
            color: #333;
            font-weight: 500;
        }

        .introduction-box {
            background: linear-gradient(135deg, #fdfcfb 0%, #e2d1c3 100%);
            padding: 25px;
            border-radius: 12px;
            margin: 25px 0;
            border: 2px dashed #e9ecef;
        }

        .introduction-box .detail-value {
            line-height: 1.6;
            font-style: italic;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px 0 0 0;
            border-top: 1px solid #e9ecef;
        }

        .btn {
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 180px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-success {
            background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%);
            color: white;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .btn:active {
            transform: translateY(-1px);
        }

        .error-state {
            padding: 60px 40px;
            text-align: center;
        }

        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 20px;
        }

        .error-state h3 {
            color: #dc3545;
            font-size: 1.8rem;
            margin-bottom: 15px;
        }

        .profile-id-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 50px;
            font-size: 0.9rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            from {
                transform: translateY(0);
            }
            to {
                transform: translateY(-10px);
            }
        }

        .timestamp {
            text-align: center;
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 10px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        @media (max-width: 768px) {
            .success-card {
                margin: 20px;
            }
            
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
            }
            
            .success-header h1 {
                font-size: 2rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <% 
        ProfileBean p = (ProfileBean) request.getAttribute("profileData"); 
        if (p != null) { 
    %>
    <div class="success-card">
        <div class="success-header">
            <span class="profile-id-badge">ID: <%= p.getId() != 0 ? p.getId() : "NEW" %></span>
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1>Profile Created Successfully!</h1>
            <p>Your student profile has been saved to the database</p>
        </div>
        
        <div class="profile-details">
            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-label"><i class="fas fa-user"></i> Full Name</div>
                    <div class="detail-value"><%= p.getName() %></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label"><i class="fas fa-id-card"></i> Student ID</div>
                    <div class="detail-value"><code><%= p.getStudentId() %></code></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label"><i class="fas fa-graduation-cap"></i> Program</div>
                    <div class="detail-value"><%= p.getProgramme() %></div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label"><i class="fas fa-envelope"></i> Email</div>
                    <div class="detail-value">
                        <a href="mailto:<%= p.getEmail() %>"><%= p.getEmail() %></a>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-label"><i class="fas fa-heart"></i> Hobbies & Interests</div>
                    <div class="detail-value">
                        <% 
                            String hobbies = p.getHobbies();
                            if (hobbies != null && !hobbies.trim().isEmpty()) {
                                out.print(hobbies);
                            } else {
                                out.print("<span style='color: #6c757d; font-style: italic;'>Not specified</span>");
                            }
                        %>
                    </div>
                </div>
            </div>
            
            <% if (p.getIntroduction() != null && !p.getIntroduction().trim().isEmpty()) { %>
            <div class="introduction-box">
                <div class="detail-label"><i class="fas fa-quote-left"></i> Personal Introduction</div>
                <div class="detail-value"><%= p.getIntroduction() %></div>
            </div>
            <% } %>
            
            <div class="timestamp">
                <i class="far fa-clock"></i> Profile created on: 
                <span id="currentDateTime">
                    <script>
                        document.getElementById('currentDateTime').textContent = 
                            new Date().toLocaleString('en-US', {
                                weekday: 'long',
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit'
                            });
                    </script>
                </span>
            </div>
            
            <div class="action-buttons">
                <a href="ViewProfilesServlet" class="btn btn-primary">
                    <i class="fas fa-list"></i> View All Profiles
                </a>
                <a href="profileForm.html" class="btn btn-success">
                    <i class="fas fa-plus-circle"></i> Create Another
                </a>
                <a href="index.html" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Back to Home
                </a>
            </div>
        </div>
    </div>
    <% 
        } else { 
    %>
    <div class="success-card">
        <div class="error-state">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h3>Profile Data Not Found</h3>
            <p style="color: #6c757d; margin-bottom: 30px; line-height: 1.6;">
                The profile data could not be retrieved. This might be due to a database error 
                or the profile creation process was interrupted.
            </p>
            <div class="action-buttons">
                <a href="profileForm.html" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to Profile Form
                </a>
                <a href="index.html" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Return to Home
                </a>
            </div>
        </div>
    </div>
    <% 
        } 
    %>
    
    <script>
        // Add subtle animation to detail items
        document.addEventListener('DOMContentLoaded', function() {
            const detailItems = document.querySelectorAll('.detail-item');
            detailItems.forEach((item, index) => {
                item.style.animationDelay = (index * 0.1) + 's';
            });
            
            // Print functionality (optional)
            const printBtn = document.createElement('button');
            printBtn.className = 'btn btn-secondary';
            printBtn.innerHTML = '<i class="fas fa-print"></i> Print Profile';
            printBtn.onclick = () => window.print();
            document.querySelector('.action-buttons').appendChild(printBtn);
        });
    </script>
</body>
</html>