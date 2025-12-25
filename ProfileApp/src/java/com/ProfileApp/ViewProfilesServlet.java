package com.ProfileApp;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewProfiles")
public class ViewProfilesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ProfileBean> list = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/student_profiles", "app", "app");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM profile");

            while (rs.next()) {
                ProfileBean p = new ProfileBean();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setStudentId(rs.getString("student_id"));
                p.setProgram(rs.getString("program"));
                p.setEmail(rs.getString("email"));
                list.add(p);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("profiles", list);
        request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
    }
}
