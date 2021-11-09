package BusinessData;

import BusinessLogic.BLL_Common;
import java.sql.ResultSet;

public class DAL_Common{
	
	BaseDAL DAL = new BaseDAL();
	
        public static class DALCommon_obj {
        
            private String Str_LogPath="";
            private Boolean Bln_SQLError = false;
           
            
            public void setStr_LogPath(String Str_LogPath) {
                this.Str_LogPath = Str_LogPath;
            }

            public void setBln_SQLError(Boolean Bln_SQLError) {
                this.Bln_SQLError = Bln_SQLError;
            }

            public String getStr_LogPath() {
                return Str_LogPath;
            }

            public Boolean isBln_SQLError() {
                return Bln_SQLError;
            }       
        }
        
	//Author: Chong, Date : 2014/06/19
	public String[] Get_ErrorCode(String code_num, DAL_Common.DALCommon_obj DALComObj, String SiteName)
	{
		
		String s_ackcode = "";
                String s_ackmsg = "";
					
		StringBuilder sb = new StringBuilder();
		ResultSet errorcode_rs =null;
                
		try
		{	
			//sb.append("\"" + BaseDAL.DataBase_Schema + "\".SP_ERR_ERRORCODEINFO(?)");
                    sb.append("\"" +  "\".SP_ERR_ERRORCODEINFO(?)");
			                    
                        String[] s_array = new String[] {code_num};
		
			errorcode_rs = BaseDAL.Get_QueryResultSet(sb.toString(), s_array, DALComObj, SiteName);
			if (errorcode_rs.next())
			{
				s_ackcode = errorcode_rs.getString("COD_CODE");
                                s_ackmsg = errorcode_rs.getString("COD_MSG");
			}
			else
			{
				s_ackcode = "AE";
				s_ackmsg = "Error Code not exist for Error Number :" + code_num;    			
			}
		
			
		}
		catch (Exception ex)
		{
				 BLL_Common.write_log(ex.toString(),DALComObj.getStr_LogPath());
				 //ex.printStackTrace();  
		}
                finally
                {BLL_Common.closeResultSet(errorcode_rs,DALComObj.getStr_LogPath()); }
		
		String[] returnList = {s_ackcode, s_ackmsg};
		
		return returnList;
	}
        
}
