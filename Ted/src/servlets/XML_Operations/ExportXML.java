package servlets.XML_Operations;


import dao.Friend_RequestDAO;
import dao.NetworkingDAO;
import dao.Personal_InformationDAO;
import dao.UserDAO;
import entities.AppEntities.Networking;
import entities.AppEntities.Personal_Information;
import entities.AppEntities.User;
import entities.XmlEntities.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/ExportXML")
public class ExportXML extends HttpServlet{

    protected void hdoGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("error_page.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Error handling
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.getRole() != 0) {
            response.sendRedirect("error_page.jsp");
            return;
        }
        String item_id = request.getParameter("export");

        NetworkingDAO dao = new NetworkingDAO(true);
        UserDAO udao = new UserDAO(true);
        Personal_InformationDAO pdao = new Personal_InformationDAO(true);


        Personal_Information  p_info = pdao.getPersonalInformationbyName(item_id);
        List <Networking>  list_net = dao.getUserNetworkings(item_id);

       // XmlNetworking networking = new XmlNetworking();
       // XmlLinkedin linkedin = new XmlLinkedin();

        XmlCv cv = new XmlCv();
       // linkedin.setCV(cv);

        cv.setSchool(p_info.getSchool());
        cv.setSkills(p_info.getSkills());
        cv.setUniversity(p_info.getUniversity());
        cv.setWork_experience(p_info.getWork_Experience());
        cv.setUser_info(p_info.getUser_info());

       // XmlNetworkings networkings = new XmlNetworkings();
       // linkedin.setAggelies(networkings);

       // networkings.setAggelies(new ArrayList<XmlNetworking>());

       /* for(int i=0;i<list_net.size();i++){

            XmlNetworking xmlnetworking = new XmlNetworking();
            networkings.getAggelies().add(xmlnetworking);

            xmlnetworking.setName(list_net.get(i).getName());
            xmlnetworking.setCountry(list_net.get(i).getCountry());
            xmlnetworking.setComment(list_net.get(i).getComment());
            xmlnetworking.setDescription(list_net.get(i).getDescription());
            xmlnetworking.setCreator(list_net.get(i).getCreator());

        }*/

        try {
            JAXBContext jaxbContext = null;
            Marshaller marshaller = null;
            jaxbContext = JAXBContext.newInstance( XmlCv.class);
            System.out.print("okokoookokokokook\n");
             marshaller = jaxbContext.createMarshaller();
            System.out.print("okokoookokokokook\n");
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

            response.setContentType("text/xml");
            response.setHeader("Content-disposition","attachment; filename=User-" + item_id + ".xml");
            OutputStream out = response.getOutputStream();
            marshaller.marshal(cv, out);
            out.flush();
        }
        catch (JAXBException ex){
            System.err.println("ERROR on ExportXML: " + ex.getMessage());
        }
    }
}
