package com.ProfileApp;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("ViewProfilesServlet?error=Invalid profile ID");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            
            // Validate required fields
            String name = request.getParameter("name");
            String studentId = request.getParameter("studentId");
            String program = request.getParameter("program");
            String email = request.getParameter("email");
            
            if (name == null || name.trim().isEmpty() ||
                studentId == null || studentId.trim().isEmpty() ||
                program == null || program.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                
                response.sendRedirect("EditServlet?id=" + id + "&error=All fields are required");
                return;
            }
            
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/student_profiles", "app", "app");

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE profile SET name=?, student_id=?, program=?, email=?, hobbies=?, introduction=? WHERE id=?");

            ps.setString(1, name.trim());
            ps.setString(2, studentId.trim());
            ps.setString(3, program.trim());
            ps.setString(4, email.trim());
            ps.setString(5, request.getParameter("hobbies") != null ? request.getParameter("hobbies").trim() : "");
            ps.setString(6, request.getParameter("introduction") != null ? request.getParameter("introduction").trim() : "");
            ps.setInt(7, id);

            int rowsUpdated = ps.executeUpdate();
            conn.close();
            
            if (rowsUpdated > 0) {
                response.sendRedirect("ViewProfilesServlet?success=updated");
            } else {
                response.sendRedirect("ViewProfilesServlet?error=Profile not found");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("ViewProfilesServlet?error=Invalid profile ID format");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("ViewProfilesServlet?error=Database driver error");
        } catch (SQLException e) {
            e.printStackTrace();
            // Check for duplicate student ID
            if (e.getMessage().contains("duplicate") || e.getMessage().contains("unique")) {
                response.sendRedirect("EditServlet?id=" + idParam + "&error=Student ID already exists");
            } else {
                response.sendRedirect("ViewProfilesServlet?error=Database error: " + e.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewProfilesServlet?error=Unexpected error");
        }
    }
}