package dao;

import entities.AppEntities.*;

import java.sql.*;
import java.util.Date;
import java.util.*;

public class NetworkingDAO {

    private final Integer LOW_BET = -1;
    private int numOfResults;
    private int numOfPages;
    private static final int RESULTS_PER_PAGE = 15;
    private static final int CATEGORIES_PER_PAGE = 30;
    private static final int KNN = 30;
    private static final int MAX_REC_ITEMS_PER_USER = 10;

    private static final String SQL_ADD_NEW_NETWORKING = "INSERT INTO Networking (Name, Country,  Expiration_time, Description, Creator,  Comment , Image) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_DELETE_NETWORKING = "DELETE FROM Networking WHERE NetworkingId = (?)";
    private static final String SQL_GET_USER_NETWORKING = "SELECT * FROM Networking WHERE Networking.Creator = (?)";
    private static final String SQL_GET_NETWORKING = "SELECT * FROM Networking WHERE Name = (?)";
    private static final String SQL_INSERT_NEW_COMMUNICATION = "INSERT INTO User_does_Networking (Networking_NetworkingId, Country, Username, Time) VALUES (?, ?, ?, ?)";
    private static final String SQL_GET_ALL_USERNAMES = "SELECT Username FROM User";
    private static final String SQL_BELONGS_TO_USER = "SELECT * FROM Networking WHERE Creator = ? AND NetworkingId = ?";
    private static final String SQL_GET_REC_ITEMS = "SELECT item_id FROM recommendations WHERE userRecommendation = ? ORDER BY rank ASC";
    private static final String SQL_UPDATE_RECOMMENDATIONS = "INSERT INTO recommendations (userRecommendation, rank, titleRecommendation) VALUES(?, ?, ?) ON DUPLICATE KEY UPDATE titleRecommendation = ?";
    private static final String SQL_GET_NEIGHBORS = "SELECT DISTINCT a2.Creator, COUNT(DISTINCT a2.Creator, a2.Name) AS c " +
            "FROM ted.Networking AS a1, ted.Networking AS a2 WHERE a1.Creator = ? AND a2.Name = a1.Name " +
            "AND a2.Creator != a1.Creator GROUP BY a2.Creator ORDER BY c DESC LIMIT 0 , " + KNN;
    private static final String SQL_GET_NEIGHBORHOOD_NETWORKINGS = "SELECT a1.Name FROM ted.Networking AS a1, ted.Networking AS items " +
            "WHERE a1.Creator = ? AND a1.Name = items.Name  " +
            "AND NOT EXISTS( SELECT * FROM ted.Networking AS a2 WHERE a2.Name = a1.Name AND a2.Creator = ?)";



    private ConnectionFactory factory;


    public NetworkingDAO(boolean pool)
    {
        factory = ConnectionFactory.getInstance(pool);
    }


