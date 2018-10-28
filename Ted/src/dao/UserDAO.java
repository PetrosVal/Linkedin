package dao;

import entities.AppEntities.User;
import java.sql.*;
import java.util.*;

public class UserDAO {

    private int numOfResults;
    private int numOfPages;
    private static final int USERS_PER_PAGE = 15;
    private static final int RESULTS_PER_PAGE = 15;


    private static final Integer EMAIL_EXISTS_ERROR = -2;
    private static final String SQL_ADD_NEW_USER = "INSERT INTO User ( UserId, Password, Email, Phone, Country, Address, Access_lvl) VALUES ( ?, MD5(?) , ?, ?, ?, ?, ?)";
    private static final String SQL_SEARCH_USER = "SELECT * FROM User WHERE UserId = ? AND Password = MD5(?) ";
    private static final String SQL_SEARCH_USER_BY_ID = "SELECT * FROM User WHERE UserId = ? ";
    private static final String SQL_SEARCH_USER_BY_USERNAME = "SELECT * FROM User WHERE UserId = ? ";
    private static final String SQL_EXISTS_USER = "SELECT 1 FROM User WHERE Email = ?";
    private static final String SQL_CHANGE_EMAIL_PASSWORD = "UPDATE User SET Email = ? , Password = MD5(?) WHERE UserId= ?";
    private static final String SQL_GET_USER_LIST = "SELECT SQL_CALC_FOUND_ROWS * FROM User ORDER BY UserId DESC LIMIT ?, " + USERS_PER_PAGE;
    private static final String SQL_SEARCH_USERS = "SELECT SQL_CALC_FOUND_ROWS DISTINCT UserId FROM User WHERE User.Country LIKE ? AND  User.UserId LIKE ? ";

    private ConnectionFactory factory;

    public UserDAO(boolean pool)
    {
        factory = ConnectionFactory.getInstance(pool);
    }

    public int getNumOfResults() {
        return numOfResults;
    }

    public int getNumOfPages() {
        return numOfPages;
    }



    public Integer insertUser(User userInfo, Integer is_imported){
        //is_imported = 0 -> User created from UI
        //is_imported = 1 -> User created from xml files

        int ret = -1;
        /*int validated = 0;
        if (is_imported == 1){
            validated = 1;
        }*/

        Object[] values = {  userInfo.getUsername(), userInfo.getPassword(), userInfo.getEmail()
                , userInfo.getPhone(), userInfo.getCountry(), userInfo.getAddress(),
                userInfo.getRole()};

        try {
            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_ADD_NEW_USER, false, values);

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
            return  EMAIL_EXISTS_ERROR;

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            return ret;
        }

        ret = 1;

        return ret;
    }

    public User getUser(String username, String password){

        try{

            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_SEARCH_USER, false, username, password);
            ResultSet results = statement.executeQuery();
            if(!results.next()) {
                connection.close();
                return null;
            }
            else{
                User user = new User(results.getString("UserId"), null,
                        results.getString("Email"), results.getString("Phone"), results.getString("Country"),
                        results.getString("Address"), results.getInt("Access_lvl"));

                //user.setId(results.getInt("id"));
                connection.close();
                return user;

            }
        }
        catch (SQLException e){
            System.err.println(e.getMessage());
            return null;
        }
    }


    public User getUserbyID(Integer id){

        try{

            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_SEARCH_USER_BY_ID, false, id);
            ResultSet results = statement.executeQuery();

            if(!results.next()) {
                connection.close();
                return null;
            }
            else{
                User user = new User(results.getString("username"), null,
                        results.getString("email"), results.getString("phone"), results.getString("country"),
                        results.getString("address") , results.getInt("role"));

                //user.setId(results.getInt("id"));
                connection.close();
                return user;
            }

        }
        catch (SQLException e){
            System.err.println(e.getMessage());
            return null;
        }
    }



    public User getUserbyName(String username){

        try{

            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_SEARCH_USER_BY_USERNAME, false, username);
            ResultSet results = statement.executeQuery();

            if(!results.next()) {
                connection.close();
                throw new RuntimeException("No results at getUserByName");
            }
            else{
                User user = new User( results.getString("UserId"), null,
                        results.getString("Email"), results.getString("Phone"), results.getString("Country"),
                        results.getString("Address"),results.getInt("Access_lvl"));
                connection.close();
                return user;
            }
        }
        catch (SQLException e){
            System.err.println(e.getMessage());
            throw new RuntimeException("ERROR at getUserByName");
        }
    }


    public boolean existsEmail(String email){

        try{
            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_EXISTS_USER, false, email);
            ResultSet results = statement.executeQuery();

            // email does not exist
            if (!results.isBeforeFirst()){
                connection.close();
                return false;
            }
            // email exists
            else {
                connection.close();
                return true;
            }
        }
        catch (SQLException e){
            System.err.println(e.getMessage());
            return false;
        }
    }

    public List<User> getUserList(Integer page){

        List<User> list = new ArrayList<User>();

        if(page < 1)
            return list;

        Integer offset = (page-1) * USERS_PER_PAGE;

        try{
            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection,SQL_GET_USER_LIST, false, offset);
            ResultSet results = statement.executeQuery();

            while(results.next()){
                User user = new User(results.getString("UserId"),  null,
                        results.getString("Email"), results.getString("Phone"), results.getString("Country"),
                        results.getString("Address"), results.getInt("Access_lvl"));

                list.add(user);
            }

            //get number of rows
            results = statement.executeQuery("SELECT FOUND_ROWS()");
            results.next();
            numOfResults = results.getInt(1);

            if(numOfResults%USERS_PER_PAGE==0)
                numOfPages = numOfResults/USERS_PER_PAGE;
            else
                numOfPages = (numOfResults/USERS_PER_PAGE)+1;

            connection.close();
            return list;
        }
        catch (SQLException e){
            System.err.println(e.getMessage());
        }
        return list;
    }


    public void changeEmailPassword(String email, String password ,String username){
        try {
            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_CHANGE_EMAIL_PASSWORD, false,email,password, username);
            statement.executeUpdate();

            connection.close();

        } catch (SQLException ex) {
            System.out.println("ERRORI: " + ex.getMessage());
            throw new RuntimeException("Error at change email + password");
        }
    }


    public List<User> getSearchResults(String text, String location, Integer page){
        List<User> items = new ArrayList<User>();

        if(page < 1)
            return items;

        Integer offset = (page-1) * RESULTS_PER_PAGE;

        try{
            Connection connection = factory.getConnection();
            PreparedStatement statement;

            statement = DAOUtil.prepareStatement(connection, SQL_SEARCH_USERS,false);

            if(location == null || location.equals("")){
                statement.setString(1, "%");

            }
            else {
                statement.setString(1,   location );

            }
            if(text == null || text.equals("")){
                statement.setString(2, "%");

            }
            else {
                statement.setString(2,  text );
            }

           // statement.setInt(3, offset);



            //execute query
            ResultSet result = statement.executeQuery();

            //get a list of items
            while (result.next()) {
                String id = result.getString("UserId");
                if (id!=null) {
                    User item = getUserbyName(id);
                    items.add(item);
                }
            }

            //get number of rows
            result = statement.executeQuery("SELECT FOUND_ROWS()");
            result.next();
            numOfResults = result.getInt(1);

            if(numOfResults%RESULTS_PER_PAGE==0)
                numOfPages = numOfResults/RESULTS_PER_PAGE;
            else
                numOfPages = (numOfResults/RESULTS_PER_PAGE)+1;

            connection.close();
            return items;

        }
        catch (SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
            throw new RuntimeException("Error at getSearchResults");
        }
    }
}
