package servlets;

import dao.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import entities.AppEntities.User;


@WebServlet("/Register")
public class Register extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("error_page.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Set request encoding to UTF-8
        request.setCharacterEncoding("UTF-8");

        User sessionUser = (User) request.getSession().getAttribute("user");
        if(sessionUser!=null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Get register form fields
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String password_rep = request.getParameter("password_repeat");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String country = request.getParameter("country");
        String address = request.getParameter("address");
        String role = request.getParameter("UserRole");

        Integer role_int = Integer.parseInt(role);
        if(role_int > 1 || role_int < 1)
            response.sendRedirect("error_page.jsp");

        // Create UserDTO
        User userInfo = new User( username, password, email, phone, country, address, Integer.parseInt(role));

        // Create UserDAO and Add new user to database
        UserDAO dao = new UserDAO(true);
        Integer register_result = dao.insertUser(userInfo, 0);

        // Set response encoding to UTF-8
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        RequestDispatcher dispatcher2 = request.getRequestDispatcher("registerSuccess.jsp");


        if (register_result == -2 || register_result == -1){     // Duplicate email check
            request.setAttribute("register-error", register_result);
            dispatcher.forward(request, response);
        }
        else if (!password.equals(password_rep)){
            request.setAttribute("register-error", -3);
            dispatcher.forward(request, response);
        }
        // No Errors. Register is successful
        else if (register_result == 1){
            request.setAttribute("username", username);
            dispatcher2.forward(request, response);
        }
    }
}
