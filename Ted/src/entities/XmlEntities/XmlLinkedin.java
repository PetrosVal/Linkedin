package entities.XmlEntities;

import javax.xml.bind.annotation.*;
import java.util.List;


@XmlType(propOrder = {"aggelies", "CV"})

@XmlRootElement( name = "Linkedin" )
public class XmlLinkedin {

    private XmlNetworkings aggelies;
    private  XmlCv CV;

    @XmlElement(name = "aggelies")
    public XmlNetworkings getAggelies() {
        return aggelies;
    }
    public void setAggelies(XmlNetworkings aggelies) {
        this.aggelies = aggelies;
    }

    @XmlElement(name = "Cv")
    public XmlCv getCV() {
        return CV;
    }
    public void setCV(XmlCv cv) {
        this.CV = cv;
    }

}


