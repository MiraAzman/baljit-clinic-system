/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessLogic;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author N0531
 */
@WebServlet(name = "Servlet_Report", urlPatterns = {"/Servlet_Report"})
public class Servlet_Report extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Servlet_Report</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_Report at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    protected void EncryptParameter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
       // String cppCode = session.getAttribute("cppcode").toString();
        String Param1 = request.getParameter("param1") == null? "" :request.getParameter("param1");
        String Param2 = request.getParameter("param2");
        String Param3 = request.getParameter("param3");
        String Param4 = request.getParameter("param4");
       // String jasperPath = session.getAttribute("jasperpath").toString();
       // BLL_Report BLL_Report = new BLL_Report();
        BLL_Common BLL_Common = new BLL_Common();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        try {
            String User_ID = session.getAttribute("loginid").toString();
            String User_App = session.getAttribute("bussapp").toString();
            String User_Cpp = session.getAttribute("bussapp").toString();
            //Param2 = BLL_Report.getReportPath2().concat(Param2);
           // Param2 = jasperPath.concat(Param2);
            json.put("param1", BLL_Common.Encryption(User_ID + User_App, Param1));
            json.put("param2", BLL_Common.Encryption(User_ID + User_App, Param2));
            json.put("param3", BLL_Common.Encryption(User_ID + User_App, Param3));
            json.put("param4", BLL_Common.Encryption(User_ID + User_App, Param4));
        } catch (Exception e) {
            json.put("msg", "Error Occur: Please Try Again Later.");
        }

        out.print(json);
        out.flush();
        out.close();
    }
    
    private void Get_Address(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
       // String sCode = request.getParameter("CODE");
      //  String sType = request.getParameter("TYPE");
       // BLL_PopulateData BLL_Pop = new BLL_PopulateData();

        //out.print(BLL_Pop.BLL_Get_Address(sCode,sType));
        out.flush();
        out.close();
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
        processRequest(request, response);
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
        String sFC = request.getParameter("SFC");
        if (sFC.equals("ENCRYPT")) {
            EncryptParameter(request, response);
        } else if (sFC.equals("GET_ADDRESS")) {
            Get_Address(request, response);
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
