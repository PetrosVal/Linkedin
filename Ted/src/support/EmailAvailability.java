package support;


import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;



@WebServlet("/EmailAvailability")
public class EmailAvailability extends HttpServlet{


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get email from ajax
        String email = request.getParameter("email");

        // Check email availability
        UserDAO dao = new UserDAO(true);
        boolean exists = dao.existsEmail(email);

        response.setContentType("text/plain");

        if (exists)
            response.getWriter().print("Email Exists!");
    }
}
