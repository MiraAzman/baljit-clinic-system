package BusinessData;

import java.sql.ResultSet;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;
import BusinessLogic.Medicine;

public class DAL_Medicine {
    BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_MEDICINE(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_MEDICINE("
            + "?,?,?,?,?" //5             
            + ")", sIn, new int[]{}, SiteName);
    }   
    
    public BLL_Common.Common_Object DAL_UPDATE_MEDICINE(String SiteName, Medicine medicine, String SP_Method, String userCode) {
    	
    	String[] sStringIn = {
			SP_Method, 
            medicine.getMedicineId(), 
            medicine.getName(), 
            medicine.getUom(),
            medicine.getUnitCost(),
            medicine.getPrice(),
            medicine.getIsActive(),
            medicine.getBatchNo(),
            medicine.getExpiryDate(), 
            medicine.getQty(),
            userCode 
        };
    	
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_MEDICINE("
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?" //2
            + ")", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
}
