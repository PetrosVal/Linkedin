package dao;

import entities.AppEntities.Friend_Request;
import entities.AppEntities.Message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Friend_RequestDAO {

    private static final String SQL_GET_RECEIVED_RQSTS = "SELECT * FROM Friend_Request WHERE User_Request_To = (?) ";
    private static final String SQL_GET_ACEPTED_RQSTS = "SELECT * FROM Friend_Request WHERE (User_Request_From = (?) OR User_Request_To =(?)) AND Is_accepted = 1 ";
    private static final String SQL_GET_RQSTS_BY_ID = "SELECT * FROM Friend_Request WHERE User_Request_From = (?) AND User_Request_To = (?)";
    private static final String SQL_GET_SENT_RQSTS = "SELECT * FROM Friend_Request  WHERE User_Request_From = (?) ";
    private static final String SQL_SEND_REPLY_RQSTS = "INSERT INTO Friend_Request (User_Request_From, User_Request_To, Is_accepted ) VALUES (?, ?, ?,)";
    private static final String SQL_UPDATE_ISACCEPTED = "UPDATE Friend_Request SET Is_accepted=1 WHERE User_Request_From= ? AND User_Request_To= ?";
    private static final String SQL_GET_USER_NEW_RQSTS = "SELECT COUNT(*) AS count FROM Friend_Request WHERE User_Request_To = (?) AND Is_accepted=0 ";
    private static final String SQL_AUTO_FRQ = "INSERT INTO Friend_Request (User_Request_From, User_Request_To, Is_accepted) VALUES (?, ?, ?)";

    private ConnectionFactory factory;

    public Friend_RequestDAO(boolean pool) {
        factory = ConnectionFactory.getInstance(pool);
    }

    public List<Friend_Request> getFriendRequests(String user_id, Integer operation) {
        // operation = 0 -> Get Received requests
        // operation = 1 -> Get Send requests

        List<Friend_Request> friend_requests = new ArrayList<>();

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            if (operation == 0)
                statement = DAOUtil.prepareStatement(connection, SQL_GET_RECEIVED_RQSTS, false, user_id);
            else if (operation == 1)
                statement = DAOUtil.prepareStatement(connection, SQL_GET_SENT_RQSTS, false, user_id);
            else
                throw new RuntimeException("Wrong Operation Given");

            ResultSet results = statement.executeQuery();

            while (results.next()) {
               String sender_id = results.getString("User_Request_From");
               String receiver_id = results.getString("User_Request_To");
               Integer is_accepted = results.getInt("Is_accepted");

                Friend_Request friend_request = new Friend_Request( sender_id, receiver_id, is_accepted);

                friend_requests.add(friend_request);
            }
            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
            return null;
        }

        return friend_requests;
    }


    public List<Friend_Request> getFriendRequestsAccepted(String user_id) {
        // operation = 0 -> Get Received requests
        // operation = 1 -> Get Send requests

        List<Friend_Request> friend_requests = new ArrayList<>();

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            statement = DAOUtil.prepareStatement(connection, SQL_GET_ACEPTED_RQSTS, false, user_id,user_id);

            ResultSet results = statement.executeQuery();

            while (results.next()) {
                String sender_id = results.getString("User_Request_From");
                String receiver_id = results.getString("User_Request_To");
                Integer is_accepted = results.getInt("Is_accepted");

                Friend_Request friend_request = new Friend_Request( sender_id, receiver_id, is_accepted);

                friend_requests.add(friend_request);
            }
            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
            return null;
        }

        return friend_requests;
    }


    public Friend_Request getFriendRequestById(String request_id_1,String  request_id_2){

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            statement = DAOUtil.prepareStatement(connection, SQL_GET_RQSTS_BY_ID, false, request_id_1, request_id_2);

            ResultSet results = statement.executeQuery();

            if(results.next()) {

                String sender_id = results.getString("User_Request_from");
                String receiver_id = results.getString("User_Request_to");
                Integer is_accepted = results.getInt("Is_accepted");

                Friend_Request friend_request = new Friend_Request( sender_id, receiver_id, is_accepted);

                connection.close();

                return friend_request;
            }
            else {
                connection.close();
                return null;
            }
        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            return null;
        }
    }

    /*public void sendReplyRequest(Friend_Request request) {
        Integer is_accepted = request.getIs_accepted();
        Integer sender_id = request.getRequest_from();
        Integer receiver_id = request.getRequest_to();


        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            statement = DAOUtil.prepareStatement(connection, SQL_SEND_REPLY_RQSTS, true,sender_id, receiver_id, is_accepted );

            if (statement.executeUpdate() == 0)
                throw new RuntimeException("Creating item failed, no rows affected.");

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at request reply");
        }
    }*/


    public void updateIsAccepted(String request_id_1 ,String request_id_2){
        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_UPDATE_ISACCEPTED, false, request_id_1,request_id_2);
            statement.executeUpdate();

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at update is_accpted");
        }
    }


    public Integer getUserNewRequests(Integer user_id){
        Integer counter = 0;

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_GET_USER_NEW_RQSTS, false, user_id);
            ResultSet results = statement.executeQuery();

            if(results.next())
                counter = results.getInt("count");
            else {
                connection.close();
                return null;
            }

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at getUserNewRequests");
        }
        return counter;
    }


    public void autoSuccessFriendRequest ( String sender_id, String receiver_id){

        //String message_title = "Message";
       // String message_content = "Παρακαλώ,επικοινωνήστε μαζί μου το συντομότερο δυνατό.";

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_AUTO_FRQ, true, sender_id, receiver_id, 0);

            if (statement.executeUpdate() == 0)
                throw new RuntimeException("Creating Auto Message Failed");

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at auto message");
        }
    }
}
