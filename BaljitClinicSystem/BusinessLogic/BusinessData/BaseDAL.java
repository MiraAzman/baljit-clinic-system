package BusinessData;

import BusinessLogic.BLL_Common;
import BusinessLogic.Patient;

import com.sun.rowset.CachedRowSetImpl;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import javax.sql.rowset.CachedRowSet;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//import org.objectweb.asm.Type;

public class BaseDAL {  

    public static String SiteCode = null;
    public static String CMSIntegrationType = "";
    public static final String SiteDB_URL =  "jdbc:mysql://localhost:3306/" + "inventorycontrol_sites?serverTimezone=UTC" ;
//    public static final String SiteDB_URL =  "jdbc:mysql://192.168.0.97:3306/" + "inventorycontrol_sites" ; //TEST SERVER
 //   public static final String SiteDB_URL =  "jdbc:mysql://192.168.0.175:3306/" + "inventorycontrol_sites" ; //TEST SERVER    
    
    //for siena linux server
    public static final String SiteDB_USER = "root";      
    public static final String SiteDB_PWD = "1234";  

    public static Connection p_db_conn = null;     
    public static final String JavaMySQLDriver = "com.mysql.jdbc.Driver";
    public static final String MySQLDataBase_Name = "BaljitClinicSystem_empty"; 
     
    //Local
    public static final String MySQL_EstablishConn = "jdbc:mysql://localhost:3306/" + MySQLDataBase_Name + "?serverTimezone=UTC";
    public static final String DataBase_URL = "jdbc:mysql://localhost:3306/" + MySQLDataBase_Name + "?serverTimezone=UTC";//+ ":retrieveMessagesFromServerOnGetMessage=true;";   
   
    //Local
//    public static final String MySQL_EstablishConn = "jdbc:mysql://localhost:3306/" + MySQLDataBase_Name;
//    public static final String DataBase_URL = "jdbc:mysql://localhost:3306/" + MySQLDataBase_Name ;//+ ":retrieveMessagesFromServerOnGetMessage=true;";
//    public static final String DataBase_USER =  "root";  
//    public static final String DataBase_PWD =  "admin";  
    
    //for siena linux server
//    public static  String DataBase_USER =  "root"; //2018jul31
//    public static  String DataBase_PWD =  "admin"; //2018jul31
    
    public static  String DataBase_USER =  "root";
    public static  String DataBase_PWD =  "1234";
//    public static final String DataBase_URL = "jdbc:mysql://192.168.1.133:3306/" + MySQLDataBase_Name ;//+ ":retrieveMessagesFromServerOnGetMessage=true;";   
    
    public static final String Deploy_Path = "/BaljitClinicSystem";
    //public static final String Deploy_Path = "";

   
    public static final String LogFile_Path = "C:/BaljitClinicSystem_log";  //Windows Server
   
    
    //public Jasper folder directories
    public static final String JasperReport_DirPath = "C:"+ File.separator+"BaljitClinicSystem_data"+ File.separator+"JasperReport" + File.separator;  //Windows Server
    public static final String User_Settings_DirPath = "C:"+ File.separator+"BaljitClinicSystem_data"+ File.separator+"settings" + File.separator;    
    //public static final String JasperReport_DirPath = "C:"+ File.separator+"ClaimEX_data"+ File.separator+"JasperReport" + File.separator;  //Windows Server
    //public static final String User_Settings_DirPath = "C:"+ File.separator+"ClaimEX_data"+ File.separator+"settings" + File.separator;  
    //public static final String JasperReport_DirPath = File.separator + "ClaimEX_data"+ File.separator  +"JasperReport" +File.separator ;  //Windows Server
    //public static final String User_Settings_DirPath = File.separator + "ClaimEX_data"+ File.separator +"settings" +File.separator ;
    //public static final String JasperReport_DirPath =  File.separator+"ClaimEXINT_data"+ File.separator+"JasperReport" + File.separator;  //Windows Server
    //public static final String User_Settings_DirPath =  File.separator+"ClaimEXINT_data"+ File.separator+"settings" + File.separator;
    //public static final String JasperReport_DirPath = File.separator +"ClaimEXIN2_data"+File.separator+"JasperReport" + File.separator;  //Windows Server
    //public static final String User_Settings_DirPath = File.separator + "ClaimEXIN2_data" + File.separator + "settings" + File.separator;

    private static String LocalAddress = DataBase_URL;

