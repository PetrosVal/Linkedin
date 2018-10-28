package entities.AppEntities;

import java.util.Date;

public class Like {

    private Integer id;
    private String userLikeId;
    private Integer networkingLikeId;
    private Date    likeTime;


    public Like (Integer id, String userLikeId,
                  Integer networkingLikeId,Date likeTime) {


        this.id = id;
        this.userLikeId = userLikeId;
        this.networkingLikeId = networkingLikeId;
        this.likeTime = likeTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserLikeId() {
        return userLikeId;
    }

    public void setUserLikeId(String userLikeId) {
        this.userLikeId = userLikeId;
    }

    public Integer getNetworkingId() {
        return networkingLikeId;
    }

    public void setNetworkingLikeId(Integer networkingLikeId) {
        this.networkingLikeId = networkingLikeId;
    }

    public Date getLikeTime() {
        return likeTime;
    }

    public void setLikeTime(Date likeTime) {
        this.likeTime = likeTime;
    }


}
