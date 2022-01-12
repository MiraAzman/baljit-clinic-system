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
}