    public static String getAddress(String SiteName) {
        
//        return LocalAddress;
        return getSiteAddress(SiteName);
    }
    
    public static String getSiteAddress(String SiteName) {
                
    	BLL_Common.write_log("START - getSiteAddress", "");
        String sSiteAddress = "";
        String sHost = "";
        String sDBName = "";
        String sDBUsr = "";
        String sDBPwd = "";
        String sDisplayName = "";
        String sCMSIntegrationType = "";
        Connection conn = null;          
    
        try {          
            Class.forName(JavaMySQLDriver);
            
            BLL_Common.write_log("getConnection: " + SiteDB_URL, "");
            conn = DriverManager.getConnection(SiteDB_URL, SiteDB_USER, SiteDB_PWD);
            conn.setAutoCommit(true);
        } catch (Exception ex) {         
        	BLL_Common.write_log("Exception: " + ex.toString(), "");
            return null;  
        }  
        
        String[] sIn = new String[]{"GET_SITE_LIST", SiteName, "STOCK", "", "",""};
        BLL_Common.Common_Object SiteList = BaseDAL.Get_Multiple_QueryReturn(conn, "SP_GET_SITE(?,?,?,?,?,?)", sIn, new int[]{});
        BLL_Common.write_log("SiteList size: " + SiteList.getJSONArray(0).size(), "");
        
        if (SiteList.getJSONArray(0).size() > 0){
                      
            
            sDisplayName =  SiteList.getJSONArray(0).getJSONObject(0).getString("DisplayName");
            sHost =  SiteList.getJSONArray(0).getJSONObject(0).getString("HostAddress");
            sDBName =  SiteList.getJSONArray(0).getJSONObject(0).getString("DBName");
            sDBUsr =  SiteList.getJSONArray(0).getJSONObject(0).getString("DBUser");
            sDBPwd =  SiteList.getJSONArray(0).getJSONObject(0).getString("DBPwd"); 
            sCMSIntegrationType = SiteList.getJSONArray(0).getJSONObject(0).getString("CMSIntegrationType"); 
            sSiteAddress = "jdbc:mysql://" + sHost + ":3306/" + sDBName + "?serverTimezone=UTC";   
            DataBase_USER = sDBUsr;
            DataBase_PWD = sDBPwd;
            CMSIntegrationType = sCMSIntegrationType;
            BLL_Common.write_log("END - getSiteAddress: " + sSiteAddress, "");
        }
        return sSiteAddress;
    }
    public static BLL_Common.Common_Object  getSiteDisplayName(String SiteName) {
        String sSiteAddress = "";
        String sHost = "";
        String sDBName = "";
        String sDBUsr = "";
        String sDBPwd = "";
        String sDisplayName = "";
        String sCMSIntegrationType = "";
        Connection conn = null;        
        try {          
            Class.forName(JavaMySQLDriver);
            conn = DriverManager.getConnection(SiteDB_URL, SiteDB_USER, SiteDB_PWD);
            conn.setAutoCommit(true);
        } catch (Exception ex) {             
            return null;  
        }                
        String[] sIn = new String[]{               
                "GET_SITE_LIST", SiteName, "STOCK", "", "",""};
        BLL_Common.Common_Object SiteList = BaseDAL.Get_Multiple_QueryReturn(conn, "SP_GET_SITE(?,?,?,?,?,?)", sIn, new int[]{});
        
        if (SiteList.getJSONArray(0).size() > 0){
                      
            
            sDisplayName =  SiteList.getJSONArray(0).getJSONObject(0).getString("DisplayName");
            sHost =  SiteList.getJSONArray(0).getJSONObject(0).getString("HostAddress");
            sDBName =  SiteList.getJSONArray(0).getJSONObject(0).getString("DBName");
            sDBUsr =  SiteList.getJSONArray(0).getJSONObject(0).getString("DBUser");
            sDBPwd =  SiteList.getJSONArray(0).getJSONObject(0).getString("DBPwd"); 
            sCMSIntegrationType = SiteList.getJSONArray(0).getJSONObject(0).getString("CMSIntegrationType"); 
            sSiteAddress = "jdbc:mysql://" + sHost + ":3306/" + sDBName ;   
            DataBase_USER = sDBUsr;
            DataBase_PWD = sDBPwd;
            CMSIntegrationType = sCMSIntegrationType;
                    }
        return SiteList;
    }

