package BusinessLogic;

import BusinessData.DAL_PopulateData;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;

/**
 *
 * @author N3355
 */
@WebServlet(name = "Servlet_PopulateData", urlPatterns = {"/Servlet_PopulateData"})
public class Servlet_PopulateData extends HttpServlet {

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
            out.println("<title>Servlet Servlet_PopulateData</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_PopulateData at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
       public JSONArray ddlGet(String sMethod, String sParam1, String sParam2, String SiteName) {
        DAL_PopulateData CodeDescList = new DAL_PopulateData();
        BLL_Common.Common_Object obj = CodeDescList.Get_DAL_CODEDESC_Info(SiteName, new String[]{sMethod, sParam1, sParam2});
        try {
            return obj.getJSONArray(0);
        } catch (NullPointerException e) {
            return null;
        }
    }
       
       public JSONArray Get_RunningNo(String pMethod, String pParam1, String pParam2, String SiteName){
      
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

       DAL_PopulateData RunningNo = new DAL_PopulateData();

        BLL_Common.Common_Object objNo = RunningNo.DAL_GetNumber(SiteName, new String[]{
            pMethod, pParam1, pParam2});

         try {
            return objNo.getJSONArray(0);
        } catch (NullPointerException e) {
            return null;
        }
       
     
    }

    public void GET_DLL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        try {
            String sMethod = request.getParameter("METHOD");
            String sParam1 = request.getParameter("P1");
            String sParam2 = request.getParameter("P2");
            
            DAL_PopulateData CodeDescList = new DAL_PopulateData();
            BLL_Common.Common_Object obj = CodeDescList.Get_DAL_CODEDESC_Info(SiteName, new String[]{sMethod, sParam1, sParam2});
            
            json.put("rows", obj.getJSONArray(0));
            out.print(obj.getJSONArray(0));
        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
        } finally {
            // BLL_Common.closeResultSet(rs,"");
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
       // processRequest(request, response);
        String p_method = null;
        p_method = request.getParameter("SFC");
       
        if(p_method.equals("GET_DLL")){
            try {
                GET_DLL(request, response);
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
      //  processRequest(request, response);
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
