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


//-----
/**
 *
 * @author N3355
 */
@WebServlet(name = "Servlet_Stock", urlPatterns = {"/Servlet_Stock"})
public class Servlet_Stock extends HttpServlet {

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
 
// author - amira, date 7/12/2015
    public void Search_StkCodeList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        //Get page and rows value from JSP page
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));

        String sType = request.getParameter("TYPE"); 
        String sCode = request.getParameter("CODE");
        String sDesc = request.getParameter("DESC");

        String sortName = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        String sOrder = "";
        if (sortName != null) {
            sOrder = sortName + " " + sortOrder;
        }

        //Calculate offset value
        //int offset = (page - 1) * rows;

        DAL_ShowGrid DAL_product = new DAL_ShowGrid();

        int total = 0;
        double pageval = 0;

        BLL_Common.Common_Object SignUpList = DAL_product.DAL_GET_CODETYPE(SiteName, new String[]{
            "GET_CODETYPE_LIST", sType, sCode, sDesc, "", sOrder, Integer.toString(page), Integer.toString(rows)});

        BLL_Common.Common_Object SignUpTotalRow = DAL_product.DAL_GET_CODETYPE(SiteName, new String[]{
            "COUNT_CODETYPE_LIST", sType, sCode, sDesc, "", "", "", ""});

        //Execute all queries here
        try {

            total = SignUpTotalRow.getJSONArray(0).getJSONObject(0).getInt("Total");

            if (total > 0) {
                pageval = (double) total / rows;
            } else {
                pageval = 0;
            }

            //put total no records in json object with total key           
            json.put("total", (int) (Math.ceil(pageval)));
            json.put("page", page);
            json.put("records", total);

            json.put("rows", SignUpList.getJSONArray(0));

        //} catch (SQLException e1) {
        } catch (NullPointerException e1) {
            e1.printStackTrace();
        } finally {

        }

        //return json data to JSP page
        out.print(json);
        out.flush();
        out.close();
    }

    public void UPDATE_CODETYPE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
       
        String sType = request.getParameter("TYPE");
        String sCode = request.getParameter("CODE");
        String sDesc = request.getParameter("DESC");
        String sFunc = request.getParameter("FUNCTION");
        
        String srecstatus = "";
        boolean bReturn = false;   
        String sMethod = "";
        
        if ( sFunc.equals("ADD") ){
            sMethod = "ADD_CODETYPE"; 
            srecstatus = "1";
        } else if ( sFunc.equals("EDIT") ) {           
            sMethod = "EDIT_CODETYPE_DETAIL";                                           
            srecstatus = request.getParameter("recstatus"); 
        }
        DAL_ShowGrid StkDetail = new DAL_ShowGrid();       
        BLL_Common.Common_Object obj = StkDetail.DAL_UPDATE_CODETYPE(SiteName, new String[]{
            sMethod, sType, sCode, sDesc,"",srecstatus});
        
        try {              
            if (obj.getObjectArray(0).toString().equals("00000")) {

                obj.commit();   
//                DataTransfer_CodeDesc(sType,sCode, SiteName); //LLT - 20160520
                bReturn = true;                    
            } else {
                obj.rollback();
            }
        }catch (Exception e) {
            try {
                obj.rollback();
            } catch (SQLException ex) {
                out.println("Exception Error.");
                e.printStackTrace();
                bReturn = false;
            }
        }    
        json.put("bool", bReturn);
        out.println(json);
    } 

// author - amira, date 30/12/2015
    // view detail page
    public void VIEW_CODETYPE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        
        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        try {            
                String sCode = request.getParameter("CODE");
                String sType = request.getParameter("TYPE");
                
                DAL_ShowGrid StkDetail = new DAL_ShowGrid();
                
                BLL_Common.Common_Object rsDetail = StkDetail.DAL_GET_CODETYPE(SiteName, new String[]{
                    "CODETYPE_DETAIL", sType, sCode, "", "", "", "", ""});
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

//        if (p_method.equals("GET_PRD_DETAIL")) {
//            try {
//                Bind_Product_Detail(request, response);
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        } 
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

        if (p_method.equals("GET_STOCKCODE_LIST")) {
            try {
                Search_StkCodeList(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if (p_method.equals("UPDATE_CODETYPE")) {
            try {
                UPDATE_CODETYPE(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if (p_method.equals("VIEW_CODE_DETAIL")) {
            try {
                VIEW_CODETYPE(request, response);
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