package BusinessData;

import java.sql.ResultSet;
//import BusinessLogic.BLL_CorpProvider;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;


/**
 *
 * @author N3355
 */
public class DAL_Role {
    
     BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_ROLE(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_ROLE(?,?,?,?,?,"                  
                    + "?,?,?,?)", sIn, new int[]{}, SiteName); //9 params
    }
    
    public BLL_Common.Common_Object DAL_ADDEDIT_ROLE(String SiteName, String[] sStringIn) {
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_ROLE(?,?,?,?,?,?,?,?,?,?,"              
                + "?,?,?,?,?,?,?,?)", sStringIn, new int[]{java.sql.Types.VARCHAR, java.sql.Types.VARCHAR}, SiteName);
    }
    
    public BLL_Common.Common_Object DAL_ADDEDIT_ROLEFC(String SiteName, String[] sStringIn) {
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_ROLE(?,?,?,?,?,?,?,?,?,?,"              
                + "?,?,?,?,?,?,?,?)", sStringIn, new int[]{java.sql.Types.VARCHAR, java.sql.Types.VARCHAR}, SiteName);
    }
    
    public BLL_Common.Common_Object DAL_GET_MENU(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_MENU(?,?,?,?,?,"                  
                    + "?,?,?,?,?)", sIn, new int[]{}, SiteName);
    }
    
}
