package dao;

import entities.AppEntities.Personal_Information;
import entities.AppEntities.User;
import servlets.Personal_Info;

import java.sql.*;
import java.util.*;

public class Personal_InformationDAO {


    private static final String SQL_ADD_NEW_PERSONAL_INFO = "INSERT INTO Personal_Information ( work_experience, School, University, skills, user_info, Is_work_experience_private, Is_skills_private, Is_university_private) VALUES ( ?, ? , ?, ?, ?, ?, ?,?)";
    private static final String SQL_SEARCH_USER_PERSONAL_INFO_NAME = "SELECT * FROM Personal_Information WHERE user_info = ? ";


    private ConnectionFactory factory;

    public Personal_InformationDAO(boolean pool)
    {
        factory = ConnectionFactory.getInstance(pool);
    }


    public Integer insertPersonalInformation(Personal_Information personalInfo){

        int ret = -1;

        Object[] values = {  personalInfo.getWork_Experience(), personalInfo.getSchool(), personalInfo.getUniversity()
                , personalInfo.getSkills(), personalInfo.getUser_info(), personalInfo.getIs_work_experience_private(),
                personalInfo.getIs_skills_private(), personalInfo.getIs_skills_private()};

        try {
            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_ADD_NEW_PERSONAL_INFO, false, values);

            int affectedRows = statement.executeUpdate();
            ret = affectedRows;

            connection.close();

            if (ret == 0) {
                System.err.println("Creating user failed, no rows affected.");
                return ret;
            }
            // if User was created from the UI then set initial rating to 0
           /* else if (ret != 0 && is_imported == 0){
                insertRating(userInfo.getUsername(), 0);
            }*/

        } catch (SQLIntegrityConstraintViolationException e1){
            return  -2;

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            return ret;
        }

        ret = 1;

        return ret;
    }


    public Personal_Information getPersonalInformationbyName(String username){

        try{

            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_SEARCH_USER_PERSONAL_INFO_NAME, false, username);
            ResultSet results = statement.executeQuery();

            if(!results.next()) {
                connection.close();
                throw new RuntimeException("No results at getUserByName");
            }
            else{
                Personal_Information personalInfo = new Personal_Information( results.getString("work_experience"),
                        results.getString("School"), results.getString("University"), results.getString("skills"),
                        results.getString("user_info"),results.getInt("Is_work_experience_private"),results.getInt("Is_skills_private"), results.getInt("Is_university_private"));
                connection.close();
                return personalInfo;
            }
        }
        catch (SQLException e){
            System.err.println(e.getMessage());
            throw new RuntimeException("ERROR at getUserByName");
        }
    }

}
