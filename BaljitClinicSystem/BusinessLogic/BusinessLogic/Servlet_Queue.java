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

/**
 *
 * @author N4308
 */
@WebServlet(name = "Servlet_Queue", urlPatterns = {"/Servlet_Queue"})
public class Servlet_Queue extends HttpServlet {

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
            sStatus = "REGISTERED";
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
