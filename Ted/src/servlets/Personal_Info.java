package servlets;

import dao.UserDAO;

import dao.Personal_InformationDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.desktop.SystemSleepEvent;
import java.io.IOException;

import entities.AppEntities.Personal_Information;
import entities.AppEntities.User;

@WebServlet("/Info")
public class Personal_Info extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("error_page.jsp");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Set request encoding to UTF-8
        request.setCharacterEncoding("UTF-8");

        User sessionUser = (User) request.getSession().getAttribute("user");
        if(sessionUser==null) {
            response.sendRedirect("index.jsp");
            return;
        }
        String username = sessionUser.getUsername();
        // Get settings form fields
        String work_experience = request.getParameter("workexperience");
        String school = request.getParameter("school");
        String university = request.getParameter("university");
        String skills = request.getParameter("skills");
        String IsWorkExperiencePrivate = request.getParameter("IsWorkExperiencePrivate");
        String IsSkillsPrivate = request.getParameter("IsSkillsPrivate");
        String IsUniversityPrivate = request.getParameter("IsUniversityPrivate");



       // System.out.println(IsWorkExperiencePrivate);
      //  System.out.println(IsSkillsPrivate);
      //  System.out.println(IsUniversityPrivate);

        Integer experience_private;
        Integer skills_private;
        Integer university_private;

        if(IsWorkExperiencePrivate.equals("on")){

             experience_private=1;
        }
        else {
             experience_private= 0;
        }

        if(IsSkillsPrivate.equals("on")){

             skills_private =1;

        }
        else {
            skills_private= 0;
        }

        if(IsUniversityPrivate.equals("on")){

             university_private= 1;

        }
        else{
            university_private=0;
        }

        //System.out.println(  experience_private);
       // System.out.println( skills_private);
       // System.out.println( university_private);

         Personal_Information personalInfo = new Personal_Information( work_experience, school, university, skills, username, experience_private , skills_private , university_private);


        Personal_InformationDAO dao = new Personal_InformationDAO(true);
        //Integer register_result = dao.insertUser(userInfo, 0);
        Integer personalInfo_result =  dao.insertPersonalInformation(personalInfo);

        // Set response encoding to UTF-8
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        //RequestDispatcher dispatcher = request.getRequestDispatcher("my_settings.jsp");
        RequestDispatcher dispatcher2 = request.getRequestDispatcher("index.jsp");
        request.setAttribute("username", username);
        dispatcher2.forward(request, response);
    }
}