    public boolean belongsToUser(String username, Integer item_id){

        try {

            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_BELONGS_TO_USER, false, username, item_id);

            ResultSet resultSet = statement.executeQuery();

            // Item does not belong to this User
            if (!resultSet.isBeforeFirst()) {
                connection.close();
                return false;
            }

            connection.close();
        }
        catch (SQLException ex){
            System.err.println("ERROR: " + ex.getMessage());
            throw new RuntimeException("Error at belongsToUser");
        }
        return true;
    }



    public List<Networking> getUserNetworkings (String username){

        List<Networking> userNetworkings = new ArrayList<>();

        try {

            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_GET_USER_NETWORKING, false, username);
            ResultSet results = statement.executeQuery();

            while(results.next()){

                String title = results.getString("Name");       //done
                String country = results.getString("Country");  //done
                Date expiration_time = results.getTimestamp("Expiration_time");
                String response_user = results.getString("response_user");
                String creator = results.getString("Creator");            //done
                String description = results.getString("Description");  //done
                String comment = results.getString("Comment");
                String image = results.getString("Image");            //done

                //PreparedStatement statement2 = DAOUtil.prepareStatement(connection, SQL_GET_ITEM_CATEGORIES, false, id);
                //ResultSet results2 = statement2.executeQuery();

                List<String> categories = new ArrayList<>();

              /*  while(results2.next()) {
                    categories.add(results2.getString("category"));
                }*/

                Networking item = new Networking( title, country,  expiration_time, description, creator, image,  response_user, comment);

                userNetworkings.add(item);
            }
            connection.close();

        }
        catch (SQLException ex){
            System.out.println("ERROR: " + ex.getMessage());
            return null;
        }

        return userNetworkings;
    }

    public void insertCommunication(Networking item){

        try {

            Connection connection = factory.getConnection();

            if (item.getImage().equals(""))
                item.setImage(null);

            PreparedStatement statement;


            statement= DAOUtil.prepareStatement(connection, SQL_ADD_NEW_NETWORKING, true, item.getName(),
                    item.getCountry(),  item.getEnds(), item.getDescription(),
                    item.getCreator(), item.getComment(), item.getImage());

            if (statement.executeUpdate() == 0)
                throw new RuntimeException("Creating Communication failed, no rows affected.");


            ResultSet rs = statement.getGeneratedKeys();
            //rs.next();
            //int id = rs.getInt(1);


            connection.close();
           // return id;
        }
        catch (SQLException ex){
            throw new RuntimeException("ERROR: " + ex.getMessage());
        }
    }



    public Networking getNetworkingByTitle(String title){
        try {
            Connection connection = factory.getConnection();
            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_GET_NETWORKING, false, title);
            ResultSet result = statement.executeQuery();
            User_does_NetworkingDAO bdao = new User_does_NetworkingDAO(true);

            if(result.next()){


                Networking item = new Networking( result.getString("Name"), result.getString("Country"), result.getTimestamp("Expiration_time"), result.getString("Description"), result.getString("Creator"),
                         result.getString("Image"),  result.getString("response_user"),result.getString("Comment") );


                connection.close();
                return item;

            }
            else{
                connection.close();
                return null;
            }

        }
        catch (SQLException e){
            System.err.println(e.getMessage());
            return null;
        }

    }


    /*public void updateRecommendedItems(){

        try {

            Connection connection = factory.getConnection();

            PreparedStatement statement = DAOUtil.prepareStatement(connection, SQL_GET_ALL_USERNAMES, false);
            ResultSet rs = statement.executeQuery();

            while(rs.next()) {

                List<User> neighbors = new ArrayList<US>();
                Map<Integer, Integer> items_unranked = new HashMap<Integer, Integer>();
                List<RecommendedItem> items_ranked = new ArrayList<RecommendedItem>();


                //get usernames of neighbors ordered by correlation
                statement = DAOUtil.prepareStatement(connection, SQL_GET_NEIGHBORS, false, rs.getString(1));
                ResultSet results = statement.executeQuery();


                //get them on the list
                while (results.next())
                    neighbors.add(new UserCorrelation(results.getString(1), results.getInt(2)));

                //get the items they have bid for, but user have not
                for (int i = 0; i < neighbors.size(); i++) {
                    statement = DAOUtil.prepareStatement(connection, SQL_GET_NEIGHBORHOOD_NETWORKINGS, false, neighbors.get(i).getUsername(), rs.getString(1));
                    results = statement.executeQuery();

                    //add all the items in a list
                    while (results.next()) {
                        if (!items_unranked.containsKey(results.getInt(1)))
                            items_unranked.put(results.getInt(1), neighbors.get(i).getCorrelation());
                        else
                            items_unranked.put(results.getInt(1), neighbors.get(i).getCorrelation() + items_unranked.get(results.getInt(1)));
                    }
                }

                for (Map.Entry<Integer, Integer> entry : items_unranked.entrySet()) {
                    items_ranked.add(new RecommendedItem(entry.getKey(), entry.getValue()));
                }

                //sort list based on rank
                Collections.sort(items_ranked, RecommendedItem.DESC_COMPARATOR);

                //recommended items per user should be 10 or less
                int max_rec = MAX_REC_ITEMS_PER_USER;
                if(items_ranked.size() < MAX_REC_ITEMS_PER_USER)
                    max_rec = items_ranked.size();

                //insert or update rec table
                for(int i=0; i < max_rec; i++) {
                    statement = DAOUtil.prepareStatement(connection, SQL_UPDATE_RECOMMENDATIONS, false, rs.getString(1), i, items_ranked.get(i).getId(), items_ranked.get(i).getId());
                    statement.executeUpdate();
                }

                statement = DAOUtil.prepareStatement(connection, SQL_DELETE_EXTRA_REC_ITEMS, false, rs.getString(1), max_rec);
                statement.executeUpdate();

            }

            connection.close();

        }
        catch (SQLException ex){
            System.err.println("ERROR: " + ex.getMessage());
            throw new RuntimeException("Error at updateRecommendedItems");
        }

    }*/
}
