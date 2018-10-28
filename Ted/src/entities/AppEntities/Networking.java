package entities.AppEntities;

import java.util.Date;
import java.util.List;



public class Networking {

    private String name;
    private String country;
    private Date ends;
    private String creator;
    private String response_user;
    private String comment;
    private String description;
    private String image;

    //private List<User_does_Networking> communications;


    public Networking( String name, String country,  Date ends, String description,
                String creator,  String images, String response_user,String comment) {

        this.name = name;
        this.country = country;
        this.description = description;
        this.ends = ends;
        this.creator = creator;
        this.comment = comment;
        this.response_user = response_user;
        this.image = images;
        //this.communications = communications;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }


    public Date getEnds() {
        return ends;
    }

    public void setEnds(Date ends) {
        this.ends = ends;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getResponse_user() {
        return response_user;
    }

    public void setResponse_user(String response_user) {
        this.response_user = response_user;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }



}
