/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import constant.IConstant;
import dal.DAONews;
import dal.DAONewsGroup;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import static java.lang.System.out;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.time.LocalDate;
import model.News;
import model.NewsGroup;
import util.Validate;

/**
 *
 * @author ADMIN
 */
@MultipartConfig
public class NewsManagerServlet extends HttpServlet {

    DAONews dao = new DAONews();
    DAONewsGroup DAO = new DAONewsGroup();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewsManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewsManagerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String service = request.getParameter("Service");
        if (service == null) {
            service = "getAll";
        }

        int indexPage = (request.getParameter("indexPage") != null)
                ? Integer.parseInt(request.getParameter("indexPage")) : 1;

        if (service.equals("getAll")) {
            Vector<News> listnews = dao.getAllNewsPagination(indexPage, IConstant.NUMBER_PER_PAGE);
            request.setAttribute("listnews", listnews);
            Vector<NewsGroup> listnewsgroup = DAO.getAllNewsGroup();
            request.setAttribute("listnewsgroup", listnewsgroup);

            int totalNewsCount = dao.getTotalNews();
            int totalPages = (int) Math.ceil((double) totalNewsCount / IConstant.NUMBER_PER_PAGE);

            request.setAttribute("currentPage", indexPage);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("newsManage.jsp").forward(request, response);
        }
        if (service.equals("newsAuthor")) {
            String author_raw = request.getParameter("aid");
            int aid = Integer.parseInt(author_raw);
            Vector<News> listnews = dao.getNewsByAdmin(aid, indexPage, IConstant.NUMBER_PER_PAGE);
            Vector<News> top5news = dao.getTop5NewsByViewsAndAdminId(aid);
            request.setAttribute("top5news", top5news);
            
            int totalNewsByAdmin = dao.getTotalNewsByAdmin(aid);
            int totalPages = (int) Math.ceil((double) totalNewsByAdmin / IConstant.NUMBER_PER_PAGE);
            
            request.setAttribute("listnews", listnews);
            request.setAttribute("totalNewsByAdmin", totalNewsByAdmin);
            request.setAttribute("currentPage", indexPage);
            request.setAttribute("totalPages", totalPages);
            
            request.getRequestDispatcher("newsAuthor.jsp").forward(request, response);
        }

        if (service.equals("getByGroup")) {
            String groupId_raw = request.getParameter("GroupId");
            int groupId = Integer.parseInt(groupId_raw);
            Vector<News> listnews = dao.getAllNewsByGroupId1(groupId);
            request.setAttribute("listnews", listnews);
            Vector<NewsGroup> listnewsgroup = DAO.getAllNewsGroup();
            request.setAttribute("listnewsgroup", listnewsgroup);
            request.setAttribute("chooseGroup", groupId_raw);
            request.getRequestDispatcher("newsManage.jsp").forward(request, response);
        }

        if (service.equals("delete")) {
            String nid_raw = request.getParameter("newsId");
            boolean hasDelete = dao.deleteNews(Integer.parseInt(nid_raw));
            if (hasDelete) {
                out.println();
            }
        }
        if (service.equals("filterNews")) {
            String startDate = request.getParameter("order-date_start");
            String endDate = request.getParameter("order-date_end");
            String newsType = request.getParameter("news_type");
            String keyWord = request.getParameter("keyword");
            String orderDate = request.getParameter("order-date");

            if (orderDate != null) {
                request.setAttribute("orderDate", orderDate);
            }

            if (startDate != null) {
                request.setAttribute("startDate", startDate);
            }

            if (endDate != null) {
                request.setAttribute("endDate", endDate);
            }

            if (newsType != null) {
                request.setAttribute("newsType", newsType);
            }

            if (keyWord != null) {
                request.setAttribute("keyWord", keyWord);
            }

            Vector<News> listnews = dao.getNewsFilter(startDate, endDate, newsType, keyWord, orderDate);

            request.setAttribute("listnews", listnews);
            Vector<NewsGroup> listnewsgroup = DAO.getAllNewsGroup();
            request.setAttribute("listnewsgroup", listnewsgroup);
            request.getRequestDispatcher("newsManage.jsp").forward(request, response);
        }
        if (service.equals("addNews")) {
            request.setAttribute("listnewsgroup", DAO.getAllNewsGroup());
            request.getRequestDispatcher("newsInsert.jsp").forward(request, response);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    private void saveImage(Part part, String folderPath, String filename) throws IOException {
        File folder = new File(folderPath);
        if (!folder.exists()) {
            folder.mkdirs();
        }
        String filePath = folderPath + File.separator + filename;
        try ( InputStream inputStream = part.getInputStream()) {
            Path path = Paths.get(filePath);
            Files.copy(inputStream, path, StandardCopyOption.REPLACE_EXISTING);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static void main(String[] args) {
        DAONews dao = new DAONews();
        System.out.println(dao.getAllNewsPagination(2, 4));
    }
}
