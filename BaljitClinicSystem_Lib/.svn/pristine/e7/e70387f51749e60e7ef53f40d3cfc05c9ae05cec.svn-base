/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessLogic;

import BusinessData.BaseDAL;
import BusinessData.DAL_Report;
import java.io.File;
import java.sql.SQLException;
import java.util.regex.Matcher;
/**
 *
 * @author N0531
 */
public class BLL_Report {
    
    DAL_Report DAL_Rpt = new DAL_Report();
    
    
//    public String getReportPath2() {
//        String filePath = "";                
//        return BaseDAL.JasperReport_DirPath;
//    }
//    
    
    public String getReportPath(String s_CPPCode) throws SQLException {
        String reportPath =  "";
        
        reportPath = DAL_Rpt.DAL_GET_JasperReportPath(s_CPPCode);
        reportPath = reportPath.replaceAll("\\*", Matcher.quoteReplacement(File.separator));
        return reportPath;
        
    }
}
