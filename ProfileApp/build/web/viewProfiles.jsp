<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Profiles</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #F0F8FF; padding: 40px; }
        .card { background: white; padding: 20px; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border-bottom: 1px solid #eee; text-align: left; }
        th { background: #ADD8E6; color: #4682B4; }
        /* Style for the Delete link */
        .delete-btn { color: #ff4d4d; font-weight: bold; text-decoration: none; cursor: pointer; }
        .delete-btn:hover { text-decoration: underline; }
        .add-link { background: #4682B4; color: white; padding: 8px 15px; border-radius: 5px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="card">
        <h2>Registered Students</h2>
        <a href="profileForm.html" class="add-link">Add New Profile</a>
        
        <table>
            <tr>
                <th>Name</th>
                <th>ID</th>
                <th>Program</th>
                <th>Email</th>
                <th>Action</th> </tr>
            <%
                Connection conn = null; Statement st = null; ResultSet rs = null;
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/student_profiles", "app", "app");
                    st = conn.createStatement();
                    rs = st.executeQuery("SELECT * FROM profile");
                    while (rs.next()) {
                        // Retrieve the primary key 'id' to use for deletion
                        int profileId = rs.getInt("id"); 
            %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("student_id") %></td>
                <td><%= rs.getString("program") %></td>
                <td><%= rs.getString("email") %></td>
                <td>
                    <a href="DeleteServlet?id=<%= profileId %>" 
                       class="delete-btn"
                       onclick="return confirm('Are you sure you want to delete this profile?')">
                       Delete
                    </a>
                </td>
            </tr>
            <% } } catch (Exception e) { out.print("Error: " + e.getMessage()); } 
               finally { 
                   if(rs!=null) try { rs.close(); } catch(SQLException e) {}
                   if(st!=null) try { st.close(); } catch(SQLException e) {}
                   if(conn!=null) try { conn.close(); } catch(SQLException e) {}
               } 
            %>
        </table>
    </div>
</body>
</html>