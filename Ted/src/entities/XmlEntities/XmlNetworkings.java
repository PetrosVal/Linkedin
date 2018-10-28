package entities.XmlEntities;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;


@XmlRootElement( name = "Aggelies" )
public class XmlNetworkings {

    private List<XmlNetworking> aggelies;


    public List<XmlNetworking> getAggelies() {
        return aggelies;
    }

    @XmlElement( name = "Aggelies" )
    public void setAggelies(List<XmlNetworking> aggelies) {
        this.aggelies = aggelies;
    }
}
