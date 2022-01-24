package BusinessData;

import java.sql.ResultSet;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;
import BusinessLogic.Medicine;
import BusinessLogic.Patient;

public class DAL_Patient {
    BaseDAL DAL = new BaseDAL();
    
    public BLL_Common.Common_Object DAL_GET_PATIENT(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_PATIENT("
            + "?,?,?,?,?,?" //6                 
            + ")", sIn, new int[]{}, SiteName);
    }   
    
     public BLL_Common.Common_Object DAL_UPDATE_PATIENT(String SiteName, Patient patient, String SP_Method, String userCode) {
    	 
    	 String[] sStringIn = {
    				SP_Method, 
    				patient.getPatientId(), 
    				patient.getName(), 
    				patient.getIcNo(),
    				patient.getDob(),
    	            patient.getContactNo(),
    	            patient.getEmail(),
    	            patient.getGender(),
    	            patient.getAddress(), 
    	            patient.getNationality(),
    	            patient.getEthnicGroup(),
    	            patient.getBloodGroup(),
    	            patient.getHeight(),
    	            patient.getWeight(),
    	            patient.getHealthHistory(),
    	            patient.getAllergyNotes(),
    	            patient.getIsSmoking(),
    	            patient.getIsAlcohol(),
    	            patient.getIsPregnant(),
    	            patient.getPanelCompany(),
    	            patient.getEmployeeName(),
    	            patient.getEmployeeCode(),
    	            patient.getRelationship(),  	            
    	            userCode 
    	        };
    	 
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_PATIENT("
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?,?,?,?,?,?,?,?,?," //10
            + "?,?,?,?,?" //5
            + ")", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
}
