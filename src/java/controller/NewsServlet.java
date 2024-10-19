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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.News;
import model.NewsGroup;
//import org.json.JSONObject;

/**
 *
 * @author ADMIN
 */
public class NewsServlet extends HttpServlet {

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
            out.println("<title>Servlet NewsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewsServlet at " + request.getContextPath() + "</h1>");
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
        DAONews dao = new DAONews();
        DAONewsGroup DAO = new DAONewsGroup();
        String service = request.getParameter("Service");
        if (service == null) {
            service = "getAll";
        }

        String groupId_raw = request.getParameter("GroupId");
        String indexPage_raw = request.getParameter("index");

        int indexPage = 0;
        if (indexPage_raw != null) {
            indexPage = Integer.parseInt(indexPage_raw);
        }
        if (groupId_raw != null && !groupId_raw.equals("")) {
            service = "getByGroup";
        }

        if (service.equals("getAll")) {
            Vector<News> listnews = dao.getAllNews(indexPage);
            int hasNext = (dao.getAllNews(indexPage + IConstant.NUMBER_PER_PAGE)).size();
            request.setAttribute("hasNext", hasNext > 0);
            if (indexPage_raw != null) {

            } else {
                Vector<NewsGroup> listnewsgroup = DAO.getAllNewsGroup();
                Vector<News> topNews = dao.getTopNews();
                request.setAttribute("topNews", topNews);
                request.setAttribute("listnews", listnews);
                request.setAttribute("listnewsgroup", listnewsgroup);
                request.getRequestDispatcher("news.jsp").forward(request, response);
            }
        }
        if (service.equals("NewsDetail")) {
            String nid_raw = request.getParameter("Nid");
            int nid = Integer.parseInt(nid_raw);

            int page = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
            int pageSize = 10;

            News currentN = dao.getNewsById(nid);
            int totalNewsByAdmin = dao.getTotalNewsByAdmin(currentN.getCreateBy());
            request.setAttribute("totalNewsByAdmin", totalNewsByAdmin);
            
            dao.updateNewsCount(nid);
            Vector<News> newRelation = dao.getAllNewsByGroupId(currentN.getNewsGroupId(), indexPage);
            request.setAttribute("currentNews", currentN);
            request.setAttribute("newRelation", newRelation);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("currentPage", page);
//            request.setAttribute("totalPages", dao_comment.getTotalPage(0, "CommentsNewsDetail", pageSize, nid));
            request.setAttribute("Nid", nid);

            request.getRequestDispatcher("newsDetail.jsp").forward(request, response);
        }
        if (service.equals("getByGroup")) {
            int groupId = Integer.parseInt(groupId_raw);
            Vector<News> listnews = dao.getAllNewsByGroupId(groupId, indexPage);
            int hasNext = (dao.getAllNewsByGroupId(groupId, indexPage + IConstant.NUMBER_PER_PAGE)).size();
            request.setAttribute("hasNext", hasNext > 0);
            if (indexPage_raw != null) {
//                JSONObject jsonResponse = new JSONObject();
//                try {
//                    jsonResponse.put("newsResponse", getNewsResponse(listnews));
//                    jsonResponse.put("hasNext", hasNext);
//                    response.getWriter().write(jsonResponse.toString());
//                } catch (Exception e) {
//                    System.out.println(e);
//                }
            } else {
                request.setAttribute("listnews", listnews);
                Vector<NewsGroup> listnewsgroup = DAO.getAllNewsGroup();

                Vector<News> topNews = dao.getTop5NewsByViewsAndGroupId(groupId);

                request.setAttribute("topNews", topNews);
                request.setAttribute("listnewsgroup", listnewsgroup);
                request.setAttribute("chooseGroup", groupId_raw);
                request.getRequestDispatcher("news.jsp").forward(request, response);
            }
        }
        if (service.equals("search")) {
            String textSearch = request.getParameter("Keyword");
            Vector<News> listnews = dao.getNewsByTittle(textSearch);
            Vector<NewsGroup> listnewsgroup = DAO.getAllNewsGroup();
            request.setAttribute("listnewsgroup", listnewsgroup);
            request.setAttribute("listnews", listnews);
            request.getRequestDispatcher("news.jsp").forward(request, response);
        }
        if (service.equals("getTopNews")) {
            Vector<News> topNews = dao.getTopNews();
            request.setAttribute("topNews", topNews);
            request.getRequestDispatcher("news.jsp").forward(request, response);
        }
    }

    public String getNewsResponse(Vector<News> listnews) {
        String html = "<div class=\"col-9\">\n"
                + "<div class=\"news-col news-main\">\n"
                + "<div class=\"\"></div>\n"
                + "<div class=\"news_card\">\n"
                + "<div class=\"pading_news\">\n";

        for (News news : listnews) {
            html += "<div class=\"news_item\">\n"
                    + "                            <div class=\"row h-100\">\n"
                    + "                                <div class=\"col-3 h-100\">\n"
                    + "                                    <a href=\"NewsServlet?Service=NewsDetail&Nid=" + news.getNewsId() + "\" style=\"display: block; height: 100%;\">\n"
                    + "                                        <img style=\"width: 100%;\n"
                    + "                                             height: 100%;\n"
                    + "                                             object-fit: cover;\" src=\"" + IConstant.PATH_NEWS + "/" + news.getImagePath() + "\" \n"
                    + "                                             alt=\"\">\n"
                    + "                                    </a>\n"
                    + "                                </div>\n"
                    + "                                <div class=\"col-9 h-100\">\n"
                    + "                                    <div class=\"\">\n"
                    + "                                        <a href=\"NewsServlet?Service=getByGroup&GroupId=" + news.getNewsGroupId() + "\">" + news.getNewsGroupName() + "</a>\n"
                    + "                                        <h3 class=\"fw-bold fs-2\"> \n"
                    + "                                            <a class=\"text-black\" href=\"NewsServlet?Service=NewsDetail&Nid=" + news.getNewsId() + "\">\n"
                    + "                                                " + news.getNewsTitle() + " \n"
                    + "                                            </a>\n"
                    + "                                        </h3>\n"
                    + "                                        <p class=\"fs-5\" style=\"overflow: hidden;\n"
                    + "                                           display: -webkit-box;\n"
                    + "                                           -webkit-line-clamp: 2; /* number of lines to show */\n"
                    + "                                           line-clamp: 2;\n"
                    + "                                           -webkit-box-orient: vertical;\">" + news.getShortContent() + "</p>\n"
                    + "                                        <div class=\"h-100\">\n"
                    + "                                            <div class=\"d-flex align-items-center flex-1\">\n"
                    + "                                                <div class=\"me-3\">\n"
                    + "                                                    <img src=\"https://images.fpt.shop/unsafe/30x30/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/10/6/638321553859906264_2.jpg\"\n"
                    + "                                                         alt=\"\" style=\"width: 30px; height: 30px; border-radius: 50%;\">\n"
                    + "                                                </div>\n"
                    + "                                                <div class=\"me-3\">\n"
                    + "                                                    <span>" + news.getAdminName() + "</span>\n"
                    + "                                                    <span>-</span>\n"
                    + "                                                    <span>\n"
                    + "                                                        " + news.getTimeDifferenceInDays() + " ngày trước " + "\n"
                    + "                                                    </span>\n"
                    + "                                                </div>\n"
                    + "                                            </div>\n"
                    + "                                        </div>\n"
                    + "                                    </div>\n"
                    + "                                </div>\n"
                    + "                             </div>\n"
                    + "                          </div>\n";
        }

        html += "</div>\n"
                + "</div>\n"
                + "</div>\n"
                + "</div>\n";
        return html;
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

    }
}
