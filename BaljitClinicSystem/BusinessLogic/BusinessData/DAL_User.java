package BusinessData;

import BusinessLogic.BLL_Common;
import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.regex.Matcher;


/**
 *
 * @author N3355
 */
public class DAL_User {
    BaseDAL DAL = new BaseDAL();
    BLL_Common BLL_Common = new BLL_Common();
    
    
    public BLL_Common.Common_Object DAL_GET_User(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_USER(?,?,?,?,?,?,?,?,?,?,"                  
                    + "?,?)", sIn, new int[]{}, SiteName);
    }
    
    //pengkee 2016/5/12 - Add usr_role
    public BLL_Common.Common_Object DAL_UPDATE_USER(String SiteName, String[] sStringIn) {       
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_USER(?,?,?,?,?,?,?,?,?,?,"
            + "?,?,?,?)", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
      
    
//    public String[] DAL_Check_UserLogin(String s_method, String s_username, String s_password, String s_businessapp) throws SQLException {
////        String s_QueryStatus = null;
//        String s_usercode = "";
//        String s_returnmsg = "";
//        String s_return_businessapp = "";
//        String s_return_cppcode = "";
//        String s_return_cppname = "";
//        String s_return_fullname = "";
//        String s_return_sessiondur = "";
//        String s_return_jasperPath = "";
//        String s_encryptpwd;
//        String s_return_expiryDay ="";
//        String s_return_UserExpiration ="";
//        String s_return_HomeCountryCode = "";
//        
//        CallableStatement callableStatement = null;
////        ResultSet dt = null;
//
//        BLL_Common BLL_Common = new BLL_Common();
//
//        StringBuilder sb_pv = new StringBuilder();
//        sb_pv.append("\"" + BaseDAL.DataBase_Schema + "\".SP_USR_CHECKLOGIN(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
//        Connection conn_claimdb = BaseDAL.Get_Connection(true, sb_pv.toString(), "");
//
//        if (conn_claimdb != null) {
//            try {
//                s_encryptpwd = BLL_Common.MD5(s_password);
//
//                String[] s_array = new String[]{s_method, s_username, s_encryptpwd, s_businessapp};
//
//                Integer int_in = 4;
//                Integer int_out =11;
//
//                callableStatement = BaseDAL.Get_QueryReturn(sb_pv.toString(), s_array, int_in, int_out, conn_claimdb);
//
//                s_usercode = callableStatement.getString(5);
//                s_returnmsg = callableStatement.getString(6);
//                s_return_businessapp = callableStatement.getString(7);
//                s_return_cppcode = callableStatement.getString(8);
//                s_return_cppname = callableStatement.getString(9);
//                s_return_fullname = callableStatement.getString(10);
//                s_return_sessiondur = callableStatement.getString(11);
//                s_return_jasperPath = callableStatement.getString(12);
//                s_return_expiryDay = callableStatement.getString(13);
//                s_return_UserExpiration = callableStatement.getString(14);
//                s_return_HomeCountryCode = callableStatement.getString(15);
//                
//                if(s_return_jasperPath != null && !s_return_jasperPath.equals("")){
//                   s_return_jasperPath = s_return_jasperPath.replaceAll("\\*", Matcher.quoteReplacement(File.separator));
//                }
//            } catch (Exception ex) {
//                BLL_Common.write_log(ex.toString(), "");
//                //ex.printStackTrace();
//                String[] array_return = {s_usercode, ex.toString(), s_return_businessapp, s_return_cppcode, s_return_cppname, s_return_fullname, s_return_sessiondur};
//
//            } finally {
//                BLL_Common.closeEverything(null, callableStatement, conn_claimdb, "");
//            }
//        } else {
//            s_returnmsg = "AE03";
//        }
//        String[] array_return = {s_usercode, s_returnmsg, s_return_businessapp, s_return_cppcode, s_return_cppname, s_return_fullname, s_return_sessiondur, s_return_jasperPath,s_return_expiryDay,s_return_UserExpiration,s_return_HomeCountryCode};
//
//        return array_return;
//    }
    
    
    // pengkee 2016/5/12
     public BLL_Common.Common_Object DAL_GET_UserRole(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_ROLE(?,?,?,?,?,?,?,?)"                  
                    , sIn, new int[]{}, SiteName);
    }
}
