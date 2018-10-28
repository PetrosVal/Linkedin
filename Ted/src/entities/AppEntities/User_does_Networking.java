package entities.AppEntities;

import java.util.Date;

public class User_does_Networking {

    private Integer networkingID;
    private Integer userID;
    private String username;
    private String email;
    private Date time;

    public User_does_Networking(Integer networkingID, Integer userID, String username, String email, Date time) {
        this.networkingID = networkingID;
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.time = time;
    }

    public Integer getCommunicationID() {
        return networkingID;
    }

    public void setCommunicationID(Integer CommunicationID) {
        this.networkingID = CommunicationID;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer UserID) {
        this.networkingID = UserID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

}
