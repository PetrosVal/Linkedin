package dao;

import entities.AppEntities.User_does_Networking;
import entities.AppEntities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User_does_NetworkingDAO {

    private ConnectionFactory factory;

    private static final String SQL_INSERT_COMMUNICATION = "INSERT INTO User_does_Networking (User_UserId, Networking_NetworkingId, Username, Email, Time) VALUES (?,?, ?, ?, ?)";
    private static final String SQL_GET_NETWORKING_COMMUNICATION = "SELECT User_does_Networking.Networking_NetworkingId, User_does_Networking.Username, User_does_Networking.Email, User_does_Networking.Time" +
            " User.country FROM ted.User_does_Networking, ted.User WHERE User_does_Networking. = ? " +
            "AND User.Username = User_does_Networking.Username  ORDER BY User_does_Networking.Time DESC";

    public User_does_NetworkingDAO(boolean pool) {
        factory = ConnectionFactory.getInstance(pool);
    }

    public void insertCommunication(User_does_Networking communication, Integer networking_id) {


        Integer User_does_Networking_userid = communication.getUserID();
        String User_does_Networking_name = communication.getUsername();
        String User_does_Networking_email = communication.getEmail();
        Date User_does_Networking_time = communication.getTime();
        try {
            Connection connection = factory.getConnection();
            PreparedStatement statement;

            // Check if Bidder exists and if not create the User-Bidder
            UserDAO udao = new UserDAO(true);

            boolean exists = udao.existsEmail(User_does_Networking_email);

            // If user does not exist
            if (!exists){
                User user = new User("Nikolaos Korompos", "root", "root@email.com", "6934999656","Greece",
                        "Κορόμπου 13",1);

                // Insert new user
                udao.insertUser(user, 1);
            }

            // Insert the COMMUNICATION
            statement = DAOUtil.prepareStatement(connection, SQL_INSERT_COMMUNICATION, true, User_does_Networking_userid ,networking_id,User_does_Networking_name, User_does_Networking_email , User_does_Networking_time);

            if (statement.executeUpdate() == 0)
                throw new RuntimeException("Creating COMMUNICATION failed, no rows affected.");

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
            throw new RuntimeException("Errori at InsertCommunication");
        }
    }
}
