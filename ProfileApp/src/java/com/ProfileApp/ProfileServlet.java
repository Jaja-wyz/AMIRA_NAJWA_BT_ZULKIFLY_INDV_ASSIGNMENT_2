package com.ProfileApp;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String introduction = request.getParameter("introduction");
        
        // Basic validation
        if (name == null || name.trim().isEmpty() || 
            studentId == null || studentId.trim().isEmpty() ||
            program == null || program.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields");
            request.getRequestDispatcher("profileForm.html").forward(request, response);
            return;
        }
        
        // Create ProfileBean
        ProfileBean profile = new ProfileBean();
        profile.setName(name.trim());
        profile.setStudentId(studentId.trim());
        profile.setProgramme(program.trim());
        profile.setEmail(email.trim());
        profile.setHobbies(hobbies != null ? hobbies.trim() : "");
        profile.setIntroduction(introduction != null ? introduction.trim() : "");

        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            // Load database driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Create database connection
            con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles", 
                "app", 
                "app");
            
            // Prepare SQL statement
            String sql = "INSERT INTO profile (name, student_id, program, email, hobbies, introduction) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            
            // Set parameters
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getStudentId());
            ps.setString(3, profile.getProgramme());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getIntroduction());
            
            // Execute insert
            int rowsInserted = ps.executeUpdate();
            
            if (rowsInserted > 0) {
                System.out.println("Profile created successfully for: " + profile.getName());
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found: " + e.getMessage());
            request.getRequestDispatcher("profileForm.html").forward(request, response);
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            
            // Check for duplicate student ID
            if (e.getMessage().contains("duplicate") || e.getMessage().contains("unique")) {
                request.setAttribute("error", "Student ID already exists. Please use a different ID.");
            } else {
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
            
            request.getRequestDispatcher("profileForm.html").forward(request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("profileForm.html").forward(request, response);
            return;
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Success - forward to confirmation page
        request.setAttribute("profileData", profile);
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}