    public static void OverideDefault(String sAddress) {
      //  String sTemp = "jdbc:db2://" + sAddress + "/" + DataBase_Name + ":retrieveMessagesFromServerOnGetMessage=true;";
          String sTemp = "jdbc:mysql://" + sAddress + "/" + MySQLDataBase_Name ;//+ ":retrieveMessagesFromServerOnGetMessage=true;";
        LocalAddress = sTemp;
    }


    public static BLL_Common Object_BLL_Common = new BLL_Common();

    //Author: Chong, Date : 2014/06/19
    public static Connection Get_Connection(Boolean blncommit, String connName, String s_path, String SiteName) {
        Connection conn = null;
        //BLL_Common.write_logConn("Open Connection :"+connName);
        try {
          //  Class.forName(JavaDB2Driver);
              Class.forName(JavaMySQLDriver);
            conn = DriverManager.getConnection(getSiteAddress(SiteName), DataBase_USER, DataBase_PWD);
            conn.setAutoCommit(blncommit);
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_Connection Error : " + ex.toString(), s_path);
            Object_BLL_Common.closeEverything(null, null, conn, s_path);
            //ex.printStackTrace();  
        }
        return conn;
    }

    public static Connection Get_Connection(String connName, String s_path, String SiteName) {
        Connection conn = null;
        //BLL_Common.write_logConn("Open Connection :"+connName);
        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);
            conn = DriverManager.getConnection(getAddress(SiteName), DataBase_USER, DataBase_PWD);
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_Connection Error : " + ex.toString(), s_path);
            Object_BLL_Common.closeEverything(null, null, conn, s_path);
            //ex.printStackTrace();  
        }
        return conn;
    }

    // This is only for Jasper Report use
    //Author: Vince, Date : 2015/01/19
    public static Connection Get_Connection(String SiteName) {
        Connection conn = null;
        //BLL_Common.write_logConn("Open Connection :"+connName);
        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);
            conn = DriverManager.getConnection(getSiteAddress(SiteName), DataBase_USER, DataBase_PWD);
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_Connection Error : " + ex.toString(), "");
            Object_BLL_Common.closeEverything(null, null, conn, "");
            //ex.printStackTrace();  
        }
        return conn;
    }

    //Author: Chong, Date : 2014/06/19
    public static void QueryExecute(String sp_query, String[] s_array, String s_path, String SiteName) throws SQLException {

        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String str_array = "";

        try {

            conn = Get_Connection(sp_query, s_path, SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            preparedStatement = conn.prepareStatement(sp_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {

                    preparedStatement.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            preparedStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

        } catch (Exception ex) {
            Object_BLL_Common.write_log("QueryExecute Error : " + ex.toString(), s_path);
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(null, preparedStatement, conn, s_path);
        }

    }

    public static String RemoveStockLedger(String s_comp, String s_loc, String s_stkcode, String s_path, String SiteName) throws SQLException {
        int s_Return = 0;
        String s_ReturnCode ="", sSQL1 = "", sSQL2 = "";
        Connection conn = Get_Connection(SiteName);
        java.sql.PreparedStatement ps1 = null;
        java.sql.PreparedStatement ps2 = null;
        //java.sql.ResultSet rs = null;
        try { 
            Object_BLL_Common.write_log("RemoveStockLedger", s_path);
            conn.setAutoCommit(false);
            sSQL1 = "DELETE FROM stkt_stockledgerdetail ";
            //sSQL1 = sSQL1 + " LEFT JOIN stkt_stockledgerheader b on a.sldl_stockledgerdtlidx = b.sldg_stockledgerhdridx";
            //sSQL1 = sSQL1 + " WHERE b.sldg_company = '" + s_comp + "' AND b.sldg_location = '" + s_loc + "' ";
            sSQL1 = sSQL1 + " WHERE sldl_location = '" + s_loc + "' ";
//pengkee
            if (!s_stkcode.equals(""))                 
            {
                sSQL1 = sSQL1 + " and sldl_stockcode = '" + s_stkcode + "' ";
            }
            Object_BLL_Common.write_log("sSQL1, "+sSQL1, s_path);
            ps1 = conn.prepareStatement(sSQL1);
            s_Return = ps1.executeUpdate();
            
            //if (s_Return == 0){
               // sSQL2 = "DELETE FROM stkt_stockledgerheader ";
                //sSQL2 = sSQL2 + " WHERE sldg_company = '" + s_comp + "' AND sldg_location = '" + s_loc + "' ";
//                
//Object_BLL_Common.write_log("sSQL2,  "+sSQL2, s_path);
                //ps2 = conn.prepareStatement(sSQL2);
                //s_Return = ps2.executeUpdate();
                //
                if(s_Return == 0)
                    s_ReturnCode = "00000";
            //}
            conn.commit();
        }catch(SQLException ex) {
            conn.rollback();
            Object_BLL_Common.write_log("QueryExecute Error : " + ex.toString(), s_path);
            String returnSqlState = ex.getSQLState();
            Object_BLL_Common.write_log("QueryExecute getSQLState : " + ex.getSQLState(), s_path);
            if(returnSqlState.equals("22023")){
                s_ReturnCode = "00022";
            }else{
                s_ReturnCode = "00023";
            }
            
        }
        finally {
            Object_BLL_Common.closeEverything(null, ps1, conn, s_path);
            Object_BLL_Common.closeEverything(null, ps2, conn, s_path);
            conn.setAutoCommit(true);
        }
        return s_ReturnCode;
    }

    //Author: Bryan, Date : 2014/08/28
    public static int QueryExecuteRetInt(String sp_query, String[] s_array, Connection conn) throws SQLException {
        int result = 0;
        CallableStatement callableStatement = null;
        String str_array = "";

        //BLL_Common.write_logConn("Execute " + sp_query);       
        try {

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }

                }
            }
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            result = callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

        } catch (Exception ex) {
            Object_BLL_Common.write_log("QueryExecuteRetInt Error : " + ex.toString(), "");
            //ex.printStackTrace();
        } finally {
            //BLL_Common.closeEverything(null,callableStatement, conn);              
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, "");
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, "");
            }
        }

        return result;
    }

    //Bryan - 2014/10/27
    public static String[] QueryExecute_RetRsltMsg(String sp_query, String[] s_array, Connection conn) throws SQLException {
        CallableStatement callableStatement = null;
        String return_msg = "", return_value = "";
        String[] s_return = {};
        String str_array = "";

        try {

            //conn = Get_Connection(sp_query);
            //BLL_Common.write_logConn("Execute " + sp_query);
            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);
            callableStatement.registerOutParameter(s_array.length + 2, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            return_value = callableStatement.getString(s_array.length + 1);
            return_msg = callableStatement.getString(s_array.length + 2);

            s_return = new String[]{return_value, return_msg};
        } catch (Exception ex) {
            Object_BLL_Common.write_log("QueryExecute_RetRsltMsg Error : " + ex.toString(), "");

            //ex.printStackTrace();
        } finally {
            // BLL_Common.closeEverything(null,callableStatement, null); 
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, "");
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, "");
            }
        }
        return s_return;
    }
    
       

    //Author: Kenji, Date : 2015-06-03
    public static String[] QueryExecute_RetRsltMsg3out(String sp_query, String[] s_array, Connection conn) throws SQLException {
        CallableStatement callableStatement = null;
        String return_msg = "", return_value = "", return_Index = "";
        String[] s_return = {};
        String str_array = "";

        try {

            //conn = Get_Connection(sp_query);
            //BLL_Common.write_logConn("Execute " + sp_query);
            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);
            callableStatement.registerOutParameter(s_array.length + 2, Types.VARCHAR);
            callableStatement.registerOutParameter(s_array.length + 3, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            return_value = callableStatement.getString(s_array.length + 1);
            return_msg = callableStatement.getString(s_array.length + 2);
            return_Index = callableStatement.getString(s_array.length + 3);
            s_return = new String[]{return_value, return_msg, return_Index};
        } catch (Exception ex) {
            Object_BLL_Common.write_log("QueryExecute_RetRsltMsg Error : " + ex.toString(), "");

            //ex.printStackTrace();
        } finally {
            // BLL_Common.closeEverything(null,callableStatement, null); 
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, "");
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, "");
            }
        }
        return s_return;
    }

    //Author: Bryan, Date : 2014/10/27
    public static String[] QueryExecute_RetOut(String sp_query, String[] s_array, Connection conn) throws SQLException {
        int result = 0;
        CallableStatement callableStatement = null;
        String s_return = "";
        String str_array = "";

        //BLL_Common.write_logConn("Execute " + sp_query);
        try {

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            result = callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            s_return = callableStatement.getString(s_array.length + 1);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("QueryExecute_RetOut Error : " + ex.toString(), "");

            //ex.printStackTrace();
        } finally {
            //BLL_Common.closeEverything(null,callableStatement, conn);              
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, "");
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, "");
            }
        }
        String i_result = Integer.toString(result);
        return new String[]{i_result, s_return};
    }

    //Author: Chong, Date : 2014/06/19
    public static ResultSet Get_QueryResultSet(String sp_query, DAL_Common.DALCommon_obj DALComObj, String SiteName) throws SQLException {

        ResultSet dt = null;
        Connection conn = null;
        Statement sta = null;

        CachedRowSet rowset = new CachedRowSetImpl();

        try {

            conn = Get_Connection(sp_query, DALComObj.getStr_LogPath(), SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            sta = conn.createStatement();

            Object_BLL_Common.write_log("start call " + sp_query, "SP_Log");
            dt = sta.executeQuery("{call " + sp_query + "}");
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            rowset.populate(dt);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), DALComObj.getStr_LogPath());
            DALComObj.setBln_SQLError(Boolean.TRUE);
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(dt, sta, conn, DALComObj.getStr_LogPath());
        }

        return rowset;
    }

    public static ResultSet Get_QueryResultSet(String sp_query, String SiteName) throws SQLException {

        ResultSet dt = null;
        Connection conn = null;
        Statement sta = null;

        CachedRowSet rowset = new CachedRowSetImpl();

        try {

            conn = Get_Connection(sp_query, "", SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            sta = conn.createStatement();

            Object_BLL_Common.write_log("start call " + sp_query, "SP_Log");
            dt = sta.executeQuery("{call " + sp_query + "}");
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            rowset.populate(dt);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(dt, sta, conn, "");
        }

        return rowset;
    }

    public static ResultSet Get_QueryResultSet(String sp_query, String[] s_array, DAL_Common.DALCommon_obj DALComObj, String SiteName) throws SQLException {

        ResultSet dt = null;
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";

        CachedRowSet rowset = new CachedRowSetImpl();

        try {

            conn = Get_Connection(sp_query, DALComObj.getStr_LogPath(), SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";

            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            dt = stmt.executeQuery();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            rowset.populate(dt);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), DALComObj.getStr_LogPath());
            BLL_Common.write_log(ex.toString(),"Log_123");
            DALComObj.setBln_SQLError(Boolean.TRUE);
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(dt, stmt, conn, DALComObj.getStr_LogPath());
        }

        return rowset;
    }

    public static ResultSet Get_QueryResultSet(String sp_query, String[] s_array, String SiteName) throws SQLException {

        ResultSet dt = null;
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";

        CachedRowSet rowset = new CachedRowSetImpl();

        try {

            conn = Get_Connection(sp_query, "", SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";

            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            dt = stmt.executeQuery();

            rowset.populate(dt);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(dt, stmt, conn, "");
        }

        Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");
        return rowset;
    }
    
    public static ResultSet Get_QueryResultSet2(String sp_query, String[] s_array, String SiteName) throws SQLException {

        ResultSet dt = null;
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";

        CachedRowSet rowset = new CachedRowSetImpl();

        try {

            conn = Get_Connection(sp_query, "", SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";

            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            
          //  stmt.registerOutParameter(s_array.length + 1, Types.VARCHAR);
          //  stmt.registerOutParameter(s_array.length + 2, Types.VARCHAR);
            
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            dt = stmt.executeQuery();

            rowset.populate(dt);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(dt, stmt, conn, "");
        }

        Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");
        return rowset;
    }

    public static Object[] Get_QueryResultSet_WithParam(String sp_query, String[] s_array, String SiteName) throws SQLException {

        ResultSet dt = null;
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "", s_return = "AE001";

        CachedRowSet rowset = new CachedRowSetImpl();

        try {

            conn = Get_Connection(sp_query, "", SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";

            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            stmt.registerOutParameter(s_array.length + 1, Types.VARCHAR);
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            dt = stmt.executeQuery();
            s_return = stmt.getString(s_array.length + 1);
            rowset.populate(dt);

        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(dt, stmt, conn, "");
        }

        Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");
        return new Object[]{rowset, s_return};
    }

    //Author: Chong, Date : 2014/06/19
    public static String Get_QueryStatus(String sp_query, String[] s_array, Connection conn, String s_path) throws SQLException {

        //Connection conn = null ;
        String s_return = "AA000";
        CallableStatement callableStatement = null;
        //BLL_Common.write_logConn("Execute " + sp_query);
        String str_array = "";

        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);

                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }

                }
            }
            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            s_return = callableStatement.getString(s_array.length + 1);
        } catch (Exception ex) {
            //ex.printStackTrace();                      
            Object_BLL_Common.write_log("Get_QueryStatus Error : " + ex.toString(), s_path);
            s_return = "AE001";
        } finally {
            //BLL_Common.closeEverything(null,callableStatement, conn);
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, s_path);
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, s_path);
            }
        }

        return s_return;

    }

    //Author: Chong, Date : 2014/06/19
    public static String[] Get_QueryStatus_2(String sp_query, String[] s_array, Connection conn, String s_path) throws SQLException {

        //Connection conn = null ;
        String s_return = "AA000";
        String s_return2 = "";
        String str_array = "";

        CallableStatement callableStatement = null;

        //BLL_Common.write_logConn("Execute " + sp_query);
        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);
            //conn = DriverManager.getConnection(getAddress(), DataBase_USER, DataBase_PWD);
            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);

                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            //callableStatement.setInt(1, 13); 	          		     
            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);
            callableStatement.registerOutParameter(s_array.length + 2, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            s_return = callableStatement.getString(s_array.length + 1);
            s_return2 = callableStatement.getString(s_array.length + 2);

        } catch (Exception ex) {
            //ex.printStackTrace();
            Object_BLL_Common.write_log("Get_QueryStatus_ Error : " + ex.toString(), s_path);
            s_return = "AE001";
        } finally {
            Object_BLL_Common.closeEverything(null, callableStatement, null, s_path);
        }

        return new String[]{s_return, s_return2};
    }

    //Author: Bryan, Date : 2014/10/09
    public static String[] QueryExecuteRetRslt(String sp_query, String[] s_array, Connection conn) throws SQLException {
        int result = 0;
        CallableStatement callableStatement = null;
        String index = "";
        String str_array = "";

        //BLL_Common.write_logConn("Execute " + sp_query);
        try {

            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);
            //conn = DriverManager.getConnection(getAddress(), DataBase_USER, DataBase_PWD);

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);

                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            result = callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            index = callableStatement.getString(s_array.length + 1);

        } catch (Exception ex) {
            //ex.printStackTrace();
            Object_BLL_Common.write_log("QueryExecuteRetRslt Error : " + ex.toString(), "");

        } finally {
            //BLL_Common.closeEverything(null,callableStatement, conn);         
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, "");
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, "");
            }
        }

        return new String[]{Integer.toString(result), index};
    }

    //Author: Chong, Date : 2014/10/21
    public static CallableStatement Get_QueryReturn(String sp_query, String[] s_array, Integer s_in, Integer s_out, Connection conn, DAL_Common.DALCommon_obj DALComObj) throws SQLException {

        CallableStatement callableStatement = null;
        //BLL_Common.write_logConn("Execute " + sp_query);
        String str_array = "";

        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);
            //conn = DriverManager.getConnection(getAddress(), DataBase_USER, DataBase_PWD);

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_in > 0) {
                for (int i = 0; i < s_in; i++) {

                    callableStatement.setString(i + 1, s_array[i]);

                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            if (s_out > 0) {
                for (int j = s_in; j < s_in + s_out; j++) {
                    callableStatement.registerOutParameter(j + 1, Types.VARCHAR);
                }
            }

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

        } catch (Exception ex) {
            //ex.printStackTrace();            
            Object_BLL_Common.write_log("Get_QueryReturn Error : " + ex.toString(), DALComObj.getStr_LogPath());
            Object_BLL_Common.closeEverything(null, callableStatement, conn, DALComObj.getStr_LogPath());
            DALComObj.setBln_SQLError(Boolean.TRUE);
        }

        return callableStatement;

    }

    public static CallableStatement Get_QueryReturn(String sp_query, String[] s_array, Integer s_in, Integer s_out, Connection conn) throws SQLException {

        CallableStatement callableStatement = null;
        //BLL_Common.write_logConn("Execute " + sp_query);
        String str_array = "";

        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);
            //conn = DriverManager.getConnection(getAddress(), DataBase_USER, DataBase_PWD);

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_in > 0) {
                for (int i = 0; i < s_in; i++) {

                    callableStatement.setString(i + 1, s_array[i]);

                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            if (s_out > 0) {
                for (int j = s_in; j < s_in + s_out; j++) {
                    callableStatement.registerOutParameter(j + 1, Types.VARCHAR);
                }
            }

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

        } catch (Exception ex) {
            //ex.printStackTrace();            
            Object_BLL_Common.write_log("Get_QueryReturn Error : " + ex.toString(), "");
            Object_BLL_Common.closeEverything(null, callableStatement, conn, "");

        }

        return callableStatement;

    }

    public static String Get_QueryIndex(String sp_query, String[] s_array, Connection conn, String s_path) throws SQLException {

        //Connection conn = null ;
        String s_Status = "AA000";
        String s_Index = "AA000";
        CallableStatement callableStatement = null;
        String str_array = "";

        //BLL_Common.write_logConn("Execute " + sp_query);
        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);

            callableStatement = conn.prepareCall("{call " + sp_query + "}");

            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    callableStatement.setString(i + 1, s_array[i]);

                    if (str_array == "") {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }

                }
            }
            callableStatement.registerOutParameter(s_array.length + 1, Types.VARCHAR);
            callableStatement.registerOutParameter(s_array.length + 2, Types.VARCHAR);

            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            callableStatement.executeUpdate();
            Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");

            s_Status = callableStatement.getString(s_array.length + 1);
            s_Index = callableStatement.getString(s_array.length + 2);

        } catch (Exception ex) {
            //ex.printStackTrace();                      
            Object_BLL_Common.write_log("Get_QueryStatus Error : " + ex.toString(), s_path);
            s_Status = "AE001";
            s_Index = "AE001";
        } finally {
            //BLL_Common.closeEverything(null,callableStatement, conn);
            if (conn.getAutoCommit() == false) {
                Object_BLL_Common.closeEverything(null, callableStatement, null, s_path);
            } else {
                Object_BLL_Common.closeEverything(null, callableStatement, conn, s_path);
            }
        }

        Object_BLL_Common.write_log("s_Index : " + s_Index, "");
        return s_Index;

    }


    public static BLL_Common.Common_Object Get_Multiple_QueryReturn(Connection conn, String sp_query, String[] s_array, int[] typeIn) {
//        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";
        List<JSONArray> rsList = new ArrayList<JSONArray>();
        List<Object> objectList = new ArrayList<Object>();
        try {
//            conn = Get_Connection();
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";
            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array.equals("")) {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            int arrayLength = s_array.length;
            int typeLength = 0;
            if (typeIn != null) {
                typeLength = typeIn.length;
                for (int i = 0; i < typeLength; i++) {
                    stmt.registerOutParameter(arrayLength + i + 1, typeIn[i]);
                }
            }
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            boolean results = stmt.execute();
            while (results) {
                rsList.add(BLL_Common.rsToJSONArray(stmt.getResultSet()));
                results = stmt.getMoreResults();
            }
            if (typeIn != null) {
                for (int i = 0; i < typeLength; i++) {
                    objectList.add(stmt.getObject(arrayLength + i + 1));
                }
            }
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(null, stmt, conn, "");
        }

        Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");
        return new BLL_Common.Common_Object(rsList, objectList);
    }

    
    public static BLL_Common.Common_Object Get_Multiple_QueryReturn(String sp_query, String[] s_array, int[] typeIn, String SiteName) {
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";
        List<JSONArray> rsList = new ArrayList<JSONArray>();
        List<Object> objectList = new ArrayList<Object>();
        try {
            conn = Get_Connection(SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";
            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array.equals("")) {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            int arrayLength = s_array.length;
            int typeLength = 0;
            if (typeIn != null) {
                typeLength = typeIn.length;
                for (int i = 0; i < typeLength; i++) {
                    stmt.registerOutParameter(arrayLength + i + 1, typeIn[i]);
                }
            }
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            boolean results = stmt.execute();
            while (results) {
                rsList.add(BLL_Common.rsToJSONArray(stmt.getResultSet()));
                results = stmt.getMoreResults();
            }
            if (typeIn != null) {
                for (int i = 0; i < typeLength; i++) {
                    objectList.add(stmt.getObject(arrayLength + i + 1));
                }
            }
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            //ex.printStackTrace();  
        } finally {
            Object_BLL_Common.closeEverything(null, stmt, conn, "");
        }

        Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");
        return new BLL_Common.Common_Object(rsList, objectList);
    }

    public static BLL_Common.Common_Object Get_Multiple_QueryReturn_No_Commit(String sp_query, String[] s_array, int[] typeIn, String SiteName) {
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";
        List<JSONArray> rsList = new ArrayList<JSONArray>();
        List<Object> objectList = new ArrayList<Object>();
        try {
            conn = Get_Connection(false, "", "", SiteName);
            //BLL_Common.write_logConn("Execute " + sp_query);
            String get_query = "{call " + sp_query + "}";
            stmt = conn.prepareCall(get_query);
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    stmt.setString(i + 1, s_array[i]);
                    if (str_array.equals("")) {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }
            int arrayLength = s_array.length;
            int typeLength = 0;
            if (typeIn != null) {
                typeLength = typeIn.length;
                for (int i = 0; i < typeLength; i++) {
                    stmt.registerOutParameter(arrayLength + i + 1, typeIn[i]);
                }
            }
            Object_BLL_Common.write_log("start call " + sp_query + "(" + str_array + ")", "SP_Log");
            boolean results = stmt.execute();
            while (results) {
                rsList.add(BLL_Common.rsToJSONArray(stmt.getResultSet()));
                results = stmt.getMoreResults();
            }
            if (typeIn != null) {
                for (int i = 0; i < typeLength; i++) {
                    objectList.add(stmt.getObject(arrayLength + i + 1));
                }
            }
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            objectList.add(ex.toString());  //Author: LLT, Date : 2015/03/04 - add this line to trigger the error message
            //ex.printStackTrace();  
        }

        Object_BLL_Common.write_log("end call " + sp_query, "SP_Log");
        return new BLL_Common.Common_Object(rsList, objectList, conn, stmt);
    }
    
    public static Boolean call_SP_TRX_PATIENT(String[] s_array, String SiteName, Patient patient) {
        Connection conn = null;
        CallableStatement stmt = null;
        String str_array = "";
        List<JSONArray> rsList = new ArrayList<JSONArray>();
        List<Object> objectList = new ArrayList<Object>();
        Boolean bReturn = false;
        
        String sp_query = "{call SP_TRX_PATIENT("
                + "?,?,?,?,?,?,?,?,?,?," //10
                + "?,?,?,?,?,?,?,?,?,?," //10
                + "?,?,?,?,?)}"; //5
        
        try {
            conn = Get_Connection(false, "", "", SiteName);                     
            
            //String get_query = "{call " + sp_query + "}";
            stmt = conn.prepareCall(sp_query);
            
            Object_BLL_Common.write_log("call_SP_TRX_PATIENT", "");
            Object_BLL_Common.write_log("name: " + patient.getName(), "");
            Object_BLL_Common.write_log("email: " + patient.getEmail(), "");
            stmt = patient.set_SP_TRX_PATIENT_param(stmt, s_array);
            
            if (s_array.length > 0) {
                for (int i = 0; i < s_array.length; i++) {
                    if (str_array.equals("")) {
                        str_array += "'" + s_array[i] + "'";
                    } else {
                        str_array += ",'" + s_array[i] + "'";
                    }
                }
            }

            Object_BLL_Common.write_log("start call SP_TRX_PATIENT (" + str_array + ")", "SP_Log");
            boolean results = stmt.execute();
            while (results) {
                rsList.add(BLL_Common.rsToJSONArray(stmt.getResultSet()));
                results = stmt.getMoreResults();
            }
            objectList.add(stmt.getObject(25));
        } catch (Exception ex) {
            Object_BLL_Common.write_log("Get_QueryResultSet Error : " + ex.toString(), "");
            objectList.add(ex.toString());  //Author: LLT, Date : 2015/03/04 - add this line to trigger the error message
            Object_BLL_Common.write_log("Error: " + ex.fillInStackTrace(), "SP_Log");
            ex.printStackTrace();  
        }

        Object_BLL_Common.write_log("end call SP_TRX_PATIENT", "SP_Log");
        
        BLL_Common.Common_Object obj = new BLL_Common.Common_Object(rsList, objectList, conn, stmt);
        
        try {
            if (obj.getObjectArray(0).toString().equals("00000")) {

            	obj.commit();
                bReturn = true;     
                Object_BLL_Common.write_log("Commit successfully!", "SP_Log");
            } 
            else {
            	Object_BLL_Common.write_log("Rollback!", "SP_Log");
            	obj.rollback();
            }
        } catch (Exception e) {
        	Object_BLL_Common.write_log("Error1: " + e.toString(), "SP_Log");
        	Object_BLL_Common.write_log("Error1: " + e.fillInStackTrace(), "SP_Log");
            try {
            	obj.rollback();
            } catch (SQLException ex) {
                bReturn = false;
            }
        }
        return bReturn;
    }
}

