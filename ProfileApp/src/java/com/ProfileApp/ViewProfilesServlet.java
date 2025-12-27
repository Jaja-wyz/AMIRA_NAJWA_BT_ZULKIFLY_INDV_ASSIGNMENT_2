package com.ProfileApp;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewProfilesServlet")
public class ViewProfilesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Also handle messages from other servlets (Delete, Edit, etc.)
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        
        if (success != null) {
            request.setAttribute("successMessage", success);
        }
        if (error != null) {
            request.setAttribute("errorMessage", error);
        }
        
        List<ProfileBean> profiles = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Load Derby JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Connect to database
            conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles", 
                "app", 
                "app");
            
            // Use PreparedStatement instead of Statement (better practice)
            String sql = "SELECT * FROM profile ORDER BY id DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            // Process results
            while (rs.next()) {
                ProfileBean p = new ProfileBean();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setStudentId(rs.getString("student_id"));
                p.setProgramme(rs.getString("program"));
                p.setEmail(rs.getString("email"));
                p.setHobbies(rs.getString("hobbies"));
                p.setIntroduction(rs.getString("introduction"));
                profiles.add(p);
            }
            
            // Log for debugging
            System.out.println("Loaded " + profiles.size() + " profiles from database");
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found. Please check if Derby client JAR is in classpath.");
        } catch (SQLException e) {
            e.printStackTrace();
            // Check specific SQL errors
            if (e.getMessage().contains("does not exist")) {
                request.setAttribute("error", "Database table 'profile' does not exist. Please create it first.");
            } else if (e.getMessage().contains("connection refused")) {
                request.setAttribute("error", "Cannot connect to database. Make sure Apache Derby is running on localhost:1527");
            } else {
                request.setAttribute("error", "Database Error: " + e.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unexpected Error: " + e.getMessage());
        } finally {
            // Close resources in reverse order
            closeResources(rs, ps, conn);
        }
        
        // Set profiles list as request attribute
        request.setAttribute("profiles", profiles);
        
        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("/viewProfiles.jsp");
        rd.forward(request, response);
    }
    
    // Helper method to close resources
    private void closeResources(ResultSet rs, Statement st, Connection conn) {
        try { 
            if (rs != null) rs.close(); 
        } catch (SQLException e) {
            System.err.println("Error closing ResultSet: " + e.getMessage());
        }
        try { 
            if (st != null) st.close(); 
        } catch (SQLException e) {
            System.err.println("Error closing Statement: " + e.getMessage());
        }
        try { 
            if (conn != null) conn.close(); 
        } catch (SQLException e) {
            System.err.println("Error closing Connection: " + e.getMessage());
        }
    }
}