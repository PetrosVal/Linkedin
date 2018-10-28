package dao;

import entities.AppEntities.Message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MessageDAO {

    private static final String SQL_GET_RECEIVED_MSGS = "SELECT * FROM Message WHERE User_to = (?)  ORDER BY Time DESC";
    private static final String SQL_GET_MSG_BY_TITLE = "SELECT * FROM Message WHERE Subject = (?)";
    private static final String SQL_GET_SENT_MSGS = "SELECT * FROM Message WHERE User_from = (?) ORDER BY Time DESC";
    private static final String SQL_SEND_REPLY = "INSERT INTO Message (User_from, User_to, Subject,Is_read, Text, Time,show_sent,show_received) VALUES (?, ?, ?, ?, ?,?,?,?)";
    private static final String SQL_UPDATE_ISREAD = "UPDATE Message SET Is_read=1 WHERE Subject= ?";
    private static final String SQL_GET_USER_NEW_MSGS = "SELECT COUNT(*) AS count FROM Message WHERE User_to = (?) AND Is_read=0 ";
    private static final String SQL_AUTO_MSG = "INSERT INTO Message (User_from, User_to, Is_read, Time, Subject, Text, show_sent, show_received) VALUES (?, ?, ?, ?, ?, ?,?,?)";

    private ConnectionFactory factory;

    public MessageDAO(boolean pool) {
        factory = ConnectionFactory.getInstance(pool);
    }


    public List<Message> getMessages(String user_id, Integer operation) {
        // operation = 0 -> Get Received Messages
        // operation = 1 -> Get Send Messages

        List<Message> messages = new ArrayList<>();

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            if (operation == 0)
                statement = DAOUtil.prepareStatement(connection, SQL_GET_RECEIVED_MSGS, false, user_id);
            else if (operation == 1)
                statement = DAOUtil.prepareStatement(connection, SQL_GET_SENT_MSGS, false, user_id);
            else
                throw new RuntimeException("Wrong Operation Given");

            ResultSet results = statement.executeQuery();

            while (results.next()) {
              //  Integer id = results.getInt("idMessages");
                String sender_id = results.getString("User_from");
                String receiver_id = results.getString("User_to");
                String message_title = results.getString("Subject");
                String message_content = results.getString("Text");
                Integer is_read = results.getInt("Is_read");
                Date date = results.getTimestamp("Time");

                Message message = new Message( sender_id, receiver_id, message_title, message_content, is_read, date);

                messages.add(message);
            }
            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERROR: " + ex.getMessage());
            return null;
        }

        return messages;
    }



    public void sendReplyMessage(Message message) {
        String sender_id = message.getSender_id();
        String receiver_id = message.getReceiver_id();
        String message_title = message.getTitle();
        String message_content = message.getMessage();
        Date date_sent = message.getDate();
        Integer is_read =message.getIs_read();

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            statement = DAOUtil.prepareStatement(connection, SQL_SEND_REPLY, true, sender_id, receiver_id, message_title,is_read, message_content, date_sent,0,0);

            if (statement.executeUpdate() == 0)
                throw new RuntimeException("Creating item failed, no rows affected.");

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at message reply");
        }
    }

    public void updateIsRead(String message_id){
        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_UPDATE_ISREAD, false, message_id);
            statement.executeUpdate();

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at update is_read");
        }
    }

    public Integer getUserNewMessages(String user_id){

        Integer counter = 0;

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_GET_USER_NEW_MSGS, false, user_id);
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
            throw new RuntimeException("Error at getUserNewMessages");
        }

        return counter;
    }


    public Message getMessageByTitle(String message_id){

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = null;
            statement = DAOUtil.prepareStatement(connection, SQL_GET_MSG_BY_TITLE, false, message_id);

            ResultSet results = statement.executeQuery();

            if(results.next()) {

               // Integer id = results.getInt("id");
                String sender_id = results.getString("User_from");
                String receiver_id = results.getString("User_to");
                String message_title = results.getString("Subject");
                String message_content = results.getString("Text");
                Integer is_read = results.getInt("Is_read");
                Date date = results.getTimestamp("Time");
               // Integer is_auto = results.getInt("is_auto");

                Message message = new Message( sender_id, receiver_id, message_title, message_content, is_read, date);

                connection.close();

                return message;
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

    public void autoSuccessMessage ( String sender_id, String receiver_id, Date date_sent){

        String message_title = "Message";
        String message_content = "Παρακαλώ,επικοινωνήστε μαζί μου το συντομότερο δυνατό.";

        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_AUTO_MSG, true, sender_id, receiver_id, 1, date_sent,message_title ,message_content ,1,1);

            if (statement.executeUpdate() == 0)
                throw new RuntimeException("Creating Auto Message Failed");

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at auto message");
        }
    }

}
