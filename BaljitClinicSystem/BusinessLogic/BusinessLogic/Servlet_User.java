package BusinessLogic;

import BusinessData.BaseDAL;
import BusinessData.DAL_Common;
import BusinessData.DAL_User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *
 * @author N3355
 */
@WebServlet(name = "Servlet_User", urlPatterns = {"/Servlet_User"})
public class Servlet_User extends HttpServlet {
    
    DAL_User objUsr = new DAL_User();
BLL_Common BLL_Common = new BLL_Common();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    public void UpdatePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        String sUserCode = (String) session.getAttribute("usercode");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
         
        boolean bReturn = false; 
        String sMsg = "";
        String sPwd = request.getParameter("CURRENT_PWD"); 
        String sNewPwd = request.getParameter("NEW_PWD");
        sPwd = BLL_Common.MD5(sPwd);
        sNewPwd = BLL_Common.MD5(sNewPwd);

        DAL_User DAL_User = new DAL_User();              
        BLL_Common.Common_Object obj = DAL_User.DAL_GET_User(SiteName, new String[]{
            "GET_CURRENT_PASSWORD", sUserCode,"","","","","","","","", "",""});
            
        JSONArray UserPwd_array = obj.getJSONArray(0);        
        JSONObject UserPwd_obj = UserPwd_array.getJSONObject(0);
        String sCurrentPwd = UserPwd_obj.getString("usr_pwd");
        
