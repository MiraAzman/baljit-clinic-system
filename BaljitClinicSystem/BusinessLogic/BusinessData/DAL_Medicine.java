package BusinessData;

import java.sql.ResultSet;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;
import Model.Medicine;

public class DAL_Medicine {
    BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_MEDICINE(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_MEDICINE("
            + "?,?,?,?,?" //5             
            + ")", sIn, new int[]{}, SiteName);
    }   
    
    public BLL_Common.Common_Object DAL_UPDATE_MEDICINE(String SiteName, String[] sStringIn, Medicine medicine) {
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_MEDICINE("
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?" //2
            + ")", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
}
