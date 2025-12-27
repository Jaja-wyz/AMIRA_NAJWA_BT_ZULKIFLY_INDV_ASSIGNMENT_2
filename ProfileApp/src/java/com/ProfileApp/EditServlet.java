package com.ProfileApp;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect("ViewProfilesServlet?error=Missing profile ID");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            // ✅ LOAD DRIVER FIRST
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            try (
                Connection conn = DriverManager.getConnection(
                        "jdbc:derby://localhost:1527/student_profiles", "app", "app");
                PreparedStatement ps = conn.prepareStatement(
                        "SELECT * FROM profile WHERE id=?")
            ) {
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    ProfileBean p = new ProfileBean();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setStudentId(rs.getString("student_id"));
                    p.setProgramme(rs.getString("program"));
                    p.setEmail(rs.getString("email"));
                    p.setHobbies(rs.getString("hobbies"));
                    p.setIntroduction(rs.getString("introduction"));

                    request.setAttribute("profile", p);
                    request.getRequestDispatcher("/editProfile.jsp")
                           .forward(request, response);
                } else {
                    response.sendRedirect("ViewProfilesServlet?error=Profile not found");
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

    }
}
