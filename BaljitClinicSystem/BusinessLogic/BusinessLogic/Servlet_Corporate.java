package BusinessLogic;

import BusinessData.BaseDAL;
import BusinessData.DAL_PopulateData;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import BusinessData.DAL_Corporate;
import net.sf.json.JSONSerializer;
import BusinessData.DAL_ShowGrid;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

@WebServlet(name = "Servlet_Corporate", urlPatterns = {"/Servlet_Corporate"})
public class Servlet_Corporate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet Servlet_Stock</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet Servlet_Stock at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
    
    protected void UPDATE_CORPORATE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        String sUserCode = (String) session.getAttribute("usercode");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        String sMethod = request.getParameter("METHOD");
        String sIndex = "0";
        String sName = request.getParameter("NAME");
        String sEmail = request.getParameter("EMAIL");
        String sWebsite = request.getParameter("WEBSITE");
        String sAddress = request.getParameter("ADDRESS");
        String sContactPerson = request.getParameter("CONTACT_PERSON");
        String sTelNo = request.getParameter("TEL_NO");
        String sFaxNo = request.getParameter("FAX_NO");
        String sIsActive = request.getParameter("IS_ACTIVE");   
        String sSP_Method = "";
        
        if (sMethod.equals("INSERT")) {
            sSP_Method = "ADD_CORPORATE";
        } 
        else if (sMethod.equals("UPDATE")) {
            sSP_Method = "UPDATE_CORPORATE";
            sIndex = request.getParameter("INDEX");
        }
        
        String[] aryCorporate = {
            sSP_Method, // sMethod
            sIndex, //scp_id
            sName, // scp_name
            sAddress, // scp_address
            sContactPerson, // scp_contactperson
            sTelNo, // scp_telno
            sFaxNo, // scp_faxno
            sEmail, // scp_email
            sWebsite, // scp_website
            sIsActive, // scp_isactive
            sUserCode // sBy
        };
        
        DAL_Corporate DAL_Corporate = new DAL_Corporate();
        BLL_Common.Common_Object obj = DAL_Corporate.DAL_UPDATE_CORPORATE(SiteName, aryCorporate);

        boolean bReturn = false;

        try {
            if (obj.getObjectArray(0).toString().equals("00000")) {

                obj.commit();
                bReturn = true;              
            } 
            else {
                obj.rollback();
            }
        } catch (Exception e) {
            try {
                obj.rollback();
            } catch (SQLException ex) {
                bReturn = false;
            }
        }
        json.put("bool", bReturn);
        out.println(json);
    }

    public void Get_Corporate_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        int total = 0;
        double pageval = 0;
        
        String sName = request.getParameter("NAME");

        DAL_Corporate DAL_Corporate = new DAL_Corporate();
        BLL_Common.Common_Object ObjList = DAL_Corporate.DAL_GET_CORPORATE(SiteName, new String[]{
            "GET_CORPORATE_LIST", "", sName, Integer.toString(page), Integer.toString(rows)});

        BLL_Common.Common_Object ObjTotalRow = DAL_Corporate.DAL_GET_CORPORATE(SiteName, new String[]{
            "COUNT_CORPORATE_LIST", "", sName, "", ""});

        try {
            total = ObjTotalRow.getJSONArray(0).getJSONObject(0).getInt("Total");

            if (total > 0) {
                pageval = (double) total / rows;
            } else {
                pageval = 0;
            }
       
            json.put("total", (int) (Math.ceil(pageval)));
            json.put("page", page);
            json.put("records", total);

            json.put("rows", ObjList.getJSONArray(0));
        } 
        catch (NullPointerException e1) {
            e1.printStackTrace();
        } 
        out.print(json);
        out.flush();
        out.close();
    }
  
    public void Get_Corporate_Detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        try {
            String sCorporateID = request.getParameter("CORPORATE_ID");
            
            DAL_Corporate DAL_Corporate = new DAL_Corporate();
            BLL_Common.Common_Object obj = DAL_Corporate.DAL_GET_CORPORATE(SiteName, new String[]{
                "GET_CORPORATE_DETAIL", sCorporateID, "", "", ""});
             
            json.put("rows", obj.getJSONArray(0));
            out.print(obj.getJSONArrayAsJSONObject("object"));

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
        // processRequest(request, response);
        String p_method = null;
        p_method = request.getParameter("SFC");

        
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

        // processRequest(request, response);

        String p_method = null;
        p_method = request.getParameter("SFC");

        if (p_method.equals("UPDATE_CORPORATE")) {
            try {
                UPDATE_CORPORATE(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("GET_CORPORATE_LIST")) {
            try {
                Get_Corporate_List(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("GET_CORPORATE_DETAIL")) {
            try {
                Get_Corporate_Detail(request, response);
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