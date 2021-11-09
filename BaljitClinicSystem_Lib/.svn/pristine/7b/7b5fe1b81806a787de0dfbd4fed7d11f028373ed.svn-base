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


public class MyRunnable implements Runnable {
		private final String url;
 
		MyRunnable(String url) {
			this.url = url;
		}
 
		@Override
		public void run() {
 
                    int i = 1;
         
                        while (i < 11*100000) {
                            System.out.println(this.url );  
                            i++;
                        }
        
//			String result = "";
//			int code = 200;
//			try {
//				URL siteURL = new URL(url);
//				HttpURLConnection connection = (HttpURLConnection) siteURL
//						.openConnection();
//				connection.setRequestMethod("GET");
//				connection.connect();
// 
//				code = connection.getResponseCode();
//				if (code == 200) {
//					result = "Green\t";
//				}
//			} catch (Exception e) {
//				result = "->Red<-\t";
//			}
//			System.out.println(url + "\t\tStatus:" + result);
		}
	}
