package servlets;

import dao.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.desktop.SystemSleepEvent;
import java.io.IOException;
import entities.AppEntities.User;


@WebServlet("/Settings")
public class Change_email_password extends HttpServlet {

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
        String password = request.getParameter("new_password");
        String email = request.getParameter("new_email");


        // Create UserDTO
       // User userInfo = new User( username, password, email, phone, country, address, Integer.parseInt(role));

        // Create UserDAO and Add new user to database
        UserDAO dao = new UserDAO(true);
        //Integer register_result = dao.insertUser(userInfo, 0);
        dao.changeEmailPassword(email,password,username);

        // Set response encoding to UTF-8
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        //RequestDispatcher dispatcher = request.getRequestDispatcher("my_settings.jsp");
        RequestDispatcher dispatcher2 = request.getRequestDispatcher("index.jsp");
        request.setAttribute("username", username);
        dispatcher2.forward(request, response);

    }
}
