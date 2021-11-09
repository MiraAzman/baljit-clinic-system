/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BusinessLogic;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import org.json.simple.parser.JSONParser;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 *
 * @author N3359
 */
public class BLL_StockDataExchange implements Runnable {
		private final String sURL;
                private final String sLoc;
                private final String input;
 
                String s_Return = "";
    String Str_LogPath = "WebServiceLog";
    BLL_Common DAL_CM = new BLL_Common();
    JSONParser parser = new JSONParser();
    
    
		BLL_StockDataExchange(String input, String sURL, String sLoc) {
			this.input = input;
                        this.sURL = sURL;
                        this.sLoc = sLoc;
		}
 
		@Override
		public void run() {
 
                    HttpURLConnection conn = null;
        
                    try{
                        SSLContext ssl_ctx = SSLContext.getInstance("TLS");
                        TrustManager[ ] trust_mgr = DAL_CM.get_trust_mgr();
                        ssl_ctx.init(null,                // key manager
                                     trust_mgr,           // trust manager
                                     new SecureRandom()); // random number generator
                        //HttpsURLConnection.setDefaultSSLSocketFactory(ssl_ctx.getSocketFactory());
                        //-- http://192.168.1.232:8080/HIS_WebServices_Inventory/webresources/HIS_WebServices/UpdateStockMaster
                        URL url = new URL(sURL);
                        conn = (HttpURLConnection) url.openConnection();
                        //HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();

                        conn.setDoOutput(true);
                        conn.setRequestMethod("POST");
                        conn.setRequestProperty("Content-Type", "application/json");

                        DAL_CM.write_log("Input to call their webservices: "+input, Str_LogPath);
                        OutputStream os = conn.getOutputStream();
                        os.write(input.getBytes());
                        os.flush();

                        //--- read multiple stream ---
                        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                        Object obj_inData =  parser.parse(br);
                        JSONObject obj_json = (JSONObject) JSONSerializer.toJSON(obj_inData.toString());

                        JSONObject obj_jsonIn = obj_json.getJSONObject("DATA");
                        JSONArray jsonSMArr = obj_jsonIn.names();
                        String sResponse = ""; 

                        for(int i =0; i < jsonSMArr.size(); i++){
                            String sArrName = jsonSMArr.getString(i);
                            JSONArray innerArray = obj_jsonIn.getJSONArray(sArrName);

                            for(Object js : innerArray){
                                JSONObject json = (JSONObject) js;

                                sResponse = "WS Return " + sArrName + " for URL " + sLoc + ", idx -" + json.get("idx").toString() + ": " + json.get("responseMessage").toString();

                                DAL_CM.write_log(sResponse, Str_LogPath);
                            }
                        }
                        
                        System.out.println(sResponse );  
                    }catch(Exception e) {
                        e.printStackTrace();
                        conn.disconnect();
                    }

        
		}
	}

