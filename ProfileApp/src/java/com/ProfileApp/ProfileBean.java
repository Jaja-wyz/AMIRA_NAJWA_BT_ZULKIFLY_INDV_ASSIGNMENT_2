package com.ProfileApp;

import java.io.Serializable;

public class ProfileBean implements Serializable {
    private int id;
    private String name, studentId, programme, email, hobbies, introduction;

    public ProfileBean() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getProgramme() { return programme; }
    public void setProgramme(String programme) { this.programme = programme; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getHobbies() { return hobbies; }
    public void setHobbies(String hobbies) { this.hobbies = hobbies; }

    public String getIntroduction() { return introduction; }
    public void setIntroduction(String introduction) { this.introduction = introduction; }
}