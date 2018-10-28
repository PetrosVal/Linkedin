package servlets.Messages;

import dao.MessageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/checkUserNewMessages")
public class checkUserNewMessages extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get user id
        String  user_id = String.valueOf(request.getParameter("userid"));
        // Check for new/unread messages
        MessageDAO dao = new MessageDAO(true);
        Integer new_messages_counter = dao.getUserNewMessages(user_id);

        response.getWriter().print(new_messages_counter);
    }
}
