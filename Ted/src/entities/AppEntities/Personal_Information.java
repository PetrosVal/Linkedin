package entities.AppEntities;

public class Personal_Information {

   // private Integer id;
    private  String work_experience;
    private String school;
    private String university;
    private String skills;
    private String user_info;
    private Integer Is_work_experience_private;
    private Integer Is_skills_private;
    private Integer Is_university_private;


    public Personal_Information (String work_experience, String school, String university,
                 String skills, String user_info, Integer Is_work_experience_private, Integer Is_skills_private, Integer Is_university_private ) {

        //this.id = id;
        this.work_experience = work_experience;
        this.school = school;
        this.university = university;
        this.skills = skills;
        this.user_info = user_info;
        this.Is_work_experience_private = Is_work_experience_private;
        this.Is_skills_private = Is_skills_private;
        this.Is_university_private = Is_university_private;
    }


    /*public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }*/

    public String getWork_Experience() {
        return work_experience;
    }

    public void setWork_experiece(String work_experiece) {
        this.work_experience = work_experiece;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getUniversity() {
        return university;
    }

    public void setUniversity(String university) {
        this.university = university;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getUser_info() {
        return user_info;
    }

    public void setUser_info(String user_info) {
        this.user_info = user_info;
    }

    public Integer getIs_work_experience_private() {
        return Is_work_experience_private;
    }

    public void setIs_work_experience_private(Integer Is_work_experience_private) {
        this.Is_work_experience_private =  Is_work_experience_private;
    }

    public Integer getIs_skills_private() {
        return Is_skills_private;
    }

    public void setIs_skills_private(Integer Is_skills_private) {
        this.Is_skills_private =  Is_work_experience_private;
    }

    public Integer getIs_university_private() {
        return Is_university_private;
    }

    public void setIs_university_private(Integer Is_university_private) {
        this.Is_university_private =  Is_university_private;
    }


}
