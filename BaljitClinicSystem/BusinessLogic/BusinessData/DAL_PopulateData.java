/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessData;

import BusinessLogic.BLL_Common;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author N3355
 */
public class DAL_PopulateData {
     BaseDAL DAL = new BaseDAL();
    private final String CODEDESC_Store_Proc =  "SP_GET_CODEDESC(?,?,?)";
    private final String Running_Number_SP =  "SP_GET_DOCNO(?,?,?)";
    
    public BLL_Common.Common_Object Get_DAL_CODEDESC_Info(String SiteName, String[] sStringIn) {
        return BaseDAL.Get_Multiple_QueryReturn(CODEDESC_Store_Proc, sStringIn, null, SiteName);
    }
    
     public BLL_Common.Common_Object DAL_GetNumber(String SiteName, String[] sIn) {
        return BaseDAL.Get_Multiple_QueryReturn(Running_Number_SP, sIn, new int[]{}, SiteName);
    }    
}
