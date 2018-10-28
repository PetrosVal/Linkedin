package servlets;


import dao.NetworkingDAO;
import entities.AppEntities.Networking;
import entities.AppEntities.User;
import support.ImageValidator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.*;
import java.util.Date;


@WebServlet("/Create")
@MultipartConfig()
public class create extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("error_page.jsp");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Set request encoding to UTF-8
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // in case you are not logged in
        if (user == null ) {
            response.sendRedirect("error_page.jsp");
            return;
        }
        String title = "";
        String country = "";
        String date = "";
        String image = "";
        String comment = "";
        String description = "";
        String creator = "";


        for(Part part : request.getParts()) {

            String name = part.getName();
            if (name != null) {
                if (name.equals("title")) {
                    title = getValue(part);
                } else if (name.equals("country")) {
                    country = getValue(part);
                } else if (name.equals("creator")) {
                    creator = getValue(part);
                } else if (name.equals("comment")) {
                    comment = getValue(part);
                } else if (name.equals("date")) {
                    date = getValue(part);
                } else if (name.equals("desc")) {
                    description = getValue(part);
                } else if(name.equals("image")) {
                    image = part.getSubmittedFileName();

                    // No image submitted
                    if (image.equals("")) {
                        System.out.println("No Image Submitted");
                        continue;
                    }
                    // Validate Image format (png/jpg/bmp/gif allowed)
                    ImageValidator validator = new ImageValidator();
                    boolean validation = validator.validate(image);

                    // If the format is not one of the above ~> Error
                    if (!validation){
                        request.setAttribute("item-creation-error","Η επιλεγμένη εικόνα πρέπει να είναι της μορφής png/jpg/bmp/gif");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("new_communication.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }

                    // Upload File
                    try{
                        InputStream is = request.getPart(part.getName()).getInputStream();

                        int size = is.available();

                        //Allow file of size 50KB
                        //       if(size > 50*1024){
                        //        out.println("Your resume is not uploaded.File size should be less than 50KB");
                        //        return;
                        //       }

                        byte[] b = new byte[size];
                        is.read(b);

                        // Creates "files" folder in tomcat/bin folder
                        File files_dir = new File("files");

                        if (!files_dir.exists())
                            files_dir.mkdirs();

                        if(image != null && !image.equals("")){

                            File uniqueFile = File.createTempFile("img", ".png", files_dir);

                            System.out.println("Submitted Img name: " + image);
                            System.out.println("Generated Img name: " + uniqueFile.getName());

                            image = uniqueFile.getName();

                            FileOutputStream os = new FileOutputStream(uniqueFile);
                            os.write(b);
                            os.flush();
                            os.close();
                            System.out.println("Your resume is uploaded successfully");
                        }
                        is.close();

                    }catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
        Date datetime;
        try {
            datetime = sdf.parse(date);
        }
        catch (ParseException ex){
            request.setAttribute("item-creation-error","Κάτι πήγε στραβά με την ημερομηνία που συμπληρώσατε! Προσπαθήστε ξανά!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("new_communication.jsp");
            dispatcher.forward(request, response);
            return;
        }
        Networking item = new Networking( title, country,
                datetime, description, creator , image, null, comment);

        NetworkingDAO dao = new NetworkingDAO(true);

        dao.insertCommunication(item);

        request.setAttribute("auction-creation-success","yes");
        RequestDispatcher dispatcher = request.getRequestDispatcher("my_communications.jsp");
        dispatcher.forward(request, response);
    }

    //Get the Value of the Form field other than type form field type file
    private String getValue(Part part) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
        StringBuilder value = new StringBuilder();
        char[] buffer = new char[1024];
        for (int length = 0; (length = reader.read(buffer)) > 0;) {
            value.append(buffer, 0, length);
        }
        return value.toString();
    }

}
