package com.ProfileApp;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        // Validate parameter
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("viewProfiles.jsp?error=Invalid profile ID");
            return;
        }
        
        try {
            // Parse ID
            int id = Integer.parseInt(idParam);
            
            // Load database driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Get database connection
            Connection con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles", 
                "app", 
                "app");
            
            // Prepare delete statement
            String sql = "DELETE FROM profile WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            // Execute delete
            int rowsAffected = ps.executeUpdate();
            
            // Close resources
            ps.close();
            con.close();
            
            // Redirect with success message
            if (rowsAffected > 0) {
                response.sendRedirect("ViewProfilesServlet?success=deleted");
            } else {
                response.sendRedirect("ViewProfilesServlet?error=Profile not found");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("ViewProfilesServlet?error=Invalid ID format");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("ViewProfilesServlet?error=Database driver not found");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ViewProfilesServlet?error=Database error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewProfilesServlet?error=Unexpected error");
        }
    }
}