package filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controllers.UserSessionBean;



@WebFilter(urlPatterns = "/faces/protected/*") // Укажите защищенные URL
public class AuthFilter implements Filter {
	private static final long serialVersionUID = 1L;
	
	@Override
    public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("Инициализируем филтр!");
    }
	
	 @Override
	    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	            throws IOException, ServletException {
	        
	        HttpServletRequest httpRequest = (HttpServletRequest) request;
	        HttpServletResponse httpResponse = (HttpServletResponse) response;
	        HttpSession session = httpRequest.getSession(false);

	        // Проверьте, авторизован ли пользователь
	        if (session != null && session.getAttribute("userSession") != null) {
	            UserSessionBean userSession = (UserSessionBean) session.getAttribute("userSession");
	            if (userSession.isLoggedIn()) {
	                // Пользователь авторизован, продолжайте
	                chain.doFilter(request, response);
	                return;
	            }
	        }

	        // Пользователь не авторизован, перенаправляем на страницу логина
	        System.out.println(httpRequest.getContextPath() + "/faces/pages/login.xhtml");
	        httpResponse.sendRedirect(httpRequest.getContextPath() + "/faces/pages/login.xhtml");
	    }
}
