package BusinessLogic;

import BusinessData.BaseDAL;
 
//import BusinessData.DAL_SitesDBInfor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.servlet.http.HttpSession;

/**
 *
 * @author N3359
 */
public class Servlet_SitesDBInfor extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_SitesDBInfor</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_SitesDBInfor at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    public void GET_SITE_DISPLAYNAME(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
 
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        try {   
            
            BLL_Common.Common_Object rsDetail = BaseDAL.getSiteDisplayName(SiteName);
            
            json.put("row", rsDetail.getJSONArray(0));
            out.print(rsDetail.getJSONArrayAsJSONObject("object"));
            
        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
        } finally {
           // BLL_Common.closeResultSet(rs,"");
        } 
        //json.put("type", sType);
        //out.println(json);
    } 
    
    public void GET_INTEGRATION_TYPE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");      
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        try {
            BLL_Common.Common_Object obj = BaseDAL.getSiteDisplayName(SiteName);            
            String sIntegrationType = obj.getJSONArray(0).getJSONObject(0).getString("CMSIntegrationType");
                    
            json.put("IntegrationType", sIntegrationType);
            out.print(json);
        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
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
        //processRequest(request, response);
        String p_method = null;
        p_method = request.getParameter("SFC");
        
        if(p_method.equals("GET_INTEGRATION_TYPE")){
            try {
                GET_INTEGRATION_TYPE(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            } 
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
//        processRequest(request, response);
        String p_method = null;
        p_method = request.getParameter("SFC");

        if (p_method.equals("GET_SITE_DISPLAYNAME")) {
            try {
                GET_SITE_DISPLAYNAME(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
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

}
