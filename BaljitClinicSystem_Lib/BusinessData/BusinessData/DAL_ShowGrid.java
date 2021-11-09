package BusinessData;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import BusinessData.BaseDAL;
import BusinessLogic.BLL_Common;


public class DAL_ShowGrid {
    BaseDAL DAL = new BaseDAL();
    
    //CODE TYPE SETUP
    public BLL_Common.Common_Object DAL_UPDATE_CODETYPE(String SiteName, String[] sStringIn) {   
        return BaseDAL.Get_Multiple_QueryReturn_No_Commit("SP_TRX_CODETYPE(?,?,?,?,?,?,?)", sStringIn, new int[]{java.sql.Types.VARCHAR}, SiteName);
    }
    
    public BLL_Common.Common_Object DAL_GET_CODETYPE(String SiteName, String[] sIn) {        
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_CODETYPE(?,?,?,?,?,?,?,?)", sIn, new int[]{}, SiteName);
    }
    
    public BLL_Common.Common_Object DAL_GET_ITEMLIST(String SiteName, String[] sIn) {
        
        return BaseDAL.Get_Multiple_QueryReturn("SP_GET_CODETYPE(?,?,?,?,?,?,?,?)", sIn, new int[]{}, SiteName); 
    }
    
}