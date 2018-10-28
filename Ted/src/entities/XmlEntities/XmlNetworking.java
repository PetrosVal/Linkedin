package entities.XmlEntities;

import javax.xml.bind.annotation.*;

@XmlType(propOrder = {"name", "description", "country", "creator", "comment"})
@XmlRootElement( name = "Networking" )
public class XmlNetworking {

    private String name;
    private String description;
    private String country;
    private  String  creator;
    private String comment;

    public String getName() {
        return name;
    }

    @XmlElement(name="Name")
    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }
    @XmlElement(name="Description")
    public void setDescription(String description) {
        this.description = description;
    }

    public String getCountry() {
        return country;
    }
    @XmlElement(name="Country")
    public void setCountry(String country) {
        this.country = country;
    }

    public String getCreator() {
        return creator;
    }
    @XmlElement(name="Creator")
    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getComment() {
        return comment;
    }
    @XmlElement(name="Comment")
    public void setComment(String comment) {
        this.comment = comment;
    }
}
