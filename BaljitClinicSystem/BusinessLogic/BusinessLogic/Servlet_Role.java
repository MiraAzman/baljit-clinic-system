package BusinessLogic;

import BusinessData.DAL_Role;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
 * @author N3355
 */
@WebServlet(name = "Servlet_Role", urlPatterns = {"/Servlet_Role"})
public class Servlet_Role extends HttpServlet {

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
            out.println("<title>Servlet Servlet_Role</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Servlet_Role at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    public void Bind_Role_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String sRoleCode = "", sRoleBiz = "", sRoleName = "", sRoleStatus = "";
       
        
        String pReqStatus = null, pReqType="";
        int countReqStatus, countReqType;

        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        //Get page and rows value from JSP page
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        sRoleCode = request.getParameter("ROLECODE");
        sRoleBiz = request.getParameter("ROLEBIZ");
        sRoleName = request.getParameter("ROLENAME");
        sRoleStatus = request.getParameter("ROLESTATUS");
        

        String sortName = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        String sOrder = "";
        if (sortName != null) {
            sOrder = sortName + " " + sortOrder;
        }
        
//        if (!"".equals(sRoleStatus) && sRoleStatus != null) {
//            countReqStatus = sRoleStatus.length();
//            pReqStatus = sRoleStatus.substring(0, countReqStatus - 1);
//        } else {
//            pReqStatus = null;
//        }
             
        //Calculate offset value
        //int offset = (page - 1) * rows;
        DAL_Role DalRole = new DAL_Role();

        int total = 0;
        double pageval = 0;

        BLL_Common.Common_Object RoleLst = DalRole.DAL_GET_ROLE(SiteName, new String[]{
            "ROLE_SEARCH", sRoleCode, sRoleBiz, sRoleName, sRoleStatus, "", sOrder, Integer.toString(page), Integer.toString(rows)});

        BLL_Common.Common_Object RoleTotalRow = DalRole.DAL_GET_ROLE(SiteName, new String[]{
            "ROLE_COUNT", sRoleCode, sRoleBiz, sRoleName, sRoleStatus, "", "", "", ""});

        //Execute all queries here
        try {

            total = RoleTotalRow.getJSONArray(0).getJSONObject(0).getInt("TOTAL");

            if (total > 0) {
                pageval = (double) total / rows;
            } else {
                pageval = 0;
            }

            //put total no records in json object with total key           
            json.put("total", (int) (Math.ceil(pageval)));
            json.put("page", page);
            json.put("records", total);

            json.put("rows", RoleLst.getJSONArray(0));

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
    
    public void Bind_Menu_List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String sRoleCode = "", sRoleBiz = "", sRoleName = "", sRoleStatus = "";
       
        
        String pReqStatus = null, pReqType="";
        int countReqStatus, countReqType;

        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        //Get page and rows value from JSP page
      //  int page = Integer.parseInt(request.getParameter("page"));
     //   int rows = Integer.parseInt(request.getParameter("rows"));
        sRoleCode = request.getParameter("ROLECODE");
        sRoleBiz = request.getParameter("ROLEBIZ");
        sRoleName = request.getParameter("ROLENAME");
        sRoleStatus = request.getParameter("ROLESTATUS");
        

    //    String sortName = request.getParameter("sidx");
   //     String sortOrder = request.getParameter("sord");
        String sOrder = "";
//        if (sortName != null) {
//            sOrder = sortName + " " + sortOrder;
//        }
        
//        if (!"".equals(sRoleStatus) && sRoleStatus != null) {
//            countReqStatus = sRoleStatus.length();
//            pReqStatus = sRoleStatus.substring(0, countReqStatus - 1);
//        } else {
//            pReqStatus = null;
//        }
             
        //Calculate offset value
        //int offset = (page - 1) * rows;
        DAL_Role DalRole = new DAL_Role();

        int total = 0;
        double pageval = 0;

        BLL_Common.Common_Object MnuLst = DalRole.DAL_GET_MENU(SiteName, new String[]{
            "ALL_MENU", "", "", "", "", "", "", "","",""});

//        BLL_Common.Common_Object RoleTotalRow = DalRole.DAL_GET_ROLE(new String[]{
//            "ROLE_COUNT", sRoleCode, sRoleBiz, sRoleName, sRoleStatus, "", "", ""});

        //Execute all queries here
        try {

//            total = RoleTotalRow.getJSONArray(0).getJSONObject(0).getInt("TOTAL");
//
//            if (total > 0) {
//                pageval = (double) total / rows;
//            } else {
//                pageval = 0;
//            }

            //put total no records in json object with total key           
//            json.put("total", (int) (Math.ceil(pageval)));
//            json.put("page", page);
//            json.put("records", total);

            json.put("rows", MnuLst.getJSONArray(0));

            //} catch (SQLException e1) {
        } catch (NullPointerException e1) {
            e1.printStackTrace();
        } finally {

        }
        //System.out.println("json-->" + json);
        //return json data to JSP page
        out.print(json);
        out.flush();
        out.close();
    }
    
    public void Bind_Menu_BYROLE(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        
        HttpSession session = request.getSession(); 
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String sRoleCode = "", sRoleBiz = "", sRoleName = "", sRoleStatus = "", sMnuCode="";
       
        
        String pReqStatus = null, pReqType="";
        int countReqStatus, countReqType;

        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        //Get page and rows value from JSP page
      //  int page = Integer.parseInt(request.getParameter("page"));
     //   int rows = Integer.parseInt(request.getParameter("rows"));
        sRoleCode = request.getParameter("ROLECODE");
        sRoleBiz = request.getParameter("ROLEBIZ");
        sRoleName = request.getParameter("ROLENAME");
        sRoleStatus = request.getParameter("ROLESTATUS");
        sMnuCode = request.getParameter("MNUCODE");
        

    //    String sortName = request.getParameter("sidx");
   //     String sortOrder = request.getParameter("sord");
        String sOrder = "";
//        if (sortName != null) {
//            sOrder = sortName + " " + sortOrder;
//        }
        
//        if (!"".equals(sRoleStatus) && sRoleStatus != null) {
//            countReqStatus = sRoleStatus.length();
//            pReqStatus = sRoleStatus.substring(0, countReqStatus - 1);
//        } else {
//            pReqStatus = null;
//        }
            
        //Calculate offset value
        //int offset = (page - 1) * rows;
        DAL_Role DalRole = new DAL_Role();

        int total = 0;
        double pageval = 0;

        BLL_Common.Common_Object MnuLst = DalRole.DAL_GET_MENU(SiteName, new String[]{
            "MENU_BYROLE", sMnuCode, "", "", "", "", sRoleCode, "","",""});

//        BLL_Common.Common_Object RoleTotalRow = DalRole.DAL_GET_ROLE(new String[]{
//            "ROLE_COUNT", sRoleCode, sRoleBiz, sRoleName, sRoleStatus, "", "", ""});

        //Execute all queries here
        try {

//            total = RoleTotalRow.getJSONArray(0).getJSONObject(0).getInt("TOTAL");
//
//            if (total > 0) {
//                pageval = (double) total / rows;
//            } else {
//                pageval = 0;
//            }

            //put total no records in json object with total key           
//            json.put("total", (int) (Math.ceil(pageval)));
//            json.put("page", page);
//            json.put("records", total);

            json.put("rows", MnuLst.getJSONArray(0));

            //} catch (SQLException e1) {
        } catch (NullPointerException e1) {
            e1.printStackTrace();
        } finally {

        }
        //System.out.println("json-->" + json);
        //return json data to JSP page
        out.print(json);
        out.flush();
        out.close();
    }
    
    
    public void Set_Role_Add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        //JSONParser parser = new JSONParser();
        //boolean return_bool = false;
        //String return_msg = "";

        String sMessage = "", sRoleCode = "", sRoleBiz = "", sBy = "", srecstatus ="";        
        JSONArray jsonRole = JSONArray.fromObject(request.getParameter("ADDROLE"));
        //JSONArray jsonRoleFc = JSONArray.fromObject(request.getParameter("ROLEFC"));
          String jsonRoleFc = request.getParameter("ROLEFC");
        sBy = (String) session.getAttribute("loginid");
        DAL_Role obj_Role = new DAL_Role();
        String[] aryRole = {
            "ADD_ROLE" /*sMethod VARCHAR(30)*/,
            "" /*1-sRoleCode    VARCHAR(20)*/,
            ""/*2-sRoleName     VARCHAR(100)*/,
            ""/*3-sRoleBiz      VARCHAR(50)*/,
            ""/*4-sRoleDesc     VARCHAR(20)*/,
            ""/*5-sAllowMulti   VARCHAR(2)*/,            
            (String) session.getAttribute("loginid")/*""/*6-sBy       VARCHAR(10)*/,
            ""/*""/*7-srecstatus VARCHAR(2)*/,
            ""/*""/*8-sView VARCHAR(2)*/,
            ""/*""/*9-sAdd VARCHAR(2)*/,
            ""/*""/*10-sEdit VARCHAR(2)*/,
            ""/*""/*11-sDel VARCHAR(2)*/,
            ""/*""/*12-sVerify VARCHAR(2)*/,
            ""/*""/*13-sApprove VARCHAR(2)*/,
            ""/*""/*14-sSEQ VARCHAR(10)*/,
            ""/*""/*15-sMnuCode VARCHAR(20)*/
            };

        int length = jsonRole.size();
        for (int i = 0; i < length; i++) {
            JSONObject jsonObject = jsonRole.getJSONObject(i);
            String tempValue = jsonObject.getString("value");

            if (jsonObject.getString("name").equals("txtRoleCode")) {
                aryRole[1] = tempValue.toUpperCase();
                sRoleCode = tempValue.toUpperCase();
            } 
            else if (jsonObject.getString("name").equals("txtRoleName")) {
                aryRole[2] = tempValue.toUpperCase();
                
            } 
            else if (jsonObject.getString("name").equals("ddlBizRole")) {
                aryRole[3] = tempValue.toUpperCase();
                sRoleBiz = tempValue.toUpperCase();
            }
            else if (jsonObject.getString("name").equals("txtRoleDesc")) {
                aryRole[4] = tempValue.toUpperCase();
            } 
            else if (jsonObject.getString("name").equals("ddlRoleStatus")) {
                aryRole[7] = tempValue.toUpperCase();
                srecstatus = tempValue.toUpperCase();
            } 

        }

        BLL_Common.Common_Object obj = obj_Role.DAL_ADDEDIT_ROLE(SiteName, aryRole);
       // BLL_Common.Common_Object objUom = new BLL_Common.Common_Object();
        // BLL_Common.Common_Object objPrice = new BLL_Common.Common_Object();
        boolean bReturn = false;

        try {
            if (obj.getObjectArray(0).toString().equals("00000")) {
                
                ADD_ROLE_FUNCTION(jsonRoleFc, sBy, sRoleCode, sRoleBiz, srecstatus, SiteName);
                
                obj.commit();              
                bReturn = true;
                sMessage = obj.getObjectArray(1).toString();
                
            } else {
                // objPrice.rollback();
                //  objUom.rollback();
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
        json.put("msg", sMessage);
        //json.put("CorpCode", sCorpCode);
        out.println(json);
               
    }
    
     public static boolean ADD_ROLE_FUNCTION(String JsonString, String sBy, String sRoleCode, String sRoleBiz, String srecstatus, String SiteName) throws IOException, SQLException {
         
            DAL_Role obj_Role = new DAL_Role();
            BLL_Common.Common_Object commObj = new BLL_Common.Common_Object();
            boolean b = false;
            JSONArray Role_array = (JSONArray) JSONSerializer.toJSON(JsonString);
             
             if (Role_array.size() > 0) {
                 
                  for (Object jsRole : Role_array) {
                       JSONObject objRole = (JSONObject) jsRole;
                       
                       String[] aryRoleITEM = {
                        "ADD_ROLEFC" /*0-sMethod VARCHAR(30)*/,
                        sRoleCode /*1-sRoleCode    VARCHAR(20)*/,
                        ""/*2-sRoleName     VARCHAR(100)*/,
                        sRoleBiz/*3-sRoleBiz      VARCHAR(50)*/,
                        ""/*4-sRoleDesc     VARCHAR(20)*/,
                        ""/*5-sAllowMulti   VARCHAR(2)*/,            
                        sBy/*""/*6-sBy       VARCHAR(10)*/,
                        srecstatus/*""/*7-srecstatus VARCHAR(2)*/,
                        objRole.get("HasView").toString().toUpperCase()/*""/*8-sView VARCHAR(2)*/,
                        objRole.get("HasAdd").toString().toUpperCase()/*""/*9-sAdd VARCHAR(2)*/,
                        objRole.get("HasEdit").toString().toUpperCase()/*""/*10-sEdit VARCHAR(2)*/,
                        objRole.get("HasDel").toString().toUpperCase()/*""/*11-sDel VARCHAR(2)*/,
                        objRole.get("HasVerify").toString().toUpperCase()/*""/*12-sVerify VARCHAR(2)*/,
                        objRole.get("HasApprove").toString().toUpperCase()/*""/*13-sApprove VARCHAR(2)*/,
                        objRole.get("MnuSeq").toString().toUpperCase()/*""/*14-sSEQ VARCHAR(10)*/,
                        objRole.get("MnuCode").toString().toUpperCase()/*""/*15-sMnuCode VARCHAR(20)*/
                        };
                       
                       commObj = obj_Role.DAL_ADDEDIT_ROLE(SiteName, aryRoleITEM);
                         
                    if (commObj.getObjectArray(0).toString().equals("00000")) {                                         
                        commObj.commit();
                         b = commObj.getObjectArray(0).toString().equals("00000");    
                    } else {                        
                        commObj.rollback();
                    }
                  }                                                   
             }
              
         return b;
     }
    
     public void Bind_Role_Detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession(); 
        String SiteName = (String) session.getAttribute("SiteName");
         
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        try {
            String sRoleCode = request.getParameter("ROLECODE");
             DAL_Role DalRole = new DAL_Role();
            BLL_Common.Common_Object objRoleDet = DalRole.DAL_GET_ROLE(SiteName, new String[]{
            "ROLE_DETAIL", sRoleCode, "", "", "", "", "", "", ""});
            
            json.put("data", objRoleDet.getJSONArray(0));
            out.print(objRoleDet.getJSONArrayAsJSONObject("object"));

        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
        } finally {
            // BLL_Common.closeResultSet(rs,"");
        }
    }
     
    public void Get_Role_Access(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        try {
            String sMenuDesc = request.getParameter("MENU_DESC");
            String sUserCode = request.getParameter("USER_CODE");
            
            DAL_Role DalRole = new DAL_Role();
            BLL_Common.Common_Object objRoleAccess = DalRole.DAL_GET_ROLE(SiteName, new String[]{"GET_ROLE_ACCESS", sUserCode, "", "", "", sMenuDesc, "", "", ""});
            
            json.put("data", objRoleAccess.getJSONArray(0));
            out.print(objRoleAccess.getJSONArrayAsJSONObject("object"));

        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
        } 
    }     
     
     protected void Update_Role(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        
        HttpSession session = request.getSession(); 
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        net.sf.json.JSONObject jsonReturn = new net.sf.json.JSONObject();
        boolean bReturn = false;
        
      //  try {
            String sMessage = "", sRoleCode = "", sRoleBiz = "", sBy = "", srecstatus ="";
            DAL_Role obj_Role = new DAL_Role();
            
            JSONArray jsonRole = JSONArray.fromObject(request.getParameter("ROLEITEM"));
              String jsonRoleFc = request.getParameter("ROLEFC");

           //System.out.println("jsonPOItem-->" + jsonPOItem);
            sBy = (String) session.getAttribute("loginid");
           String[] aryRole = {
            "UPDATE_ROLE" /*sMethod VARCHAR(30)*/,
            "" /*1-sRoleCode    VARCHAR(20)*/,
            ""/*2-sRoleName     VARCHAR(100)*/,
            ""/*3-sRoleBiz      VARCHAR(50)*/,
            ""/*4-sRoleDesc     VARCHAR(20)*/,
            ""/*5-sAllowMulti   VARCHAR(2)*/,            
            (String) session.getAttribute("loginid")/*""/*6-sBy       VARCHAR(10)*/,
            ""/*""/*7-srecstatus VARCHAR(2)*/,
            ""/*""/*8-sView VARCHAR(2)*/,
            ""/*""/*9-sAdd VARCHAR(2)*/,
            ""/*""/*10-sEdit VARCHAR(2)*/,
            ""/*""/*11-sDel VARCHAR(2)*/,
            ""/*""/*12-sVerify VARCHAR(2)*/,
            ""/*""/*13-sApprove VARCHAR(2)*/,
            ""/*""/*14-sSEQ VARCHAR(10)*/,
            ""/*""/*15-sMnuCode VARCHAR(20)*/
            };
            
            
            
             int length = jsonRole.size();
                for (int x = 0; x < length; x++) {
                    JSONObject jsonObject = jsonRole.getJSONObject(x);
                    String tempValue = jsonObject.getString("value");

                    if (jsonObject.getString("name").equals("lblRoleCode")) {
                        aryRole[1] = tempValue.toUpperCase();
                        sRoleCode = tempValue.toUpperCase();
                    }
                    else if (jsonObject.getString("name").equals("ddlBizRole")) {
                       aryRole[3] = tempValue.toUpperCase();
                       sRoleBiz = tempValue.toUpperCase();
                    } 
                    else if (jsonObject.getString("name").equals("ddlRoleStatus")) {
                       aryRole[7] = tempValue.toUpperCase();
                    } 
                      

                }
                //System.out.println("aryPO-->" + aryPO.toString());
                BLL_Common.Common_Object obj = obj_Role.DAL_ADDEDIT_ROLE(SiteName, aryRole);
            
                 try {
                    if (obj.getObjectArray(0).toString().equals("00000")) {
                        UPDATE_ROLE_FUNCTION(jsonRoleFc, sBy, sRoleCode, sRoleBiz, srecstatus, SiteName);
                        obj.commit();
                        bReturn = true;
                        sMessage = obj.getObjectArray(1).toString();
                    } else {
                        obj.rollback();
                    }
                } catch (Exception e) {
                    try {
                            obj.rollback();
                        } catch (SQLException ex) {
                            bReturn = false;
                        }
                }

                jsonReturn.put("bool", bReturn);
                jsonReturn.put("msg", sMessage);
                out.println(jsonReturn);
                
            }
     
     public static boolean UPDATE_ROLE_FUNCTION(String JsonString, String sBy, String sRoleCode, String sRoleBiz, String srecstatus, String SiteName) throws IOException, SQLException {
         
            DAL_Role obj_Role = new DAL_Role();
            BLL_Common.Common_Object commObj = new BLL_Common.Common_Object();
            boolean b = false;
            JSONArray Role_array = (JSONArray) JSONSerializer.toJSON(JsonString);
             
             if (Role_array.size() > 0) {
                 
                  for (Object jsRole : Role_array) {
                       JSONObject objRole = (JSONObject) jsRole;
                       
                       String[] aryRoleITEM = {
                        "UPDATE_ROLEFC" /*0-sMethod VARCHAR(30)*/,
                        sRoleCode /*1-sRoleCode    VARCHAR(20)*/,
                        ""/*2-sRoleName     VARCHAR(100)*/,
                        sRoleBiz/*3-sRoleBiz      VARCHAR(50)*/,
                        ""/*4-sRoleDesc     VARCHAR(20)*/,
                        ""/*5-sAllowMulti   VARCHAR(2)*/,            
                        sBy/*""/*6-sBy       VARCHAR(10)*/,
                        srecstatus/*""/*7-srecstatus VARCHAR(2)*/,
                        objRole.get("HasView").toString().toUpperCase()/*""/*8-sView VARCHAR(2)*/,
                        objRole.get("HasAdd").toString().toUpperCase()/*""/*9-sAdd VARCHAR(2)*/,
                        objRole.get("HasEdit").toString().toUpperCase()/*""/*10-sEdit VARCHAR(2)*/,
                        objRole.get("HasDel").toString().toUpperCase()/*""/*11-sDel VARCHAR(2)*/,
                        objRole.get("HasVerify").toString().toUpperCase()/*""/*12-sVerify VARCHAR(2)*/,
                        objRole.get("HasApprove").toString().toUpperCase()/*""/*13-sApprove VARCHAR(2)*/,
                        objRole.get("MnuSeq").toString().toUpperCase()/*""/*14-sSEQ VARCHAR(10)*/,
                        objRole.get("MnuCode").toString().toUpperCase()/*""/*15-sMnuCode VARCHAR(20)*/
                        };
                       
                       commObj = obj_Role.DAL_ADDEDIT_ROLE(SiteName, aryRoleITEM);
                         
                    if (commObj.getObjectArray(0).toString().equals("00000")) {                                         
                        commObj.commit();
                         b = commObj.getObjectArray(0).toString().equals("00000");    
                    } else {                        
                        commObj.rollback();
                    }
                  }                                                
             }
              
         return b;
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
        
         String method = null;
        method = request.getParameter("SFC");
        //System.out.println("method = " + method);
        if (method.equals("Get_Role_Detail")) {
            try {
                Bind_Role_Detail(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(Servlet_Role.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (method.equals("GET_MENU")) {
            try {
                Bind_Menu_List(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
         else if (method.equals("GET_MENU_BY_ROLE")) {
            try {
                Bind_Menu_BYROLE(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }       
        else if (method.equals("GET_ROLE_ACCESS")) {
            try {
                Get_Role_Access(request, response);
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
       // processRequest(request, response);
        String method = null;
        method = request.getParameter("SFC");
        //System.out.println("method = " + method);
        if (method.equals("Get_Role_List")) {
            try {
                Bind_Role_List(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(Servlet_Role.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else if (method.equals("Set_Role_Add")) {
            try {
                Set_Role_Add(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else if (method.equals("UPDATE_ROLE")) {
            try {
                Update_Role(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else if (method.equals("GET_MENU")) {
            try {
                Bind_Menu_List(request, response);
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
