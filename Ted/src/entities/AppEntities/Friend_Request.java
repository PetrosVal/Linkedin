package entities.AppEntities;

import java.util.Date;

public class Friend_Request {

    private String request_from;
    private String request_to;
    private Integer is_accepted;

    public Friend_Request( String request_from, String request_to, Integer is_accepted) {
        this.request_from = request_from;
        this.request_to=request_to;
        this.is_accepted=is_accepted;
    }


    public String getRequest_from() {
        return request_from;
    }

    public void setRequest_from(String sender_id) {
        this.request_from = sender_id;
    }

    public String getRequest_to() {
        return request_to;
    }

    public void setRequest_to(String receiver_id) {
        this.request_to = receiver_id;
    }

    public Integer getIs_accepted() {
        return is_accepted;
    }

    public void setIs_accepted(Integer is_read) {
        this.is_accepted = is_read;
    }

}
