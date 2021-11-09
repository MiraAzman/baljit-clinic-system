package BusinessData;

import java.sql.ResultSet;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;

public class DAL_Appointment {
    BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_APPOINTMENT(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_APPOINTMENT("
            + "?,?,?,?" //4                 
            + ")", sIn, new int[]{}, SiteName);
    }   
    
     public BLL_Common.Common_Object DAL_UPDATE_APPOINTMENT(String SiteName, String[] sStringIn) {
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_APPOINTMENT("
            + "?,?,?,?,?,?,?,?,?,?" //10
            + ")", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
}
