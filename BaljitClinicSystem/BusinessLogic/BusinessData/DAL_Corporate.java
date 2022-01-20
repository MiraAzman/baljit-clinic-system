package BusinessData;

import java.sql.ResultSet;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;
import BusinessLogic.Corporate;

public class DAL_Corporate {
    BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_CORPORATE(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_CORPORATE("
            + "?,?,?,?,?" //5             
            + ")", sIn, new int[]{}, SiteName);
    }   
    
    public BLL_Common.Common_Object DAL_UPDATE_CORPORATE(String SiteName, Corporate corporate, String SP_Method, String userCode) {
    	
    	String[] sStringIn = {
    			SP_Method,
                corporate.getCorporateId(), 
                corporate.getName(),
                corporate.getAddress(), 
                corporate.getContactPerson(),
                corporate.getTelNo(), 
                corporate.getFaxNo(),
                corporate.getEmail(), 
                corporate.getWebsite(), 
                corporate.getIsActive(), 
                userCode 
            };
    	
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_CORPORATE("
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?" //2
            + ")", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
}
