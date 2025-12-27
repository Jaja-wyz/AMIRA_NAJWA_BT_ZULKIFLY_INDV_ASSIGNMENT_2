<%@ page import="com.ProfileApp.ProfileBean" %>
<%
    ProfileBean p = (ProfileBean) request.getAttribute("profile");
    if (p == null) {
        String error = request.getParameter("error");
        if (error != null) {
%>
            <div style="color:red; padding:20px; text-align:center;">
                <h3>Error: <%= error %></h3>
                <a href="ViewProfilesServlet">Back to Profiles</a>
            </div>
<%
        } else {
            response.sendRedirect("ViewProfilesServlet?error=Profile data not found");
        }
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(180deg, #F0F8FF, #FFF0F5);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .box {
            background: white;
            padding: 40px;
            border-radius: 15px;
            width: 420px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #ADD8E6;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background: #87CEFA;
        }
    </style>
</head>
<body>

<div class="box">
    <h2>Edit Profile</h2>

    <form action="UpdateProfileServlet" method="post">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <input type="text" name="name" value="<%= p.getName() %>" required>
        <input type="text" name="studentId" value="<%= p.getStudentId() %>" required>
        <input type="text" name="program" value="<%= p.getProgramme() %>" required>
        <input type="email" name="email" value="<%= p.getEmail() %>" required>
        <input type="text" name="hobbies" value="<%= p.getHobbies() %>" required>

        <textarea name="introduction" rows="3"><%= p.getIntroduction() %></textarea>

        <button type="submit">Update Profile</button>
    </form>
</div>
</body>
</html>
