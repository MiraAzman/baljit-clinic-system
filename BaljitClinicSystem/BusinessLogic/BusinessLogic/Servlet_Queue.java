/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessLogic;

import BusinessData.DAL_Medicine;
import BusinessData.DAL_Queue;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 *
 * @author N4308
 */
@WebServlet(name = "Servlet_Queue", urlPatterns = {"/Servlet_Queue"})
public class Servlet_Queue extends HttpServlet {

    public void GET_BILLING_DETAIL(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        try {
            String sQueueID = request.getParameter("QUEUE_ID");
            
            DAL_Queue DAL_Queue = new DAL_Queue();
            BLL_Common.Common_Object obj = DAL_Queue.DAL_GET_BILLING(SiteName, new String[]{
                "GET_BILLING_DETAIL", sQueueID, "", ""});
             
            json.put("rows", obj.getJSONArray(0));
            out.print(obj.getJSONArrayAsJSONObject("object"));

        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
        } 
    }
  
    
    protected void UPDATE_QUEUE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        String sUserCode = (String) session.getAttribute("usercode");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss a");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        
        String sMethod = request.getParameter("METHOD");
        String sIndex = "0";
        String sPatientID = request.getParameter("PATIENT_ID");  
        String sStatus = "REGISTERED";
        String sTimeIn = "";
        String sTimeOut = "";
        String sVisitDate = "";
        String sSP_Method = "";
        
        if (sMethod.equals("INSERT")) {
            sSP_Method = "ADD_QUEUE";
            
            Date date = new Date();
            sTimeIn = timeFormat.format(date);  
            sVisitDate = dateFormat.format(date);  
            sStatus = "CONSULTATION";
        } 
        else if (sMethod.equals("UPDATE")) {
            sSP_Method = "UPDATE_MEDICINE";
            sIndex = request.getParameter("INDEX");
        }
        
        String[] aryQueue = {
            sSP_Method, 
            sIndex, 
            sPatientID, 
            sStatus,
            sTimeIn,
            sTimeOut,
            sVisitDate
        };
        
        DAL_Queue DAL_Queue = new DAL_Queue();
        BLL_Common.Common_Object obj = DAL_Queue.DAL_UPDATE_QUEUE(SiteName, aryQueue);

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
  
    public void Get_Queue_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        int total = 0;
        double pageval = 0;
        
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String sTodayDate = dateFormat.format(new Date());

        DAL_Queue DAL_Queue = new DAL_Queue();
        BLL_Common.Common_Object ObjList = DAL_Queue.DAL_GET_QUEUE(SiteName, new String[]{
            "GET_QUEUE_LIST", sTodayDate, Integer.toString(page), Integer.toString(rows)});

        BLL_Common.Common_Object ObjTotalRow = DAL_Queue.DAL_GET_QUEUE(SiteName, new String[]{
            "COUNT_QUEUE_LIST", sTodayDate, "", ""});

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

    protected void UPDATE_CONSULTATION(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        String sUserCode = (String) session.getAttribute("usercode");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss a");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        
        String sQueueID = request.getParameter("QUEUE_ID");
        String sIndex = "0";
        String sConsultationNotes = request.getParameter("CONSULTATION_NOTES");  
        String sStatus = "REGISTERED";
        
        String[] aryConsultation = {
            "ADD_CONSULTATION", 
            sIndex, 
            sQueueID, 
            sConsultationNotes
        };
        
        DAL_Queue DAL_Queue = new DAL_Queue();
        BLL_Common.Common_Object obj = DAL_Queue.DAL_UPDATE_CONSULTATION(SiteName, aryConsultation);

        boolean bReturn = false;

        try {
            if (obj.getObjectArray(0).toString().equals("00000")) {

                obj.commit();
                bReturn = true;              
                
                //update queue status to billing
                String[] aryQueue = {
                    "UPDATE_QUEUE", 
                    sQueueID, 
                    "", 
                    "BILLING",
                    "",
                    "",
                    ""
                };

                BLL_Common.Common_Object obj2 = DAL_Queue.DAL_UPDATE_QUEUE(SiteName, aryQueue);
                if (obj2.getObjectArray(0).toString().equals("00000")) {
                    obj2.commit();
                    
                    //add prescription
                    String Items = request.getParameter("PRESCRIPTION_ITEMS");
                    JSONArray Item_array = (JSONArray) JSONSerializer.toJSON(Items);
                    if (Item_array.size() > 0) {
                        
                        double dGrandTotal = 0;
                        for (Object js : Item_array) { //iterate through Item
                            JSONObject Itemjson = (JSONObject) js; 
                                                                 
                            String sMedicineID = Itemjson.get("INDEX").toString();
                            String sQty = Itemjson.get("QTY").toString();
                            String sTotalPrice = Itemjson.get("TOTAL_PRICE").toString();
                            dGrandTotal = dGrandTotal + Double.valueOf(sTotalPrice);
                            
                            String[] aryItem = {
                                "ADD_PRESCRIPTION", 
                                "0", 
                                sQueueID, 
                                sMedicineID,
                                sQty,
                                sTotalPrice
                            };
                            
                            BLL_Common.Common_Object obj3 = DAL_Queue.DAL_UPDATE_PRESCRIPTION(SiteName, aryItem);
                            if (obj3.getObjectArray(0).toString().equals("00000")) {
                                obj3.commit();
                            }
                            else {
                                obj3.rollback();
                                bReturn = false;
                            }
                        }
                        //add billing
                        String[] aryBilling = {
                            "ADD_BILLING", 
                            "0", 
                            sQueueID, 
                            "",
                            Double.toString(dGrandTotal)
                        };
                        BLL_Common.Common_Object obj4 = DAL_Queue.DAL_UPDATE_BILLING(SiteName, aryBilling);
                        if (obj4.getObjectArray(0).toString().equals("00000")) {
                            obj4.commit();
                        }
                        else {
                            obj4.rollback();
                            bReturn = false;
                        }
                    }
                }
                else {
                    obj2.rollback();
                    bReturn = false;
                }
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
  
    protected void UPDATE_BILLING(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        String sUserCode = (String) session.getAttribute("usercode");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        String sQueueID = request.getParameter("QUEUE_ID");
        String sPaymentType = request.getParameter("PAYMENT_TYPE");
        String sIndex = "0";
        
        String[] aryBilling = {
            "UPDATE_BILLING", 
            sIndex, 
            sQueueID, 
            sPaymentType,
            ""
        };
        
        DAL_Queue DAL_Queue = new DAL_Queue();
        BLL_Common.Common_Object obj = DAL_Queue.DAL_UPDATE_BILLING(SiteName, aryBilling);

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
   
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
//            out.println("<title>Servlet Servlet_Queue</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet Servlet_Queue at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }

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

        if (p_method.equals("GET_BILLING_DETAIL")) {
            try {
                GET_BILLING_DETAIL(request, response);
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
        //processRequest(request, response);
        
        String p_method = null;
        p_method = request.getParameter("SFC");

        if (p_method.equals("UPDATE_QUEUE")) {
            try {
                UPDATE_QUEUE(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("GET_QUEUE_LIST")) {
            try {
                Get_Queue_List(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("UPDATE_CONSULTATION")) {
            try {
                UPDATE_CONSULTATION(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (p_method.equals("UPDATE_BILLING")) {
            try {
                UPDATE_BILLING(request, response);
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
