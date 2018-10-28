package servlets;


import dao.Friend_RequestDAO;
import dao.UserDAO;
import entities.AppEntities.Networking;
import entities.AppEntities.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;


@WebServlet("/FriendRequest")
public class FriendRequest extends HttpServlet{



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Set request encoding to UTF-8
        request.setCharacterEncoding("UTF-8");
        // Get auction parameters
        String id = request.getParameter("id");
        //Integer auction_id = Integer.valueOf(id);
        UserDAO dao = new UserDAO(true);

        // Check if auction exists in DB (if exists)
        // boolean exists = dao.existsItem(auction_id);
        // Set response encoding to UTF-8
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // RequestDispatcher dispatcher = request.getRequestDispatcher("my_messages.jsp");


        // Check if in the meantime the auction has ended
        Date now = new Date();
        // Item item = dao.getItemByID(auction_id);
        //  Date ends = item.getEnds();

        User user_from = (User) request.getSession().getAttribute("user");
        if (user_from == null || user_from.getRole() == 0) {
            response.sendRedirect("error_page.jsp");
            return;
        }

        // If I get here then the item CAN be bought

        // 1) Send a message to the user that bought it
        UserDAO udao = new UserDAO(true);

       Friend_RequestDAO mdao = new Friend_RequestDAO(true);

        mdao.autoSuccessFriendRequest(user_from.getUsername(), id);


        response.sendRedirect("my_notifications.jsp");
    }

}
