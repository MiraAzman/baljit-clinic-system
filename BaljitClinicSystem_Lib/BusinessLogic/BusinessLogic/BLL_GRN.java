/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessLogic;

import BusinessData.BaseDAL;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import org.json.simple.parser.JSONParser;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 *
 * @author N0535
 */
public class BLL_GRN {
    String s_Return = "";
    String Str_LogPath = "WebServiceLog";
    BLL_Common DAL_CM = new BLL_Common();
    JSONParser parser = new JSONParser();
    
    public String DataTransfer_GRN(String input, String sURL, String sID, String sPW, String SiteName){
        HttpURLConnection conn = null;
        
        try{
            SSLContext ssl_ctx = SSLContext.getInstance("TLS");
            TrustManager[ ] trust_mgr = DAL_CM.get_trust_mgr();
            ssl_ctx.init(null,                // key manager
                         trust_mgr,           // trust manager
                         new SecureRandom()); // random number generator
            //HttpsURLConnection.setDefaultSSLSocketFactory(ssl_ctx.getSocketFactory());
            //-- http://192.168.1.232:8080/HIS_WebServices_Inventory/webresources/UpdateGRN
            //URL url = new URL(sURL + "HISInventoryCtrl_Service/webresources/IVC/UpdateGRN");
            //URL url = new URL(sURL + "HIS_WebServices_Inventory/webresources/HIS_WebServices/UpdateGRN"); ///HIS_WebServices
            URL url;
            if (BaseDAL.CMSIntegrationType.equals("HIS")) {
               url = new URL(sURL + "HIS_WebServices_Inventory/webresources/HIS_WebServices/UpdateGRN"); 
            }
            else if (BaseDAL.CMSIntegrationType.equals("CMS")) {
               url = new URL(sURL + "CMS_WebServices_Inventory/webresources/CMS_WebServices/UpdateGRN"); 
            }
            else if (BaseDAL.CMSIntegrationType.equals("SKIN")) {
               url = new URL(sURL + "SKIN_WebServices_Inventory/webresources/SKIN_WebServices/UpdateGRN"); 
            }
            else {
               url = new URL(sURL + "HIS_WebServices_Inventory/webresources/HIS_WebServices/UpdateGRN"); 
            }
            //url = new URL(sURL + "InventoryCtrl_Service/webresources/IVC_Service/UpdStockAdj");
            conn = (HttpURLConnection) url.openConnection();
            //HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
            
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
//            conn.setHostnameVerifier(new HostnameVerifier() {
//                public boolean verify(String host, SSLSession sess) {
//                    if (host.equals("219.92.53.62")) return true;
//                    else return false;
//                }
//            });

            //String input = "data:[{\"STKCOSTCOMPANY\":\"a\",\"STKCOSTWAREHOUSE\":\"1\"},{\"STKCOSTCOMPANY\":\"b\",\"STKCOSTWAREHOUSE\":\"2\"}]";
            DAL_CM.write_log("Input to call their webservices: "+input, Str_LogPath);
            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes());
            os.flush();
                                 
            //--- read multiple stream ---
            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
            Object obj_inData =  parser.parse(br);
            JSONObject obj_json = (JSONObject) JSONSerializer.toJSON(obj_inData.toString());
            
            JSONObject obj_jsonIn = obj_json.getJSONObject("DATA");
            JSONArray jsonGRNArr = obj_jsonIn.names();
            String sResponse = "";       
            BLL_Common.Common_Object obj = null;
           // DAL_StockCostQty objSCQ = new DAL_StockCostQty();
            // objSTKL = new DAL_StockLedger();
            
            Date date = new Date();
            String sControlDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
            
            for (int i = 0; i < jsonGRNArr.size(); i++) {
                String sArrName = jsonGRNArr.getString(i);
                JSONArray innerArray = obj_jsonIn.getJSONArray(sArrName);
                
                for(Object js : innerArray){
                    JSONObject json = (JSONObject) js;
                    if(json.get("responseCode").toString().equals("00000")){
                        sResponse = "T";
                    }else{
                        sResponse = "I";
                    }
                    
                    if(sArrName.equals("SCQ")){                        
                        String[] aryEx = {
                            "UPD_DATAEX" /*sMethod VARCHAR(30)*/,                        
                            json.get("idx").toString() /* 2 - sSCQCostQtyIdx Integer */,
                            "" /* 3 - sSCQCompanyCode varchar(10) */,
                            "" /* 4 - sSCQLocationCode varchar(10) */,
                            "" /* 5 - sSCQStockCode varchar(10) */,
                            "0" /* 6 - sSCQStockIdx Integer */,
                            "" /* 7 - sSCQBatchNo varchar(10) */,
                            null /* 8 - sSCQExpiryDate datetime */,
                            "" /* 9 - sSCQUnitcCost varchar(20) */,
                            "" /* 10 - sSCQUOMCode varchar(6) */,
                            "0" /* 11 - sSCQUOMIdx Integer */,
                            "0" /* 12 - sSCQQty varchar(20) */,
                            null /* 13 - sSCQReceivedDate datetime */,
                            "0",
                            "" /* 15 - sBy varchar(10) */,
                            "1", /* 16 - srecstatus varchar(4) */    
                            sResponse,
                            "0"
                        };
                        //obj = objSCQ.DAL_UPDATE_STOCK_COSTQTY(SiteName, aryEx);                        
                    }else {
                        String [] aryExSL = {
                        "" /*0 sMethod VARCHAR(30)*/,
                        json.get("idx").toString(), /*1 INTEGER,*/
                        json.get("idx").toString(), /*2 INTEGER,*/
                        "", /*3 VARCHAR(10),*/
                        "", /*4 VARCHAR(10),*/
                        "0", /*5 INTEGER,*/
                        "0", /*6 INTEGER,*/
                        "", /*7 VARCHAR(6),*/
                        "", /*8 VARCHAR(6),*/
                        "", /*9 VARCHAR(10),*/
                        "", /*10 VARCHAR(4),*/
                        "", /*11 VARCHAR(10),*/
                        "", /*12 DATETIME,*/
                        "", /*13 VARCHAR(30),*/
                        "", /* 14 JsonLedger.get("sldg_refdate").toString().toUpperCase(), DATETIME,*/                         
                        "", /*15 VARCHAR(30),*/
                        "", /* 16 JsonLedger.get("sldg_invdate").toString().toUpperCase(), /*DATETIME,*/
                        "", /*17 VARCHAR(30),*/
                        "", /* 18 JsonLedger.get("sldg_dodate").toString().toUpperCase(), /*DATETIME,*/
                        "", /*19 VARCHAR(100),*/
                        "", /*20 VARCHAR(1),*/
                        "0", /*21 INTEGER,*/
                        "0", /*22 INTEGER,*/
                        "", /*23 VARCHAR(10),*/                        
                        "", /*24 VARCHAR(6),*/
                        "0", /*25 INTEGER,*/
                        "", /*26 VARCHAR(20),*/
                        "", /*27 VARCHAR(20),*/
                        "", /*28 VARCHAR(20),*/
                        "", /*29 VARCHAR(20),*/
                        "", /*30 VARCHAR(20),*/
                        "", /*31 VARCHAR(1),*/
                        "", /*32  JsonLedger.get("sldl_expirydate").toString().toUpperCase(), /*DATETIME,*/
                        "", /*33 VARCHAR(10),*/
                        "", /*34 VARCHAR(30),*/
                        "", /*35 VARCHAR(10),*/
                        "", /*36 VARCHAR(20),*/
                        "", /*37 VARCHAR(20),*/
                        "", /*38 VARCHAR(20),*/
                        "0", /*39 INTEGER,*/
                        "0", /*40 INTEGER,*/
                        "0", /*41 INTEGER,*/
                        "", /*42 VARCHAR(20),*/
                        "", /*43 VARCHAR(20),*/
                        "", /*44 VARCHAR(6),*/
                        "", /*45 VARCHAR(20),*/
                        "", /*46 VARCHAR(8),*/
                        "", /*47 VARCHAR(20),*/
                        "", /*48 VARCHAR(20),*/
                        "", /*49 VARCHAR(20),*/
                        "", /*50 VARCHAR(10),*/
                        "", /*51 varchar(10),*/
                        "", /*52 rec status varchar(4),*/
                        sResponse/*53 data ex status varchar(4),*/
                        ,"-99999"
                        ,sControlDatetime
                        };
   
                        if(sArrName.equals("STKLEDGH")){
                            aryExSL[0] = "UPD_DATAEXH";
//                            obj = objSTKL.DAL_UPDATE_STOCK_LEDGER(SiteName, aryExSL);
                            DAL_CM.write_log("UPD_DATAEXH : DAL_UPDATE_STOCK_LEDGER", "");
                        }else if(sArrName.equals("STKLEDGD")){
                            aryExSL[0] = "UPD_DATAEXD";
//                            obj = objSTKL.DAL_UPDATE_STOCK_LEDGER(SiteName, aryExSL);
                            DAL_CM.write_log("UPD_DATAEXD : DAL_UPDATE_STOCK_LEDGER", "");
                        }
                    }
                    
                    try{
                        obj.commit();
                    }catch (Exception e) {
                    }
                }
            }
//            String output="", responseCode ="";
//            while ((output = br.readLine()) != null) {
//                output = output.replaceAll("\"", "");
//                
//                String[] arr = output.split(",");
//                for(int i=0; i<arr.length; i++){
//                    if(arr[i].contains("responseCode")){
//                        String[] responseCodeArr = arr[i].split(":");
//                        responseCode = responseCodeArr[1];
//                    }
//                }                
//                s_Return = responseCode;                
//            }
            //--- end read multiple stream ---         

            conn.disconnect();
        
        }catch(Exception e) {

            DAL_CM.write_log("Error calling webservices: "+ e, Str_LogPath);
            e.printStackTrace();
            conn.disconnect();
        }
        
        return s_Return;
    }
      
}
