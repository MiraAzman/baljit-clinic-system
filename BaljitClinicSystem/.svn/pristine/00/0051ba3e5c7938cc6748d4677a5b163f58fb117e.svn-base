<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*"%> 
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.lowagie.text.*"%>
<%@ page import="com.lowagie.text.pdf.*"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="BusinessLogic.BLL_Common"%>
<%@ page import="BusinessData.BaseDAL"%>
<%@ page import="net.sf.json.JSONObject"%>

<%
    //String s_loginid = (String) session.getAttribute("loginid");
    //String s_loginpwd = (String) session.getAttribute("loginpwd");

    //String s_bussapp = (String) session.getAttribute("bussapp");
    

        BLL_Common BLL_Common = new BLL_Common();
        String User_ID = "admin";
        String User_App = "ADMIN";
        JSONObject jsonObj = JSONObject.fromObject(BLL_Common.Decryption(User_ID + User_App, request.getParameter("param1")));
        String sFilePath = BLL_Common.Decryption(User_ID + User_App, request.getParameter("param2")).concat(".jasper");
       // String sStoreProp = "\"" + BaseDAL.DataBase_Schema + "\"." + BLL_Common.Decryption(User_ID + User_App, request.getParameter("param3"));
         String sStoreProp =  "\"." + BLL_Common.Decryption(User_ID + User_App, request.getParameter("param3"));
        JSONObject jsonObjParam = JSONObject.fromObject(BLL_Common.Decryption(User_ID + User_App, request.getParameter("param4")));
//                Connection conn = null;
      
        ServletOutputStream outStream = null;
        try {
//                    conn = BaseDAL.Get_Connection();
//                    File reportFile = new File(application.getRealPath(sFilePath));
            Map Param = new BLL_Common().toMap(jsonObjParam);
            String[] sArray = BLL_Common.toArray(jsonObj);
            BaseDAL DAL = new BaseDAL();
            ResultSet resultSet = DAL.Get_QueryResultSet(sStoreProp, sArray);
            byte[] bytes = JasperRunManager.runReportToPdf(sFilePath, Param, new JRResultSetDataSource(resultSet));

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
        } catch (Exception ex) {
                    ex.printStackTrace();
        } finally {
//                    BLL_Common.closeEverything(null, null, conn, "");
            outStream.flush();
            outStream.close();
        }
    
%>

