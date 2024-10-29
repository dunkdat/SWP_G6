package util; // Update with the correct package

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("current_user") : null;
        String path = httpRequest.getServletPath();

        // Role-based restrictions
        if (user != null) {
            switch (user.getRole()) {
                case "Customer":
                    if (isRestrictedForCustomer(path)) {
                        httpResponse.sendRedirect(httpRequest.getContextPath() + "/unauthorized.jsp");
                        return;
                    }
                    break;
                case "Staff":
                    if (isRestrictedForStaff(path)) {
                        httpResponse.sendRedirect(httpRequest.getContextPath() + "/unauthorized.jsp");
                        return;
                    }
                    break;
                case "Admin":
                    if (isRestrictedForAdmin(path)) {
                        httpResponse.sendRedirect(httpRequest.getContextPath() + "/unauthorized.jsp");
                        return;
                    }
                    break;
                case "Staff Manager":
                    if (isRestrictedForManager(path)) {
                        httpResponse.sendRedirect(httpRequest.getContextPath() + "/unauthorized.jsp");
                        return;
                    }
                    break;
            }
        } else {
            if (isRestrictedForGuest(path)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/unauthorized.jsp");
                return;
            }
        }

        // Proceed to the next filter or the target resource
        chain.doFilter(request, response);
    }

    private boolean isRestrictedForGuest(String path) {
        return path.equals("/userlist") || path.equals("/userdetail") || path.equals("/onsale")
                || path.equals("/settinglist") || path.equals("/settingdetail") || path.equals("/CustomerManager") || path.equals("/orderManagerServlet")
                || path.equals("/staffproductlist") || path.equals("/staffproductdetail") || path.equals("/rolelist") || path.startsWith("/dashboard");
    }

    private boolean isRestrictedForCustomer(String path) {
        return path.equals("/userlist") || path.equals("/userdetail") || path.equals("/onsale")
                || path.equals("/settinglist") || path.equals("/settingdetail") || path.equals("/CustomerManager") || path.equals("/orderManagerServlet")
                || path.equals("/staffproductlist") || path.equals("/staffproductdetail") || path.equals("/rolelist") || path.startsWith("/dashboard");
    }

    private boolean isRestrictedForStaff(String path) {
        return path.equals("/userlist") || path.equals("/userdetail") || path.equals("/CustomerManager") || path.equals("/orderManagerServlet")
                || path.equals("/settinglist") || path.equals("/settingdetail") || path.equals("/rolelist");
    }

    private boolean isRestrictedForAdmin(String path) {
        return path.equals("/staffproductlist") || path.equals("/staffproductdetail") || path.equals("/CustomerManager") || path.equals("/orderManagerServlet")
                || path.equals("/onsale");
    }

    private boolean isRestrictedForManager(String path) {
        return path.equals("/staffproductlist") || path.equals("/staffproductdetail") || path.equals("/settinglist") || path.equals("/userlist") || path.equals("/userdetail")
                || path.equals("/settingdetail") || path.equals("/rolelist")
                || path.equals("/onsale");
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
