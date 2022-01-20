package Model;

import java.sql.CallableStatement;

import javax.servlet.http.HttpServletRequest;

import BusinessLogic.BLL_Common;

public class Medicine {
	
	private String medicineId;
	private String name;
	private String batchNo;
	private String uom;
	private String expiryDate;
	private String unitCost;
	private String qty;
	private String price;
	private String isActive;
	
	public String getMedicineId() {
		return medicineId;
	}
	public void setMedicineId(String medicineId) {
		this.medicineId = medicineId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBatchNo() {
		return batchNo;
	}
	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}
	public String getUom() {
		return uom;
	}
	public void setUom(String uom) {
		this.uom = uom;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	public String getUnitCost() {
		return unitCost;
	}
	public void setUnitCost(String unitCost) {
		this.unitCost = unitCost;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getIsActive() {
		return isActive;
	}
	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}
	
	public static BLL_Common Object_BLL_Common = new BLL_Common();
	public CallableStatement set_SP_TRX_MEDICINE_param(CallableStatement stmt, String[] s_array) throws Exception {
		
		stmt.setString(1, s_array[0]);
        stmt.setString(2, this.medicineId); 
        stmt.setString(3, this.name);
        stmt.setString(4, this.uom);
        stmt.setString(5, this.unitCost);
        stmt.setString(6, this.price);
        stmt.setString(7, this.isActive);
        stmt.setString(8, this.batchNo);
        stmt.setString(9, this.expiryDate);
        stmt.setString(10, this.qty);
        stmt.setString(11, s_array[1]);
        stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
        
        Object_BLL_Common.write_log("Name: " + this.name, "");
        Object_BLL_Common.write_log("ID: " + this.medicineId, "");
        Object_BLL_Common.write_log("METHOD: " + s_array[0], "");
        
        return stmt;
	}
}