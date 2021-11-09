<%@page import="net.sf.jasperreports.export.SimpleXlsxReportConfiguration"%>
<%@page import="net.sf.jasperreports.export.SimpleOutputStreamExporterOutput"%>
<%@page import="net.sf.jasperreports.export.SimpleExporterInput"%>
<%@page import="net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter"%>
<%@ page contentType="application/pdf" pageEncoding="UTF-8"%>
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
    String s_loginid = (String) session.getAttribute("loginid");
    String s_loginpwd = (String) session.getAttribute("loginpwd");
    String SiteName = (String) session.getAttribute("SiteName");

    String s_bussapp = (String) session.getAttribute("bussapp");
    if (s_loginid == null || s_loginpwd == null || s_bussapp == null) {
//        String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
//        response.sendRedirect(response.encodeRedirectURL(contextPath));
        response.sendError(500);
    } else {
        BLL_Common commonObj = new BLL_Common();
        String User_ID = session.getAttribute("loginid").toString();
        String User_App = session.getAttribute("bussapp").toString();
        JSONObject jsonObj = JSONObject.fromObject(commonObj.Decryption(User_ID + User_App, request.getParameter("param1")));
        
        String sFilePath = commonObj.Decryption(User_ID + User_App, request.getParameter("param2")).concat(".jasper");
        //String paramParam = request.getParameter("param3");
        //String path1 = BLL_Common.Decryption(User_ID + User_App, request.getParameter("param3"));
       // String sStoreProp = "\"" + BaseDAL.DataBase_Schema + "\"." + commonObj.Decryption(User_ID + User_App, request.getParameter("param3"));
         String sStoreProp = commonObj.Decryption(User_ID + User_App, request.getParameter("param3"));

//                Connection conn = null;
        ServletOutputStream outStream = null;
        try {
            File f = new File(sFilePath);
            if (!f.exists()) {
                String filename = "/WEB-INF/JasperReport/" + f.getName();
                request.getContextPath();
                sFilePath = getServletContext().getRealPath(filename);
            }
            
            JSONObject jsonObjParam = JSONObject.fromObject(commonObj.Decryption(User_ID + User_App, request.getParameter("param4")));
            

            Map Param = new BLL_Common().toMap(jsonObjParam);
                String[] sArray = commonObj.toArray(jsonObj);
                BaseDAL DAL = new BaseDAL();
                ResultSet resultSet = DAL.Get_QueryResultSet(sStoreProp, sArray, SiteName);
                JRResultSetDataSource jrRS = new JRResultSetDataSource(resultSet);
                Map parameters = new HashMap();
                parameters.put(JRParameter.IS_IGNORE_PAGINATION, Boolean.TRUE);                
                JasperPrint print = JasperFillManager.fillReport(sFilePath,parameters, jrRS);
                response.setContentType("application/vnd.ms-excel");
                String dlfilename = f.getName();
                dlfilename = dlfilename.substring(0,dlfilename.lastIndexOf("."));
                response.setHeader("Content-disposition", "attachment; filename=" + dlfilename + ".xlsx");
                outStream = response.getOutputStream();
                JRXlsxExporter exporter = new JRXlsxExporter();
                exporter.setExporterInput(new SimpleExporterInput(print));
                exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outStream));
                SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration(); 
                configuration.setRemoveEmptySpaceBetweenRows(true);
                configuration.setDetectCellType(true);
                configuration.setWhitePageBackground(false);
                configuration.setRemoveEmptySpaceBetweenColumns(true);
                exporter.setConfiguration(configuration);
                exporter.exportReport();
                outStream.flush(); 
        } catch (IOException ex) {
            String abc = ex.toString();
            out.println(abc);
            BLL_Common.write_log(abc, "");
            out.println(abc);
            response.sendError(500);
        } catch (JRException jex) {
            String abc = jex.toString();
            out.println(abc);
            BLL_Common.write_log(abc, "");
            response.sendError(500);
        } catch (Exception x) {
            String abc = x.toString();
            out.println(abc);
            BLL_Common.write_log(abc, "");
            response.sendError(500);
        } finally {
            if (outStream != null) {
                outStream.close();
            }
        }
    }
%>
