package BusinessLogic;

import BusinessData.DAL_PopulateData;
import java.io.IOException;
import java.sql.SQLException;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 *
 * @author N3355
 */
public class BLL_StockRequest {
    public JSONObject ConvertJson(String sJsonIn) {
       
       JSONArray jsonarr = JSONArray.fromObject(sJsonIn);
       JSONArray jsonArray = new JSONArray();
       JSONObject json = null;       
       JSONObject obj = new JSONObject();
       String sLocCode = "";
       
       for(int i = 0; i < jsonarr.size(); i++){   
           
            if (sLocCode.equals("")) {
                   // sLocCode = jsonarr.getJSONObject(i).getString("LocCode");
                obj.put(jsonarr.getJSONObject(i).getString("LocCode"), "[" + jsonarr.getJSONObject(i) +"]");  
            }
          
           else if (sLocCode.equals(jsonarr.getJSONObject(i).getString("LocCode"))) {
                obj.accumulate(jsonarr.getJSONObject(i).getString("LocCode"),  jsonarr.getJSONObject(i));          
            }else{
                obj.put(jsonarr.getJSONObject(i).getString("LocCode"), "[" + jsonarr.getJSONObject(i) +"]");  
            }
            
            
            sLocCode = jsonarr.getJSONObject(i).getString("LocCode");
            
        }
        System.out.println("obj-->" + obj.toString()); 
        return obj;
    }      
}
