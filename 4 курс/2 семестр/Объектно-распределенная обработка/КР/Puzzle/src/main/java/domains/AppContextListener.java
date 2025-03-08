package domains;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import utils.DatabaseUtil;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DatabaseUtil.initializeDatabase();
        System.out.println("База данных инициализирована при старте приложения.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Здесь можно закрыть соединения или выполнить другие действия при остановке приложения
    }
}
