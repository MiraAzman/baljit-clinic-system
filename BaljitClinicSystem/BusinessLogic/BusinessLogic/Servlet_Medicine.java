package BusinessLogic;

import BusinessData.BaseDAL;
import BusinessData.DAL_PopulateData;
import Model.Medicine;

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
import BusinessData.DAL_Medicine;
import BusinessData.DAL_Corporate;
import net.sf.json.JSONSerializer;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet(name = "Servlet_Medicine", urlPatterns = {"/Servlet_Medicine"})
public class Servlet_Medicine extends HttpServlet {

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
    
    protected void UPDATE_MEDICINE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        String sUserCode = (String) session.getAttribute("usercode");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        String sMethod = request.getParameter("METHOD");
        String sIndex = "0";
        String sName = request.getParameter("NAME");
        String sBatchNo = request.getParameter("BATCH_NO");
        String sUOM = request.getParameter("UOM");
        String sExpiryDate = request.getParameter("EXPIRY_DATE");
        String dUnitCost = request.getParameter("UNIT_COST");
        String iQty = request.getParameter("QTY");
        String dPrice = request.getParameter("PRICE");
        String sIsActive = request.getParameter("IS_ACTIVE");   
        String sSP_Method = "";
        
        if (sMethod.equals("INSERT")) {
            sSP_Method = "ADD_MEDICINE";
        } 
        else if (sMethod.equals("UPDATE")) {
            sSP_Method = "UPDATE_MEDICINE";
            sIndex = request.getParameter("INDEX");
        }
        
        Medicine medicine = new Medicine(sIndex, sName, sBatchNo, sUOM, sExpiryDate,
        		dUnitCost, iQty, dPrice, sIsActive);
        
        String[] aryMedicine = {
            sSP_Method, 
            sUserCode 
        };
        
        String[] aryMedicine2 = {
                sSP_Method, 
                sIndex, 
                sName, 
                sUOM,
                dUnitCost,
                dPrice,
                sIsActive,
                sBatchNo,
                sExpiryDate, 
                iQty,
                sUserCode 
            };
            
        DAL_Medicine DAL_Medicine = new DAL_Medicine();
        BLL_Common.Common_Object obj = DAL_Medicine.DAL_UPDATE_MEDICINE(SiteName, aryMedicine, medicine);
        
        boolean bReturn = BaseDAL.call_SP_TRX_MEDICINE(aryMedicine, SiteName, medicine);

        json.put("bool", bReturn);
        out.println(json);           
    }

    public void Get_Medicine_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
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

        DAL_Medicine DAL_Medicine = new DAL_Medicine();
        BLL_Common.Common_Object ObjList = DAL_Medicine.DAL_GET_MEDICINE(SiteName, new String[]{
            "GET_MEDICINE_LIST", "", sName, Integer.toString(page), Integer.toString(rows)});

        BLL_Common.Common_Object ObjTotalRow = DAL_Medicine.DAL_GET_MEDICINE(SiteName, new String[]{
            "COUNT_MEDICINE_LIST", "", sName, "", ""});

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
  
    public void Get_Medicine_Detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        try {
            String sMedicineID = request.getParameter("MEDICINE_ID");
            
            DAL_Medicine DAL_Medicine = new DAL_Medicine();
            BLL_Common.Common_Object obj = DAL_Medicine.DAL_GET_MEDICINE(SiteName, new String[]{
                "GET_MEDICINE_DETAIL", sMedicineID, "", "", ""});
             
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

        if (p_method.equals("UPDATE_MEDICINE")) {
            try {
                UPDATE_MEDICINE(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("GET_MEDICINE_LIST")) {
            try {
                Get_Medicine_List(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("GET_MEDICINE_DETAIL")) {
            try {
                Get_Medicine_Detail(request, response);
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