        if (sPwd.equals(sCurrentPwd)) {
            obj = DAL_User.DAL_UPDATE_USER(SiteName, new String[]{
            "UPDATE_PASSWORD", sUserCode, "", sNewPwd, "", "", "", "", "", "", "", sUserCode, ""});    
            
            try {              
                if (obj.getObjectArray(0).toString().equals("00000")) {
                    
                    obj.commit();   
                    bReturn = true;                    
                } else {
                    obj.rollback();
                }
            }catch (Exception e) {
                try {
                    obj.rollback();
                } catch (Exception ex) {
                    BLL_Common.write_log(ex.toString(), "");
                    e.printStackTrace();
                    bReturn = false;
                }
            }    
        } else {
            bReturn = false;
            sMsg = "Passwords do not match";
        }
        json.put("bool", bReturn);
        json.put("msg", sMsg);
        out.println(json);
    } 
    
    public void GET_UserLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String[] s_return = null;
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");

        String s_ContentPath = BaseDAL.Deploy_Path.toString();
       // BLL_CorpProvider BLL_CP = new BLL_CorpProvider();

        String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + s_ContentPath;

        if (request.getParameter("txtloginid") != null && request.getParameter("txtpassword") != null && request.getParameter("txtBusinessApp") != null) {
            String s_loginid = request.getParameter("txtloginid").trim();
            String s_loginpwd = request.getParameter("txtpassword").trim();
            String s_businessapp = request.getParameter("txtBusinessApp").trim();
             String s_encryptpwd;
             
            s_encryptpwd = BLL_Common.MD5(s_loginpwd);

            try {
                //Check login & password
                
                BLL_Common.Common_Object usrList = objUsr.DAL_GET_User(SiteName, new String[]{
                "VALIDATE", s_loginid, "", s_encryptpwd, "", "", "", "", "", "", "", ""});
                
                
                // System.out.println("JSONObject-->" + usrList.getJSONArray(0));
                    if (usrList.getJSONArray(0).size() > 0){
                        session.setAttribute("loginid", s_loginid);
                        session.setAttribute("loginpwd", s_loginpwd);
                        session.setAttribute("bussapp", s_businessapp);
                        session.setAttribute("usercode", s_loginid);
                       // session.setAttribute("cppcode", s_return[3]);
                       // session.setAttribute("cppname", s_return[4]);
                        session.setAttribute("fullname", usrList.getJSONArray(0).getJSONObject(0).getString("usrfullname"));
                        session.setAttribute("Usremail", usrList.getJSONArray(0).getJSONObject(0).getString("usrmail"));
                        session.setAttribute("CompCode", usrList.getJSONArray(0).getJSONObject(0).getString("CompCode"));
                        session.setAttribute("LocCode", usrList.getJSONArray(0).getJSONObject(0).getString("LocCode"));
                        session.setAttribute("UsrRole", usrList.getJSONArray(0).getJSONObject(0).getString("usrRole"));
                        
                        JSONArray jsonTemp = new JSONArray();
                        try {
                            JSONObject tempIn = BLL_Common.readSettingsFile(s_loginid);
                            if (tempIn.containsKey("gridSettings")) {
                                jsonTemp = tempIn.getJSONArray("gridSettings");
                            }
                        } catch (Exception e) {

                        }
                        session.setAttribute("gridSettings", jsonTemp);
                        response.sendRedirect(response.encodeRedirectURL(contextPath + "/Admin/index.jsp#/QueueList"));
                        
                        
                    }else {
                    session.removeAttribute("bussapp");
                    session.removeAttribute("loginpwd");
                    session.removeAttribute("usercode");
                   // session.removeAttribute("arraycode");
                   // session.removeAttribute("arrayname");
                   // session.removeAttribute("select");
                   // session.removeAttribute("cppcode");
                   // session.removeAttribute("cppname");
                    session.removeAttribute("fullname");
                   // session.removeAttribute("rptdur");
                    session.removeAttribute("jasperPath");
                    session.removeAttribute("Usremail");
                    session.removeAttribute("UsrRole");
                  //  session.removeAttribute("countrycode");

                    session.setAttribute("errormsg", "Invalid user login id or password.");

                    session.setAttribute("loginid", s_loginid);
                    response.sendRedirect(response.encodeRedirectURL(request.getHeader("Referer")));
                }                             
        } catch (Exception ex) {
            //ex.printStackTrace();
            BLL_Common.write_log(ex.toString(), "");
           // s_returnmsg = ex.toString();

        }
            
        }
        Get_UserMenu(request, response);
        //out.print(json);
        out.flush();
        out.close();
    }

     // author - amira, date 14/3/2016
    public void UPDATE_USER(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
                                
        String sCode = request.getParameter("CODE");
        String sName = request.getParameter("NAME");
        String sPwd = request.getParameter("PWD");
        String sFirstName = request.getParameter("FIRST_NAME");
        String sLastName = request.getParameter("LAST_NAME");
        String sContactNo = request.getParameter("CONTACT_NO");
        String sEmail = request.getParameter("EMAIL");
        String sCompCode = request.getParameter("COMPANY");
        String sLocCode = request.getParameter("LOCATION");        
        String sFunc = request.getParameter("FUNCTION");   
           //pengkee 2016/5/12  
        String sRole = request.getParameter("ROLE"); 
   
        boolean bReturn = false; 
        String sMsg = "";
        String sMethod = "";
        
        if ( sFunc.equals("ADD") ){
            sMethod = "ADD_USER";     
            sPwd = BLL_Common.MD5(sPwd);
        } else if ( sFunc.equals("EDIT") ) {           
            sMethod = "EDIT_USER_DETAIL";   
        }
        DAL_User StkDetail = new DAL_User();       
//pengkee 2016/5/12 
//        BLL_Common.Common_Object obj = StkDetail.DAL_UPDATE_USER(new String[]{
//            sMethod, sCode, sName, sPwd, sCompCode, sLocCode, 
//            sFirstName, sLastName, sContactNo, sEmail, "SYSTEM", "1"});    
        BLL_Common.Common_Object obj = StkDetail.DAL_UPDATE_USER(SiteName, new String[]{
            sMethod, sCode, sName, sPwd, sCompCode, sLocCode, 
            sFirstName, sLastName, sContactNo, sEmail, sRole, "SYSTEM", "1"});         
        try {              
            if (obj.getObjectArray(0).toString().equals("00000")) {

                obj.commit();   

                bReturn = true;                    
            } else {
                obj.rollback();
                sMsg = obj.getObjectArray(0).toString();
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
        json.put("msg", sMsg);
        out.println(json);
    } 

    // author - amira, date 14/3/2016
    public void VIEW_USER(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
    
        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/json");
        
        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();
        
        try {   
            String sCode = request.getParameter("CODE");
            DAL_User StkDetail = new DAL_User();
            BLL_Common.Common_Object rsDetail = StkDetail.DAL_GET_User(SiteName, new String[]{
                "USER_DETAIL", sCode,"","","","","","","","", "", ""});
            json.put("row", rsDetail.getJSONArray(0));
            out.print(rsDetail.getJSONArrayAsJSONObject("object"));
            
        } catch (Exception e) {
            out.println("Exception Error.");
            e.printStackTrace();
        } finally {
           // BLL_Common.closeResultSet(rs,"");
        } 
    }
  
    // author - amira, date 11/3/2016
    public void Search_UserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        //Get page and rows value from JSP page
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
 
        String sCode = request.getParameter("CODE");
        String sName = request.getParameter("NAME");
        String sComp = request.getParameter("COMPANY");
        String sLoc = request.getParameter("LOCATION");

        String sortName = request.getParameter("sidx");
        String sortOrder = request.getParameter("sord");
        String sOrder = "";
        if (sortName != null) {
            sOrder = sortName + " " + sortOrder;
        }

        //Calculate offset value
        //int offset = (page - 1) * rows;

        DAL_User DAL_product = new DAL_User();

        int total = 0;
        double pageval = 0;

        BLL_Common.Common_Object SignUpList = DAL_product.DAL_GET_User(SiteName, new String[]{
            "GET_USER_LIST", sCode, sName,"",sComp, sLoc,"","","",
            sOrder, Integer.toString(page), Integer.toString(rows)});

        BLL_Common.Common_Object SignUpTotalRow = DAL_product.DAL_GET_User(SiteName, new String[]{
            "COUNT_USER_LIST", sCode, sName,"", sComp, sLoc,"","","",
            "", "", ""});

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
        }

        //return json data to JSP page
        out.print(json);
        out.flush();
        out.close();
    }  
    
    
    protected void Get_UserMenu(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        String SiteName = (String) session.getAttribute("SiteName");
        
        BLL_Common BLL_Common = new BLL_Common();
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        ArrayList items = new ArrayList();        
        String sMnu = null;
        String sMnuType = null;
        String sMnuChild = null;
        String sMnuParent = null;
        String sSubParentCode = null;
        String sLastParentMnuType = null; //menu01tgl
        String sLastParentMnuHasChild = null;
        String sMnuID = null;
        String sSubPrtCode = null;
        String sMnuURL = null;
        Boolean bFirstTime = true;

        ResultSet rs = null;
        ResultSet rsCount = null;
        ResultSet rsSub = null;

        String s_menucode = "";

        //JSON object
        net.sf.json.JSONObject json = new net.sf.json.JSONObject();

        
        int i = 0;
        //int x = 0;
        //Execute all queries here
        try {
           
            BLL_Common.Common_Object mnuList = objUsr.DAL_GET_User(SiteName, new String[]{
            "SEARCH_USERROLEMENU", (String) session.getAttribute("usercode"), "", "", "", "", "", "", "", "", "", ""});
            sMnu = "<navigation>";
           // System.out.println(mnuList.getJSONArray(0));
            
           // if (mnuList.getJSONArray(0).size() > 0) {
              for (int x = 0; x < mnuList.getJSONArray(0).size(); x++) {
                sMnuType = mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_type");// rs.getString("mnu_type");
                sMnuParent = mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_parentcode");//rs.getString("mnu_parentcode");
                sMnuChild = mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_haschild");//rs.getString("mnu_haschild");
                sMnuID = mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_menucode");//rs.getString("mnu_menucode");
                sMnuURL = mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_urlpath");//rs.getString("mnu_urlpath");
                // System.out.println(mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_menucode")); 
                if (bFirstTime) {
                    sLastParentMnuType = sMnuType;
                    sLastParentMnuHasChild = sMnuChild;
                    bFirstTime = false;
                }
                
                if (sMnuType.equals("MN") || sMnuType.equals("SM")) {
                    if (sLastParentMnuHasChild.equals("1")) {
                        if (sMnuType != sLastParentMnuType) {
                            //changes of menu type detected. So check if there is need to generate close tag
                            if (sLastParentMnuType.equals("MN") && sMnuType.equals("MN")) {
                                sMnu = sMnu + " </nav:group>";
                            }

//                            if (sLastParentMnuType.equals("SM") && sMnuType.equals("SM")) {
//                                sMnu = sMnu + " </nav:group>";
//                            }

//                            if (sLastParentMnuType.equals("SM") && sMnuType.equals("MN")) {
//                                sMnu = sMnu + " </nav:group>";
//                               // sMnu = sMnu + " </nav:group>";
//                            }

                        }
                    }
                    sLastParentMnuType = sMnuType;
                    sLastParentMnuHasChild = sMnuChild;
                }
                //generate close tag 

                if (sMnuType.equals("MN") && sMnuChild.equals("0")) {
                    {
                        sMnu = sMnu + "<nav:item data-view=\"/" + mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_menucodename") + "\" data-icon=\"fa fa-lg fa-fw " + mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_menuimg")  + "\" title=\"" + mnuList.getJSONArray(0).getJSONObject(x).getString("mlm_menueng")  + "\" />";
                       
                    }
                }
                if (sMnuType.equals("MN") && sMnuChild.equals("1") && sMnuParent != null) {
                    {
                        sMnu = sMnu + "<nav:group data-icon=\"fa fa-lg fa-fw " +  mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_menuimg") + "\" title=\"" + mnuList.getJSONArray(0).getJSONObject(x).getString("mlm_menueng") + "\">";
                      
                    }
                } 

                else if (sMnuType.equals("FN") && sMnuParent != null) {
                    
                     if (sSubParentCode != null) {
                        
                        if (!sSubParentCode.equals(sMnuParent)) {                           
                            i = 0;
                        }
                    }
                     System.out.println("i-->"  + i);
                    if (i == 0) {
                        BLL_Common.Common_Object Submnu = objUsr.DAL_GET_User(SiteName, new String[]{
                        "SEARCH_USRMENU_BYPARENTCODE", (String) session.getAttribute("usercode"), "", "", "", "", "", mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_parentcode"), "", "", "", ""});
                        
                        for (int j = 0; j < Submnu.getJSONArray(0).size(); j++) {
                            
                        
                            s_menucode = Submnu.getJSONArray(0).getJSONObject(j).getString("mnu_menucode");
                            if (s_menucode != null){
                          
                                if (mnuList.getJSONArray(0).getJSONObject(x).getString("mnu_parentcode").equals(Submnu.getJSONArray(0).getJSONObject(j).getString("mnu_parentcode"))){
                                    sMnu = sMnu + "<nav:item data-view=\"/" + Submnu.getJSONArray(0).getJSONObject(j).getString("mnu_menucodename") + "\" title=\"" + Submnu.getJSONArray(0).getJSONObject(j).getString("mlm_menueng") + "\" />";
                                }
                            }      
                                i = i + 1;
                        }    
                         
                    }
                    
                    sSubParentCode = sMnuParent;

                }

            }
     
            sMnu = sMnu + " </nav:group>";
            sMnu = sMnu + "</navigation>";
        } catch (Exception e1) {
            // TODO Auto-generated catch block
            // TODO Auto-generated catch block
            BLL_Common.write_log(e1.toString(), "");
            //ex.printStackTrace(); 
           // BLL_Common.closeResultSet(rs, "");
            e1.printStackTrace();
        } finally {
           // BLL_Common.closeResultSet(rs, "");
           // BLL_Common.closeResultSet(rsCount, "");
        }

        //return json data to JSP page
        //req.setAttribute("items", items);
        session.setAttribute("items", sMnu);
        //BLL_Common.write_log(sMnu.toString(), "");
         System.out.println("System Menu--> " + sMnu);
        //out.print(sMnu);

        //out.flush();
        //out.close();
    }
    
    
    // pengkee 2016/5/12
    public JSONArray ddlGet(String sMethod, String sParam1, String sParam2, String SiteName) {
        DAL_User CodeDescList = new DAL_User();
        BLL_Common.Common_Object obj = CodeDescList.DAL_GET_UserRole(SiteName, new String[]{sMethod, "","","","1","","1","500"});
        try {
            return obj.getJSONArray(0);
        } catch (NullPointerException e) {
            return null;
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
        
         String method = null;
        method = request.getParameter("SFC");
        if (method.equals("Check_User_Login")) {
            GET_UserLogin(request, response);
        } else if (method.equals("GET_USER_LIST")) {
            try {
                Search_UserList(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (method.equals("VIEW_USER_DETAIL")) {
            try {
                VIEW_USER(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else if (method.equals("UPDATE_USER")) {
            try {
                UPDATE_USER(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }  else if (method.equals("UPDATE_PASSWORD")) {
            try {
                UpdatePassword(request, response);
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
