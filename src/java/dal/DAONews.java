/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import constant.IConstant;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import model.User;
import model.News;

/**
 *
 * @author ADMIN
 */
public class DAONews extends DBContext {


    public Vector<News> getAllNews(int indexPage) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.id as userId,"
                + " Users.name as userName, Users.imagePath as avatar, NewsGroup.newsGroupName, News.newsGroupId,"
                + " News.createDate , News.imagePath, "
                + " News.modifiedDate, News.createBy, News.modifiedBy "
                + " FROM News"
                + " JOIN NewsGroup ON NewsGroup.id = News.newsGroupId "
                + " JOIN Users ON Users.id = News.createBy"
                + " ORDER BY id"
                + " LIMIT ? OFFSET ?";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(2, indexPage);
            st.setInt(1, IConstant.NUMBER_PER_PAGE);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User admin = new User(
                        rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("avatar")
                );

                // Calculate time difference in seconds
                long currentTimeMillis = System.currentTimeMillis();
                long createDateMillis = rs.getDate("createDate").getTime();
                long timeDifferenceInMillis = currentTimeMillis - createDateMillis;
                long timeDifferenceInDays = timeDifferenceInMillis / (1000 * 60 * 60 * 24);

                News news = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath"),
                        admin
                );

                // Set the calculated time difference
                news.setTimeDifferenceInDays(timeDifferenceInDays);

                list.add(news);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<News> getAllNews1() {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent,"
                + " Users.name as userName,NewsGroup.newsGroupName, News.newsGroupId,"
                + " News.createDate , News.imagePath, "
                + " News.modifiedDate, News.createBy, News.modifiedBy "
                + " FROM News"
                + " JOIN NewsGroup ON NewsGroup.id = News.newsGroupId "
                + " JOIN Users ON Users.id= News.createBy"
                + " ORDER BY id";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News news = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(news);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<News> getAllNewsPagination(int indexPage, int itemsPerPage) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.userId,"
                + " Users.name as userName, NewsGroup.newsGroupName, News.newsGroupId,"
                + " News.createDate, News.imagePath,"
                + " News.modifiedDate, News.createBy, News.modifiedBy"
                + " FROM News"
                + " JOIN NewsGroup ON NewsGroup.id = News.newsGroupId"
                + " JOIN Users ON Users.id= News.createBy"
                + " ORDER BY id"
                + " LIMIT ? OFFSET ?";
        Vector<News> list = new Vector<>();
        int offset = (indexPage - 1) * itemsPerPage;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(2, offset);
            st.setInt(1, IConstant.NUMBER_PER_PAGE);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User admin = new User(
                        rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("avatar")
                );

                News news = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath"),
                        admin
                );
                list.add(news);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public News getNewsById(int id) {
        String sql = "SELECT News.id, News.newsTitle,News.description, Users.id as userId, Users.imagePath as avatar,\n"
                + "News.shortContent,Users.name as userName,NewsGroup.newsGroupName, News.newsGroupId, News.createDate , News.createBy\n"
                + "FROM News JOIN NewsGroup ON NewsGroup.id = News.newsGroupId\n"
                + "JOIN Users ON Users.id= News.createBy where News.id = ?";
        News n = new News();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User admin = new User(
                        rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("avatar")
                );
                n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("description"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getInt("createby"),
                        admin
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return n;
    }

    public Vector<News> getAllNewsByGroupId(int groupId, int indexPage) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent,"
                + " Users.name as userName,Users.id as userId, Users.imagePath as avatar,NewsGroup.newsGroupName, News.newsGroupId,"
                + " News.createDate , News.imagePath,"
                + "News.modifiedDate, News.createBy, News.modifiedBy\n"
                + "FROM News\n"
                + "JOIN NewsGroup ON NewsGroup.id = News.newsGroupId\n"
                + "JOIN Users ON Users.id= News.createBy where News.newsGroupId = ?"
                + " order by News.id LIMIT ? OFFSET ?";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, groupId);
            st.setInt(3, indexPage);
            st.setInt(2, IConstant.NUMBER_PER_PAGE);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User admin = new User(
                        rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("avatar")
                );

                long currentTimeMillis = System.currentTimeMillis();
                long createDateMillis = rs.getDate("createDate").getTime();
                long timeDifferenceInMillis = currentTimeMillis - createDateMillis;
                long timeDifferenceInDays = timeDifferenceInMillis / (1000 * 60 * 60 * 24);

                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath"),
                        admin
                );

                n.setTimeDifferenceInDays(timeDifferenceInDays);

                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<News> getAllNewsByGroupId1(int id) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.name as userName,NewsGroup.newsGroupName, News.newsGroupId, News.createDate , News.imagePath, "
                + "News.modifiedDate, News.createBy, News.modifiedBy\n"
                + "FROM News\n"
                + "JOIN NewsGroup ON NewsGroup.id = News.newsGroupId\n"
                + "JOIN Users ON Users.id = News.createBy  where News.newsGroupId = ?";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<News> getNewsByGroupId(int id) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.name as userName,NewsGroup.newsGroupName, News.newsGroupId, News.createDate , News.imagePath, "
                + "News.modifiedDate, News.createBy, News.modifiedBy\n"
                + "FROM News\n"
                + "JOIN NewsGroup ON NewsGroup.id = News.newsGroupId\n"
                + "JOIN Users ON Users.id = News.createBy  where News.newsGroupId = ?";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<News> getNewsByTittle(String textSearch) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.name as userName,NewsGroup.newsGroupName, News.newsGroupId, News.createDate , News.imagePath, "
                + "News.modifiedDate, News.createBy, News.modifiedBy\n"
                + "FROM News\n"
                + "JOIN NewsGroup ON NewsGroup.id = News.newsGroupId\n"
                + "JOIN Users ON Users.id = News.createBy where News.newsTitle like N'%" + textSearch + "%' or NewsGroup.newsGroupName like N'%" + textSearch + "%'";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getTotalNews() {
        String sql = "SELECT COUNT(*) FROM News";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public Vector<News> pagination(int index) {
        Vector<News> list = new Vector<>();
        String sql = "SELECT * FROM News\n"
                + "ORDER BY id\n"
                + "LIMIT ? OFFSET ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(2, (index - 1) * IConstant.NUMBER_PER_PAGE);
            st.setInt(1, IConstant.NUMBER_PER_PAGE);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new News(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getDate(7),
                        rs.getDate(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getString(11)
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean addNews(String newsTitle, String description, String shortContent, int newsGroupId,
            String createDate, int createBy, String imagePath) {
        String sql = "INSERT INTO [dbo].[News]\n"
                + "           ([newsTitle]\n"
                + "           ,[shortContent]\n"
                + "           ,[description]\n"
                + "           ,[newsGroupId]\n"
                + "           ,[createDate]\n"
                + "           ,[createBy]\n"
                + "           ,[imagePath])\n"
                + "     VALUES(?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newsTitle);
            st.setString(2, shortContent);
            st.setString(3, description);
            st.setInt(4, newsGroupId);
            st.setString(5, createDate);
            st.setInt(6, createBy);
            st.setString(7, imagePath);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public Vector<News> getNewsByAdmin(int userId, int indexPage, int itemsPerPage) {
        String sql = "SELECT A.name as userName, N.id, N.newsTitle, N.shortContent, "
                + "N.createDate, N.modifiedDate, N.newsGroupId, N.createBy,N.modifiedBy, N.imagePath, "
                + "NG.id, NG.newsGroupName "
                + "FROM News N "
                + "INNER JOIN Users A ON N.createBy = A.id "
                + "INNER JOIN NewsGroup NG ON N.newsGroupId = NG.id "
                + "WHERE A.id = ?"
                + " ORDER BY N.id"
                + " LIMIT ? OFFSET ?";
        Vector<News> list = new Vector<>();
        int offset = (indexPage - 1) * itemsPerPage;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(3, offset);
            st.setInt(2, IConstant.NUMBER_PER_PAGE);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                long currentTimeMillis = System.currentTimeMillis();
                long createDateMillis = rs.getDate("createDate").getTime();
                long timeDifferenceInMillis = currentTimeMillis - createDateMillis;
                long timeDifferenceInDays = timeDifferenceInMillis / (1000 * 60 * 60 * 24);

                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(n);
                n.setTimeDifferenceInDays(timeDifferenceInDays);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean deleteNews(int nid) {
        String sql = "DELETE FROM News\n"
                + "WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, nid);
            return st.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public int getTotalNewsByAdmin(int userId) {
        String sql = "SELECT COUNT(N.id) FROM News N WHERE N.createBy = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId); // Set the admin ID
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int getTotalViews(int newsId) {
        String sql = "SELECT viewsCount FROM News N WHERE N.id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, newsId); 
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updateNewsCount(int newsId) {
        String sql = "UPDATE News\n"
                + "   SET \n"
                + "      viewsCount = ?\n"
                + " WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            
            st.setInt(1, getTotalViews(newsId)+1);
            st.setInt(2, newsId);
            return st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

  public Vector<News> getNewsFilter(String startDate, String endDate, String type, String keyWord, String orderByDate) {
    Vector<News> list = new Vector<>();
    try {
        String sql = "SELECT N.id, N.newsTitle, N.shortContent, Users.name as userName, NewsGroup.newsGroupName, N.newsGroupId, N.createDate, N.imagePath, "
                + "N.modifiedDate, N.createBy, N.modifiedBy "
                + "FROM News N "
                + "JOIN NewsGroup ON NewsGroup.id = N.newsGroupId "
                + "JOIN Users ON Users.id= N.createBy ";
        
        // Adding WHERE clause conditions
        if (keyWord != null && !keyWord.isEmpty()) {
            sql += "WHERE N.newsTitle LIKE '%" + keyWord + "%' ";
        }
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            sql += "AND N.createDate >= '" + startDate + "' AND N.createDate <= '" + endDate + "' ";
        } else if (startDate != null && !startDate.isEmpty()) {
            sql += "AND N.createDate >= '" + startDate + "' ";
        } else if (endDate != null && !endDate.isEmpty()) {
            sql += "AND N.createDate <= '" + endDate + "' ";
        }
        if (type != null && !type.equals(IConstant.ALL_TYPE)) {
            sql += "AND NewsGroup.newsGroupName = '" + type + "' ";
        }
        
        // Adding ORDER BY clause
        if (orderByDate != null && !orderByDate.isEmpty()) {
            if (orderByDate.equals(IConstant.DATE_ASC)) {
                sql += "ORDER BY N.createDate ASC ";
            } else if (orderByDate.equals(IConstant.DATE_DESC)) {
                sql += "ORDER BY N.createDate DESC ";
            }
        }
        
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            News n = new News(
                rs.getInt("id"),
                rs.getString("newsTitle"),
                rs.getString("shortContent"),
                rs.getString("userName"),
                rs.getInt("newsGroupId"),
                rs.getString("newsGroupName"),
                rs.getDate("createDate"),
                rs.getDate("modifiedDate"),
                rs.getInt("createBy"),
                rs.getInt("modifiedBy"),
                rs.getString("imagePath")
            );
            list.add(n);
        }
    } catch (SQLException e) {
        System.out.println(e);
    }
    return list;
}
    
    
    public String getNewsFilter1(String startDate, String endDate, String type,String keyWord , String orderByDate) {
        String sql = "SELECT N.id, N.newsTitle, N.shortContent, Users.name as userName,NewsGroup.newsGroupName, N.newsGroupId, N.createDate , N.imagePath, "
                + "N.modifiedDate, N.createBy, N.modifiedBy\n"
                + "FROM News N\n"
                + "JOIN NewsGroup ON NewsGroup.id = N.newsGroupId\n"
                + "JOIN Users ON Users.id= N.createBy";
        if (keyWord != null && keyWord != "") {
            sql += " and N.newsTitle like '%" + keyWord + "%'";
        }

        if ((startDate != null && startDate != "") && (endDate != null && endDate != "")) {
            sql += " and N.createDate >= '" + startDate + "' and N.createDate <= '" + endDate + "'";
        } else if (startDate != null && startDate != "") {
            sql += " and N.createDate >= '" + startDate + "'";
        } else if (endDate != null && endDate != "") {
            sql += " and N.createDate <= '" + endDate + "'";
        }
        
         if (type != null) {
            if(!type.equals(IConstant.ALL_TYPE)) {
             sql += " and NewsGroup.newsGroupName = '" + type + "'";
            }
        }
         
          if((orderByDate != null && !orderByDate.isEmpty())) {
            sql+="order by";
         if(orderByDate.equals(IConstant.DATE_ASC)) {
            sql += " N.createDate asc";
         }
         if(orderByDate.equals(IConstant.DATE_DESC)) {
            sql += " N.createDate desc";
         }
        }

        return sql;
    }

    public Vector<News> getTopNews() {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent,\n"
                + "Users.name as userName,Users.id as userId, Users.imagePath as avatar,\n"
                + "NewsGroup.newsGroupName, News.newsGroupId, \n"
                + "News.createDate , News.modifiedDate, News.createBy,\n"
                + "News.modifiedBy, News.imagePath, News.viewsCount\n"
                + "FROM News\n"
                + "INNER JOIN Users ON News.createBy = Users.id\n"
                + "JOIN NewsGroup ON News.newsGroupId = NewsGroup.id \n"
                + "ORDER BY News.viewsCount DESC LIMIT 5";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User admin = new User(
                        rs.getInt("userId"),
                        rs.getString("userName"),
                        rs.getString("avatar")
                );

                long currentTimeMillis = System.currentTimeMillis();
                long createDateMillis = rs.getDate("createDate").getTime();
                long timeDifferenceInMillis = currentTimeMillis - createDateMillis;
                long timeDifferenceInDays = timeDifferenceInMillis / (1000 * 60 * 60 * 24);

                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath"),
                        admin
                );

                n.setTimeDifferenceInDays(timeDifferenceInDays);

                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    

    public Vector<News> getTop5NewsByViewsAndAdminId(int userId) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.name as userName, NewsGroup.newsGroupName, News.newsGroupId, "
                + "News.createDate , News.modifiedDate, News.createBy, News.modifiedBy, News.imagePath, News.viewsCount "
                + "FROM News "
                + "INNER JOIN Users ON News.createBy = Users.id"
                + "JOIN NewsGroup ON News.newsGroupId = NewsGroup.id "
                + "WHERE Users.id= ? "
                + "ORDER BY News.viewsCount DESC LIMIT 5";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Vector<News> getTop5NewsByViewsAndGroupId(int newsGroupId) {
        String sql = "SELECT News.id, News.newsTitle, News.shortContent, Users.name as userName, NewsGroup.newsGroupName, News.newsGroupId, "
                + "News.createDate , News.modifiedDate, News.createBy, News.modifiedBy, News.imagePath, News.viewsCount "
                + "FROM News "
                + "INNER JOIN Users ON News.createBy = Users.id"
                + "JOIN NewsGroup ON News.newsGroupId = NewsGroup.id "
                + "WHERE News.newsGroupId = ? "
                + "ORDER BY News.viewsCount DESC LIMIT 5";
        Vector<News> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, newsGroupId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getInt("id"),
                        rs.getString("newsTitle"),
                        rs.getString("shortContent"),
                        rs.getString("userName"),
                        rs.getInt("newsGroupId"),
                        rs.getString("newsGroupName"),
                        rs.getDate("createDate"),
                        rs.getDate("modifiedDate"),
                        rs.getInt("createBy"),
                        rs.getInt("modifiedBy"),
                        rs.getString("imagePath")
                );
                list.add(n);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    public List<News> getAllNews(){
        List<News> newsList = new ArrayList<>();

        String query = "SELECT * FROM News";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                News news = new News();
                news.setNewsId(rs.getInt("id"));
                news.setNewsTitle(rs.getString("newsTitle"));
                news.setShortContent(rs.getString("shortContent"));
                news.setDescription(rs.getString("description"));
                news.setNewsGroupId(rs.getInt("newsGroupId"));
                news.setCreateDate(rs.getDate("createDate"));
                news.setModifiedDate(rs.getDate("modifiedDate"));
                news.setCreateBy(rs.getInt("createBy"));
                news.setImagePath(rs.getString("imagePath"));
                news.setViewCount(rs.getInt("viewsCount"));

                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return newsList;
    }
    public static void main(String[] args) {
        DAONews d = new DAONews();
        System.out.println(d.getAllNews().get(0).getShortContent());
    }
}
    


