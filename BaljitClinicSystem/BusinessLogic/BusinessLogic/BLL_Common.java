package BusinessLogic;

import BusinessData.BaseDAL;
//import static BusinessData.BaseDAL.JavaDB2Driver;
import static BusinessData.BaseDAL.JavaMySQLDriver;
//import BusinessData.BaseDAL_Audit;
import BusinessData.DAL_Common;
import com.google.common.base.Joiner;
//import com.ibm.db2.jcc.DB2PreparedStatement;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
//import org.json.JSONArray;
import net.sf.json.JSONArray;
//import org.json.JSONObject;
import net.sf.json.JSONObject;
import net.sf.json.JSONException;
//import org.json.JSONException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.util.Collections;
import java.util.Scanner;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import net.sf.json.JSONSerializer;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.SocketTimeoutException;

import java.net.*;
import java.io.*;
/**
 *
 * @author N0516
 */
public class BLL_Common {

    // author: Vince, Date: 2015-09-09 
    // SHARE_MODE and EXCLUSIVE_MODE is to use for LockTable function
    public static final String SHARE_MODE = "SHARE MODE";
    public static final String EXCLUSIVE_MODE = "EXCLUSIVE MODE";
    // END

    //Author: Chong, Date : 2014/06/19
    public String MD5(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
            }
            //return sb.toString().toUpperCase();
            String see = sb.toString().toUpperCase();
            return see;
        } catch (java.security.NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Author: Chong, Date : 2014/06/19
    public static String current_datetime() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date msg_date = new Date();
        String s_currdate = dateFormat.format(msg_date);

        return s_currdate;
    }

    //Author: Chong, Date : 2015/08/18
    public static String current_date() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date msg_date = new Date();
        String s_currdate = dateFormat.format(msg_date);

        return s_currdate;
    }

    //Author: Kenji, Date : 2014/07/22
    public String convert_datetime(String s_date) {
        //Input date in String format
        String input = s_date;//"2014-07-22 15:43:26.327";
        //Date/time pattern of input date
        //DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        //Date/time pattern of desired output date
        // DateFormat outputformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
        DateFormat outputformat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        String output = null;
        try {
            //Conversion of input String to date
            date = df.parse(input);
            //old date format to new date format
            output = outputformat.format(date);
            System.out.println(output);
        } catch (ParseException pe) {
            pe.printStackTrace();
        }

        return output;
    }

    //Author: Chong, Date : 2014/06/19
    public static void write_log(String s_Message, String s_path) {

        String file_path;

        if (!s_path.toString().equals("")) {
            //file_path = "C:/HealthEcoSystemPL_log/" + s_path.toString();
            file_path = BaseDAL.LogFile_Path + "/" + s_path.toString();

        } else {
            //file_path = "C:/HealthEcoSystemPL_log";
            file_path = BaseDAL.LogFile_Path;
        }

        try {

            DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

            DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
            Calendar cal = Calendar.getInstance();

            String datefile = file_path + "/" + dateFormat1.format(cal.getTime()) + ".txt";

            File Path = new File(file_path);
            if (!Path.exists()) {
                Path.mkdirs();
            }

            File file = new File(datefile);

            if (!file.exists()) {
                file.createNewFile();
            }

            FileWriter fileWriter = new FileWriter(file, true);

            BufferedWriter bufferFileWriter = new BufferedWriter(fileWriter);
            fileWriter.append(dateFormat2.format(cal.getTime()) + " ==> " + s_Message);
            fileWriter.append(System.getProperty("line.separator") + "\r\n");
            bufferFileWriter.close();

        } catch (Exception ex) {
            ex.printStackTrace();

        }

    }

    //public static void write_logConn(String s_Message) {
    //DAL_Common DAL_Comm = new DAL_Common();
    //    String file_path = "C:/ClaimPortalConnection_log";

    /*
     try
     {
     //if(DAL_Comm.Bln_WriteLog)
     //{
     DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

     DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMdd");
     Calendar cal = Calendar.getInstance();


     String datefile = file_path + "/" + dateFormat1.format(cal.getTime()) + ".txt";    

     File Path = new File(file_path);
     if (!Path.exists())
     Path.mkdirs();

     File file = new File(datefile);

     if (!file.exists()) 
     {
     file.createNewFile();
     }

     FileWriter fileWriter = new FileWriter(file,true);

     BufferedWriter bufferFileWriter  = new BufferedWriter(fileWriter);
     fileWriter.append(dateFormat2.format(cal.getTime()) + " ==> " + s_Message);
     fileWriter.append(System.getProperty("line.separator"));


     bufferFileWriter.close();
     //}
                    
        
     }
     catch (Exception ex)
     {
     ex.printStackTrace();  
			 
     }
     */
    //}
    //Author: Chong, Date : 2014/06/19
    public static String GetString_FromInputStream(InputStream bistream) {

        BufferedReader br = null;
        StringBuilder sb = new StringBuilder();

        int temp, counter = 0;

        try {

            while ((temp = bistream.read()) != -1) {
                counter++;
                if (temp == '$') {
                    if (bistream.markSupported()) {
                        bistream.mark(counter);
                    }
                }
                sb.append((char) temp);
            }
            bistream.reset();

        } catch (IOException e) {
            e.printStackTrace();
        }

        return sb.toString();

    }

    //Author: Chong, Date : 2014/07/19
    public static String Convert_EmptytoZero(String s_received) {
        String s_return = "";
        s_received = s_received.trim();

        if (s_received.length() == 0 || s_received.isEmpty() || s_received == "") {
            s_return = "0";
        } else {
            s_return = s_received;
        }

        return s_return;
    }

    public String[] Get_ErrorCode(String s_errornum, DAL_Common.DALCommon_obj DALComObj, String SiteName) {
        DAL_Common DAL_Comm = new DAL_Common();

        return DAL_Comm.Get_ErrorCode(s_errornum, DALComObj, SiteName);
    }

    public String Generate_ClaimNo(String s_vno) {
        DateFormat dateFormat1 = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar cal = Calendar.getInstance();

        return "CLM_" + dateFormat1.format(cal.getTime()) + "_" + s_vno;
    }

    public String Curr_yyhhmmss() {
        DateFormat dateFormat1 = new SimpleDateFormat("yyyyMM");
        Calendar cal = Calendar.getInstance();

        return dateFormat1.format(cal.getTime());
    }

    public static String rightJustifyInt(int iValue, String sPrefix, int iLength) {
        String sValue = String.valueOf(iValue);
        if (iLength > sValue.length()) {
            return String.format("%0" + String.valueOf(iLength) + "d", iValue);
        } else {
            return sValue;
        }
    }

    //Vince
    public String Get_Age(String s_DOB) {
//            if(s_DOB != null && !s_DOB.isEmpty())
//            {
//                LocalDate birthdate = new LocalDate (convert_datetime(s_DOB));
//                LocalDate now = new LocalDate();
//                return Years.yearsBetween(birthdate, now).toString();
//            }
//            else
        return "0";
    }

    //Vince
    public static int Get_Current_Month(String str_date) {
        Calendar cal = Calendar.getInstance();
        try {
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = formatter.parse(str_date);
            cal.setTime(date);
        } catch (ParseException e) {
            write_log("CPCCommon Get_Current_Month: " + e.toString(), "");
            return -1;
        }
        return cal.get(Calendar.MONTH) + 1;
    }

    //Vince
    public static int Get_Current_Month() {
        Calendar cal = Calendar.getInstance();
        BLL_Common BLL_Common = new BLL_Common();
        try {
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = formatter.parse(BLL_Common.current_datetime());
            cal.setTime(date);
        } catch (ParseException e) {
            write_log("CPCCommon Get_Current_Month: " + e.toString(), "");
            return -1;
        }
        return cal.get(Calendar.MONTH) + 1;
    }

    //Author: Bryan, Date : 2014/09/23
    public String convert_dateonly(String s_date) {
        //Input date in String format
        String input = s_date;//"2014-07-22 15:43:26.327";
        //Date/time pattern of input date
        //DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //Date/time pattern of desired output date
        // DateFormat outputformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
        DateFormat outputformat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        String output = null;
        try {
            //Conversion of input String to date
            date = df.parse(input);
            //old date format to new date format
            output = outputformat.format(date);
        } catch (ParseException pe) {
            pe.printStackTrace();
        }

        return output;
    }

    public String convert_dateonly2(String s_date) {
        //Input date in String format
        String input = s_date;//"2014-07-22 15:43:26.327";
        //Date/time pattern of input date
        //DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //Date/time pattern of desired output date
        // DateFormat outputformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss aa");
        DateFormat outputformat = new SimpleDateFormat("yyyyMMdd");
        Date date = null;
        String output = null;
        try {
            //Conversion of input String to date
            date = df.parse(input);
            //old date format to new date format
            output = outputformat.format(date);
        } catch (ParseException pe) {
            pe.printStackTrace();
        }

        return output;
    }

    public static void closeEverything(ResultSet rs, Statement stmt, Connection con, String s_path) {
        if (rs != null) {
            try {
                rs.close();
                //write_logConn("Closed ResultSet");
            } catch (SQLException e) {
                write_log(e.toString(), s_path);
                e.printStackTrace();
            }
        }

        if (stmt != null) {
            try {
                stmt.close();
                //write_logConn("Closed Statement");
            } catch (SQLException e) {
                write_log(e.toString(), s_path);
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
                //write_logConn("Closed Connection");
            } catch (SQLException e) {
                write_log(e.toString(), s_path);
                e.printStackTrace();
            }
        }

    }

    public static void closeResultSet(ResultSet rs, String s_path) {
        if (rs != null) {
            try {
                rs.close();
                //write_logConn("Closed ResultSet");
            } catch (SQLException e) {
                write_log(e.toString(), s_path);
                e.printStackTrace();
            }
        }
    }

    public static String Get_SndAppFac(String s_input) {
        String s_return_SndApp = "";
        String s_return_SndFac = "";
        String s_return = "";

        try {
            boolean bln_InputContains_SndApp = s_input.indexOf("\"SNDAPP\":") != -1;
            if (bln_InputContains_SndApp) {
                String[] array_SndApp1 = s_input.split("\"SNDAPP\":");
                String[] array_SndApp2 = array_SndApp1[1].split(",");
                s_return_SndApp = array_SndApp2[0].replace("\"", "");
            }

            boolean bln_InputContains_SndFac = s_input.indexOf("\"SNDFAC\":") != -1;
            if (bln_InputContains_SndFac) {
                String[] array_SndFac1 = s_input.split("\"SNDFAC\":");
                String[] array_SndFac2 = array_SndFac1[1].split(",");
                s_return_SndFac = array_SndFac2[0].replace("\"", "").trim();
            }

            if (!s_return_SndApp.equals("") && !s_return_SndFac.equals("")) {
                s_return = s_return_SndApp + "_" + s_return_SndFac;

            }
        } catch (Exception ex) {
            write_log(ex.toString(), "");

        }

        return s_return;

    }

    //Author: Bryan, Date : 2014/11/28
    public String convert_to_camelcase(String s_stringupper) {

        s_stringupper = s_stringupper.toLowerCase();
        String s_stringlower = WordUtils.capitalize(s_stringupper);

        return s_stringlower;
    }

    public static class businessapp_obj {

        public String BA_Code;
        public String BA_Name;

        public businessapp_obj(String BA_Code, String BA_Name) {
            this.BA_Code = BA_Code;
            this.BA_Name = BA_Name;
        }

        public String getBA_Code() {
            return BA_Code;
        }

        public void setBA_Code(String BA_Code) {
            this.BA_Code = BA_Code;
        }

        public String getBA_Name() {
            return BA_Name;
        }

        public void setBA_Name(String BA_Name) {
            this.BA_Name = BA_Name;
        }
    }

    public ArrayList<businessapp_obj> BLL_GetBussineeAppInfo(ArrayList arraycode, ArrayList arrayname) {
        ArrayList<businessapp_obj> list = new ArrayList<businessapp_obj>();

        for (int i = 0; i < arraycode.size(); i++) {
            list.add(new businessapp_obj(arraycode.get(i).toString(), arrayname.get(i).toString()));
        }

        return list;
    }

    public String[] Get_BusinessAppSession(String s_selectcode, ArrayList arraycode, ArrayList arrayname) {
        String s_selectedname = "";
        for (int i = 0; i < arraycode.size(); i++) {
            if (s_selectcode.equals(arraycode.get(i).toString())) {
                s_selectedname = arrayname.get(i).toString();
                break;
            }
        }
        String[] s_returnarray = {s_selectcode, s_selectedname};
        return s_returnarray;
    }

    public String surroundQuote(String sIncoming) {
        List<String> aryCorpID = new ArrayList<String>();

        try {
            for (String sCorpID : StringUtils.split(sIncoming, ",")) {
                aryCorpID.add("\'" + sCorpID + "\'");
            }
        } catch (Exception ex) {
            write_log("surroundQuote error :" + ex.getMessage().toString(), "");
            write_log(ex.toString(), "");

        }
        return Joiner.on(",").join(aryCorpID).toString();
    }

    public static String surroundQuoteS(String sIncoming) {
        List<String> aryCorpID = new ArrayList<String>();

        for (String sCorpID : StringUtils.split(sIncoming, ",")) {
            aryCorpID.add("\'" + sCorpID + "\'");
        }
        return Joiner.on(",").join(aryCorpID);
    }

    public class PlanDate {

        private String FromDate;
        private String ToDate;
        private String HiredDate;
        private String FinEndMonth;
        private String DateFormat = "yyyy-MM-dd";

        public String getDateFormat() {
            return DateFormat;
        }

        public void setDateFormat(String DateFormat) {
            this.DateFormat = DateFormat;
        }

        public String getFromDate() {
            return FromDate;
        }

        public String getToDate() {
            return ToDate;
        }

        public String getHiredDate() {
            return HiredDate;
        }

        public String getFinEndMonth() {
            return FinEndMonth;
        }

        public void setFromDate(String FromDate) {
            this.FromDate = FromDate;
        }

        public void setToDate(String ToDate) {
            this.ToDate = ToDate;
        }

        public void setHiredDate(String HiredDate) {
            this.HiredDate = HiredDate;
        }

        public void setFinEndMonth(String FinEndMonth) {
            this.FinEndMonth = FinEndMonth;
        }

        public PlanDate get() {
            SimpleDateFormat sdf = new SimpleDateFormat(getDateFormat());
            Date dtFrom;
            Date dtTo;
            try {
                Calendar calHiredDate = Calendar.getInstance();
                calHiredDate.setTime(sdf.parse(getHiredDate()));

                int iFinEndMonth = Integer.parseInt(getFinEndMonth());
                Calendar calLastDay = Calendar.getInstance();
                calLastDay.add(Calendar.MONTH, iFinEndMonth);
                calLastDay.set(Calendar.DAY_OF_MONTH, 1);
                calLastDay.add(Calendar.DATE, -1);
                int iPlanDueYear = calLastDay.get(calLastDay.YEAR);
                int iLastDay = calLastDay.get(calLastDay.DAY_OF_MONTH);
                if ((calHiredDate.get(Calendar.MONTH) + 1) > iFinEndMonth) {
                    dtTo = sdf.parse(String.valueOf(iPlanDueYear + 1) + "-" + getFinEndMonth() + "-" + String.valueOf(iLastDay));
                    dtFrom = sdf.parse(String.valueOf(iPlanDueYear) + "-" + String.valueOf(iFinEndMonth + 1) + "-01");
                } else {
                    dtTo = sdf.parse(String.valueOf(iPlanDueYear) + "-" + getFinEndMonth() + "-" + String.valueOf(iLastDay));
                    dtFrom = sdf.parse(String.valueOf(iPlanDueYear - 1) + "-" + String.valueOf(iFinEndMonth + 1) + "-01");
                }
                setFromDate(sdf.format(dtFrom));
                setToDate(sdf.format(dtTo));
            } catch (ParseException e) {
                write_log("BLL_Common.PlanDate Parser Error: " + e.toString(), "");
            }
            return this;
        }
    }

    //Author: Vince Date: 11/02/2015
    //The Encryption is for passing parameter between jsp
    public String Encryption(String skey, String sPlanText) throws BadPaddingException, InvalidKeyException, UnsupportedEncodingException, IllegalBlockSizeException, NoSuchAlgorithmException, NoSuchPaddingException {
        MessageDigest sha = MessageDigest.getInstance("SHA-1");

        byte[] key = sha.digest(skey.getBytes());
        SecretKeySpec secretKeySpec = new SecretKeySpec(Arrays.copyOf(key, 16), "AES");
        Cipher AesCipher = Cipher.getInstance("AES");

        AesCipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);

        return toHex(AesCipher.doFinal(sPlanText.getBytes()));
    }

    //Author: Vince Date: 11/02/2015
    //The Decryption is for passing parameter between jsp
    public String Decryption(String skey, String sEncryptedText) throws BadPaddingException, InvalidKeyException, UnsupportedEncodingException, IllegalBlockSizeException, NoSuchAlgorithmException, NoSuchPaddingException {
        MessageDigest sha = MessageDigest.getInstance("SHA-1");

        byte[] key = sha.digest(skey.getBytes());
        SecretKeySpec secretKeySpec = new SecretKeySpec(Arrays.copyOf(key, 16), "AES");
        Cipher AesCipher = Cipher.getInstance("AES");
        AesCipher.init(Cipher.DECRYPT_MODE, secretKeySpec);

        return new String(AesCipher.doFinal(toByte(sEncryptedText)));
    }

    //Author: Vince Date: 11/02/2015
    //Revert back the hex string to byte array
    private byte[] toByte(String hexString) {
        int len = hexString.length() / 2;

        byte[] result = new byte[len];

        for (int i = 0; i < len; i++) {
            result[i] = Integer.valueOf(hexString.substring(2 * i, 2 * i + 2), 16).byteValue();
        }
        return result;
    }

    //Author: Vince Date: 11/02/2015
    //To pass the byte array by hex string
    private String toHex(byte[] stringBytes) {
        final String HEX = "0123456789ABCDEF";
        StringBuilder result = new StringBuilder(2 * stringBytes.length);

        for (int i = 0; i < stringBytes.length; i++) {
            result.append(HEX.charAt((stringBytes[i] >> 4) & 0x0f)).append(HEX.charAt(stringBytes[i] & 0x0f));
        }

        return result.toString();
    }

    //Author: Vince ,Date: 16/02/2015
    //JsonObject to HashMap
    public Map toMap(JSONObject object) throws JSONException {
        Map<String, Object> map = new HashMap<String, Object>();

        Iterator<String> keysItr = object.keys();
        while (keysItr.hasNext()) {
            String key = keysItr.next();
            Object value = object.get(key);
            String see = "";
            if (value instanceof JSONArray) {
                JSONArray jArray = (JSONArray) value;
                for (int i = 0; i < jArray.size(); i++) {
                    see += jArray.get(i).toString() + ",";
                }
                value = see.subSequence(0, see.length() - 1);
            } else if (value instanceof JSONObject) {
                value = toMap((JSONObject) value);
            }
            map.put(key, value);
        }
        return map;
    }

    public String[] toArray(JSONObject object) throws JSONException {
        List<String> tempList = new ArrayList<String>();
        List<Integer> sortedList = new ArrayList<Integer>();

        Iterator<String> keysItr = object.keys();
        while (keysItr.hasNext()) {
            sortedList.add(Integer.parseInt(keysItr.next()));
        }
        Collections.sort(sortedList);
//        Collections.sort(sortedList, new Comparator<ArrayList<Integer>>() {
//                    @Override
//                    public int compare(List<Integer> lhs, List<Integer> rhs) {
//                        try {
//                            return Integer.parseInt(lhs.get("INORDER").toString()) - Integer.parseInt(rhs.get("INORDER").toString());
//                        } catch (Exception e) {
//                            return 0;
//                        }
//                    }
//                });
        for (int key : sortedList) {
            Object value = object.get(String.valueOf(key));
            tempList.add(value.toString());
        }
        return tempList.toArray(new String[tempList.size()]);
    }

    //Author : Jeffrey, Date : 24/03/2015
    public static String withoutQuote(String sIncoming) throws SQLException {
        List<String> aryCorpID = new ArrayList<String>();

        try {
            for (String sCorpID : StringUtils.split(sIncoming, ",")) {
                aryCorpID.add(sCorpID);
            }
        } catch (Exception ex) {
            write_log(ex.toString(), "");
        }
        return Joiner.on(",").join(aryCorpID);
    }

    public static String establish_MySQLconn(String SiteName) throws ClassNotFoundException, SQLException {

        String s_return = "";
        Statement stmt = null;
        ResultSet rs = null;

        try {
        	write_log("SiteName: " + SiteName, "");
        	write_log("URL: " + BusinessData.BaseDAL.getAddress(SiteName), "");
        	write_log("User: " + BusinessData.BaseDAL.DataBase_USER, "");
        	write_log("Pwd: " + BusinessData.BaseDAL.DataBase_PWD, "");
        	
            if (BaseDAL.p_db_conn == null) {
                write_log("p_db_conn is null, need to connect now ", "");
                //Class.forName(BusinessData.BaseDAL.JavaDB2Driver);
                Class.forName(BusinessData.BaseDAL.JavaMySQLDriver);
                BaseDAL.p_db_conn = DriverManager.getConnection(BusinessData.BaseDAL.getAddress(SiteName), BusinessData.BaseDAL.DataBase_USER, BusinessData.BaseDAL.DataBase_PWD);
            } else {
                //stmt = BaseDAL.p_db_conn.createStatement();
               // String query = "Select count(*) From \"clm\".afc_menu";
               // rs = stmt.executeQuery(query);
            }
        } catch (Exception ex) {
            s_return = "Server connection failed.";
            write_log("Server db2 connection failed. Error message : " + ex.toString(), "");

            if (ex.toString().contains("ERRORCODE=-4499")) {
                //Class.forName(BusinessData.BaseDAL.JavaDB2Driver);
                Class.forName(BusinessData.BaseDAL.JavaMySQLDriver);
               // BaseDAL.p_db_conn = DriverManager.getConnection(BusinessData.BaseDAL.Db2_EstablishConn, BusinessData.BaseDAL.DataBase_USER, BusinessData.BaseDAL.DataBase_PWD);
                 BaseDAL.p_db_conn = DriverManager.getConnection(BusinessData.BaseDAL.MySQL_EstablishConn, BusinessData.BaseDAL.DataBase_USER, BusinessData.BaseDAL.DataBase_PWD);
                s_return = "";
            }

        }
        //finally
        //{
        //write_log("p_db_conn : "+ BaseDAL.p_db_conn.toString(), "");
        //}                

        //write_log("s_return : "+ s_return.toString(), "");
        return s_return;
    }

    public static JSONObject readSettingsFile(String Login_ID) throws FileNotFoundException {
        File settingsFile = new File(BaseDAL.User_Settings_DirPath + Login_ID + "/settings.json");
        String entireFileText = new Scanner(settingsFile).useDelimiter("\\A").next();
        if (!(entireFileText.length() > 0)) {
            entireFileText = "{}";
        }
        return JSONObject.fromObject(entireFileText);
    }

    public static class Common_Object {

        public Common_Object() {

        }

        public Common_Object(List<JSONArray> jsonArryList, List<Object> objectList) {
            this.JSONArray = jsonArryList.toArray(new JSONArray[jsonArryList.size()]);
            this.ObjectArray = objectList.toArray(new Object[objectList.size()]);
        }

        public Common_Object(List<JSONArray> jsonArryList, List<Object> objectList, Connection conn, Statement stam) {
            this.JSONArray = jsonArryList.toArray(new JSONArray[jsonArryList.size()]);
            this.ObjectArray = objectList.toArray(new Object[objectList.size()]);
            this.conn = conn;
            this.stam = stam;
        }

        private Object[] ObjectArray;
        private JSONArray[] JSONArray;
        private Connection conn;
        private Statement stam;

        public void commit() throws SQLException {
            if (conn != null) {
                conn.commit();
                conn.close();
            }
            if (stam != null) {
                stam.close();
            }
        }

        public void rollback() throws SQLException {
            if (conn != null) {
                conn.rollback();
                conn.close();
            }
            if (stam != null) {
                stam.close();
            }
        }

        public Connection getConnection() {
            return this.conn;
        }

        public Statement getStatement() {
            return this.stam;
        }

        public JSONObject getJSONArrayAsJSONObject(String prefix) {
            int i = 1;
            JSONObject jsonObj = new JSONObject();
            for (JSONArray temp : this.JSONArray) {
                jsonObj.put(prefix + i, temp);
                i++;
            }
            return jsonObj;
        }

        public JSONArray getJSONArray(int in) throws NullPointerException {
            if (JSONArray.length > in) {
                return JSONArray[in];
            } else {
                throw new NullPointerException();
            }
        }

        public void setJSONArray(JSONArray[] JSONArray) {
            this.JSONArray = JSONArray;
        }

        public Object getObjectArray(int in) throws NullPointerException {
            if (ObjectArray.length > in) {
                return ObjectArray[in];
            } else {
                throw new NullPointerException();
            }
        }

        public void setObjectArray(Object[] ObjectArray) {
            this.ObjectArray = ObjectArray;
        }
    }

    public static JSONArray rsToJSONArray(ResultSet rs) throws JSONException, SQLException {
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next()) {
            int colcount = rsmd.getColumnCount();
            for (int i = 1; i <= colcount; i++) {
                jsonObject.put(rsmd.getColumnLabel(i), rs.getString(i));
            }
            jsonArray.add(jsonObject);
        }
        rs.close();
        return jsonArray;
    }

    public static JSONArray rsToJSONArray_No_Commit(ResultSet rs) throws JSONException, SQLException {
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next()) {
            int colcount = rsmd.getColumnCount();
            for (int i = 1; i <= colcount; i++) {
                jsonObject.put(rsmd.getColumnLabel(i), rs.getString(i));
            }
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    public static String getLastDayOfMonth(String inYear, String inMonth) {
        String sMonth = inMonth.length() < 2 ? "0" + inMonth : inMonth;
        String inDate = inYear + "-" + sMonth + "-01";
        Calendar cal = Calendar.getInstance();
        try {
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = formatter.parse(inDate);
            cal.setTime(date);
        } catch (ParseException e) {
            write_log("CPCCommon Get_Current_Month: " + e.toString(), "");
            return inDate.substring(0, 7) + "30";
        }
        return String.valueOf(cal.get(Calendar.YEAR)) + "-" + String.valueOf(cal.get(Calendar.MONTH) + 1) + "-" + String.valueOf(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
    }

    public static boolean isNumeric(String str) {
        try {
            double d = Double.parseDouble(str);
        } catch (NumberFormatException ex) {
            return false;
        }
        return true;
    }

    public static double RoundNum(Object inValue, int places) {
        if (places < 0) {
            throw new IllegalArgumentException();
        }
        Double value = Double.valueOf(inValue.toString());
        if (value.isNaN()) {
            throw new IllegalArgumentException();
        }
        long factor = (long) Math.pow(10, places);
        value = value * factor;
        long tmp = Math.round(value);
        return (double) tmp / factor;
    }

    public static boolean LockTable(String sTableName, Connection conn, String lockMode) throws SQLException {
        PreparedStatement statement = null;
        boolean bReturn = false;
        try {
            //Class.forName(JavaDB2Driver);
            Class.forName(JavaMySQLDriver);

            statement = conn.prepareCall("LOCK TABLE " + sTableName + " IN " + lockMode);
            statement.execute();
            bReturn = true;
        } catch (Exception ex) {
            bReturn = false;
            BLL_Common.write_log("Lock Table Error : " + ex.toString(), "");
        } finally {
            BLL_Common.closeEverything(null, statement, null, "");
        }
        return bReturn;
    }
    
    //Author: LLT, Date : 2016/03/17
        public static TrustManager[ ] get_trust_mgr() {
            TrustManager[ ] certs = new TrustManager[ ] {
            new X509TrustManager() {
            public X509Certificate[ ] getAcceptedIssuers() { return null; }
            public void checkClientTrusted(X509Certificate[ ] certs, String t) { }
            public void checkServerTrusted(X509Certificate[ ] certs, String t) { }
         }
      };
      return certs;
  }
        
    //Author: LLT, Date : 2016/03/23
        public static JSONObject mergeObjectValue(JSONArray arrs, String key) throws JSONException {
            JSONObject merged = new JSONObject();
            for (Object arr : arrs) {
                JSONObject arrobj = (JSONObject) arr;
                merged.put(arrobj.get(key), arrobj);
                
//                Iterator it = arrobj.keys();
//                while (it.hasNext()){
//                    String key = (String)it.next();
//                    merged.put(arrobj.get(key), arrobj.get(key)); 
//                }                
            }      
            
            return merged;
//            for (String key: JSONObject.getNames(source)) {
//                Object value = source.get(key);
//                if (!target.has(key)) {
//                    // new value for "key":
//                    target.put(key, value);
//                } else {
//                    // existing value for "key" - recursively deep merge:
//                    if (value instanceof JSONObject) {
//                        JSONObject valueJson = (JSONObject)value;
//                        deepMerge(valueJson, target.getJSONObject(key));
//                    } else {
//                        target.put(key, value);
//                    }
//                }
//            }
//            return target;           
        }
        
        //Author: LLT, Date : 2016/03/23
        public static JSONArray concatArray(JSONArray... arrs) throws JSONException {
            JSONArray result = new JSONArray();
            for (JSONArray arr : arrs) {
                for (int i = 0; i < arr.size(); i++) {
                    result.add(arr.get(i));
                }
            }
            return result;
        }

        public static boolean isReachable(String targetUrl) throws IOException
        {
            //HttpURLConnection httpUrlConnection = (HttpURLConnection) new URL(targetUrl).openConnection();
            HttpURLConnection httpUrlConnection = (HttpURLConnection) new URL(targetUrl).openConnection();
            httpUrlConnection.setRequestMethod("HEAD");
BLL_Common.write_log("isReachable connecting : " + targetUrl, "");
            try
            {
                httpUrlConnection.setDoOutput(true);
                httpUrlConnection.setRequestMethod("GET");
                

                httpUrlConnection.setConnectTimeout(30000); //number of milliseconds before timeout - 50 second
                httpUrlConnection.setReadTimeout(30000);
                
                int responseCode = httpUrlConnection.getResponseCode();
 BLL_Common.write_log("isReachable respond : " + responseCode, "");
                return responseCode == HttpURLConnection.HTTP_OK;
                
               
            } 
            catch (SocketTimeoutException ex) {
                BLL_Common.write_log("isReachable socket error : " + ex.toString(), "");
                return false;
            } 
            catch (Exception ex)
            {
                BLL_Common.write_log("isReachable Exception error : " + ex.toString(), "");
                return false;
            }
        }

        public static boolean TestConnection(String targetUrl, int TimeOutValMiliSeconds) throws IOException
        {
            boolean bStatus = false;
            int TIMEOUT_VALUE = TimeOutValMiliSeconds; //1000;
            try {
                //URL testUrl = new URL("http://google.com");
                URL testUrl = new URL(targetUrl);
                StringBuilder answer = new StringBuilder(100000);

                long start = System.nanoTime();

                URLConnection testConnection = testUrl.openConnection();
                testConnection.setConnectTimeout(TIMEOUT_VALUE);
                testConnection.setReadTimeout(TIMEOUT_VALUE);
                
                BufferedReader in = new BufferedReader(new InputStreamReader(testConnection.getInputStream()));
                String inputLine;

                while ((inputLine = in.readLine()) != null) {
                    answer.append(inputLine);
                    answer.append("\n");
                }
                in.close();

                long elapsed = System.nanoTime() - start;
                System.out.println("Elapsed (ms): " + elapsed / 1000000);
                System.out.println("Answer:");
                System.out.println(answer);
                bStatus= true;
            } catch (SocketTimeoutException e) {
                System.out.println("More than " + TIMEOUT_VALUE + " elapsed.");
                bStatus = false;
            }

            return bStatus;
        }

        public static class AA{     
            
            private static boolean IsContactable = false;
            private static boolean ProcessStarted = false;
            
            public static boolean isReachable2(String targetUrl) throws IOException
            {

//                new Thread(new InterruptThread(con)).start();


                //HttpURLConnection httpUrlConnection = (HttpURLConnection) new URL(targetUrl).openConnection();
                HttpURLConnection httpUrlConnection = (HttpURLConnection) new URL(targetUrl).openConnection();
                httpUrlConnection.setRequestMethod("HEAD");
                BLL_Common.write_log("isReachable connecting : " + targetUrl, "");
                try
                {
                    httpUrlConnection.setDoOutput(true);
                    httpUrlConnection.setRequestMethod("GET");


                    httpUrlConnection.setConnectTimeout(50000); //number of milliseconds before timeout - 50 second
                    httpUrlConnection.setReadTimeout(50000);

//                    int responseCode = httpUrlConnection.getResponseCode();
                    ProcessStarted = true;
                    new Thread(new InterruptThread(httpUrlConnection)).start();
                    do {
                         System.out.println("ProcessStarted" + ProcessStarted);
                    } while (ProcessStarted);
                    
                    return IsContactable;
//                    BLL_Common.write_log("isReachable respond : " + responseCode, "");
//                    return responseCode == HttpURLConnection.HTTP_OK;


                } 
//                catch (SocketTimeoutException ex) {
//                    BLL_Common.write_log("isReachable socket error : " + ex.toString(), "");
//                    return false;
//                }
                catch (Exception ex)
                {
                    BLL_Common.write_log("isReachable Exception error : " + ex.toString(), "");
                    return false;
                }
            }
        
        
            public static class InterruptThread implements Runnable {

                HttpURLConnection con;
                public InterruptThread(HttpURLConnection con) {
                    this.con = con;
                    try{
                        int responseCode = this.con.getResponseCode();
                        if (responseCode == HttpURLConnection.HTTP_OK)
                        {
                            IsContactable = true;
                        }
                        ProcessStarted = false;
                        }
                    catch (Exception ex)
                        {
                            IsContactable = false;
                            ProcessStarted = false;
                        }
                }

                public void run() {
                try {
                    Thread.sleep(30000); // or Thread.sleep(con.getConnectTimeout())
                    
                    } 
                catch (InterruptedException e) 
                    {
                        IsContactable = false;
                        ProcessStarted = false;
                        
                    }
ProcessStarted = false;
                    con.disconnect();
                    System.out.println("Timer thread forcing to quit connection");
                }
            }
        }
    // -----------End-----------
    //For Selection with ALL
    /* 
     public ArrayList<businessapp_obj> BLL_GetBussineeAppInfo(String s_businessapp_full, String s_businessapp_fullcode) {
     ArrayList<businessapp_obj> list = new ArrayList<businessapp_obj>();
        
     String[] array_ba = null;
                
     if (!s_businessapp_full.equals(""))
     {
     boolean bln_InputContains_comma = s_businessapp_full.indexOf("~") != -1;
     if (bln_InputContains_comma)
     {
     list.add(new businessapp_obj(s_businessapp_fullcode, "ALL"));
                
     for (String retval: s_businessapp_full.split("~"))
     {
     array_ba = retval.split("#");                    
     list.add(new businessapp_obj(array_ba[0], array_ba[1]));
     }        
     }
     else
     {                
     array_ba = s_businessapp_full.split("#");
     list.add(new businessapp_obj(array_ba[0], array_ba[1]));            
     }    
        
     }
              
     return list;
     }
    
    
     public String[] Get_BusinessAppSession(String s_provider_select,String s_bussappfullcode, String s_bussappfull)
     {            
            
     String s_code = "";
     String s_name = "";
                       
            
     if (s_provider_select == null)
     {
     boolean bln_InputContains_comma = s_bussappfullcode.indexOf(",") != -1;
     if (bln_InputContains_comma)
     {
     s_code = s_bussappfullcode;     
     s_name = "ALL";
                   
     }
     else
     {            
     String[] array = s_bussappfull.split("#");
                      
     s_code = array[0];
     s_name = array[1]; 
            
     }
     }
     else
     {               
     if (!s_provider_select.equals(s_bussappfullcode))
     {    
     String[] array1 = s_bussappfull.split(s_provider_select); 
     String[] array2 = array1[1].split("#");
     String s_appname;
     if (array2[1].indexOf("~") != -1)
     {
     String[] array3 = array2[1].split("~");
     s_appname  = array3[0]; 
     }
     else
     s_appname  = array2[1];
       
     s_name = s_appname;    
     }
     else
     {
     s_name = "ALL";    
     }
       
     s_code = s_provider_select;
     }
        
     String[] s_returnarray = {s_code,s_name};    
     return s_returnarray; 
     } 
     */
}