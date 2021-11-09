package BusinessData;

import java.sql.ResultSet;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;

public class DAL_Patient {
    BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_PATIENT(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_PATIENT("
            + "?,?,?,?,?,?" //6                 
            + ")", sIn, new int[]{}, SiteName);
    }   
    
     public BLL_Common.Common_Object DAL_UPDATE_PATIENT(String SiteName, String[] sStringIn) {
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_PATIENT("
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?,?,?,?" //5
            + ")", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
}
