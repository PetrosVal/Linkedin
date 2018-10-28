package support;

import dao.NetworkingDAO;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.security.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;


@WebListener()
public class Listener implements ServletContextListener,
        HttpSessionListener, HttpSessionAttributeListener {

    public Listener() {}

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      /* This method is called when the servlet context is
         initialized(when the Web application is deployed).
         You can initialize servlet context related data here.
      */
        NetworkingDAO dao = new NetworkingDAO(true);

        //run once when server starts
        /*dao.updateExpiredItems();*/

        //and then every minute update of expired items
        TimerTask task = new TimerTask() {
            @Override
            public void run () {
                /*new NetworkingDAO(true).updateExpiredItems();*/
            }
        };
        Timer timer = new Timer();
        Calendar calendar = Calendar.getInstance();
        int sec = calendar.get(Calendar.SECOND);
        timer.scheduleAtFixedRate (task, 1000*(60 - sec), 1000*60);


        //run once when server starts
       /* dao.updateRecommendedItems();*/

        //and then every hour update of recommended items for every user
        TimerTask task2 = new TimerTask() {
            @Override
            public void run () {
                /*new NetworkingDAO(true).updateRecommendedItems();*/
            }
        };
        Timer timer2 = new Timer();
        timer2.scheduleAtFixedRate(task2, 1000*60*60, 1000*60*60);


    }

    public void contextDestroyed(ServletContextEvent sce) {}

    // -------------------------------------------------------
    // HttpSessionListener implementation
    // -------------------------------------------------------
    public void sessionCreated(HttpSessionEvent se) {}

    public void sessionDestroyed(HttpSessionEvent se) {}

    // -------------------------------------------------------
    // HttpSessionAttributeListener implementation
    // -------------------------------------------------------
    public void attributeAdded(HttpSessionBindingEvent sbe) {}

    public void attributeRemoved(HttpSessionBindingEvent sbe) {}

    public void attributeReplaced(HttpSessionBindingEvent sbe) {}
}






