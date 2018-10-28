package entities.XmlEntities;

import javax.xml.bind.annotation.*;

@XmlType(propOrder = { "work_experience", "university", "skills", "user_info" })
@XmlRootElement(name = "CV")
public class XmlCv{

        private  String work_experience;
        private String university;
        private String skills;
        private String school;
        private String user_info;
    @XmlElement(name="university")
    public String getUniversity() {
        return university;
    }

    public void setUniversity(String university) {
        this.university = university;
    }
    @XmlElement(name="skills")
    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }
    @XmlElement(name="user_info")
    public String getUser_info() {
        return user_info;
    }

    public void setUser_info(String user_info) {
        this.user_info = user_info;
    }
    @XmlElement(name="work_experience")
    public String getWork_experience() {
        return work_experience;
    }

    public void setWork_experience(String work_experience) {
        this.work_experience = work_experience;
    }
    @XmlElement(name="school")
    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }
}
