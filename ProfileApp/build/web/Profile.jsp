<%@ page import="com.ProfileApp.ProfileBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile Saved</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #F0F8FF; display: flex; justify-content: center; padding: 50px; }
        .box { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); width: 500px; }
        h2 { color: #4682B4; border-bottom: 2px solid #ADD8E6; padding-bottom: 10px; }
        .data { margin: 10px 0; font-size: 1.1rem; }
        .btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #4682B4; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="box">
        <% 
            ProfileBean p = (ProfileBean) request.getAttribute("profileData"); 
            if (p != null) { 
        %>
            <h2>Profile Created Successfully!</h2>
            <div class="data"><strong>Name:</strong> <%= p.getName() %></div>
            <div class="data"><strong>Student ID:</strong> <%= p.getStudentId() %></div>
            <div class="data"><strong>Program:</strong> <%= p.getProgramme() %></div>
            <div class="data"><strong>Email:</strong> <%= p.getEmail() %></div>
            
            <a href="viewProfiles.jsp" class="btn">View All Profiles</a>
        <% } else { %>
            <p>No profile data found. Please go back to the form.</p>
            <a href="profileForm.html" class="btn">Go to Form</a>
        <% } %>
    </div>
</body>
</html>