package BusinessLogic;

import java.sql.CallableStatement;

import javax.servlet.http.HttpServletRequest;

import BusinessLogic.BLL_Common;

public class Patient {
	
	public static BLL_Common Object_BLL_Common = new BLL_Common();
	
	private String patientId;
	private String name;
	private String icNo;
	private String dob;
	private String contactNo;
	private String email;
	private String gender;
	private String address;
	private String nationality;
	private String ethnicGroup;
	private String bloodGroup;
	private String height;
	private String weight;
	private String healthHistory;
	private String allergyNotes;
	private String isSmoking;
	private String isAlcohol;
	private String isPregnant;
	private String panelCompany;
	private String employeeName;
	private String employeeCode;
	private String relationship;
	
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIcNo() {
		return icNo;
	}
	public void setIcNo(String icNo) {
		this.icNo = icNo;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getContactNo() {
		return contactNo;
	}
	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getEthnicGroup() {
		return ethnicGroup;
	}
	public void setEthnicGroup(String ethnicGroup) {
		this.ethnicGroup = ethnicGroup;
	}
	public String getBloodGroup() {
		return bloodGroup;
	}
	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getHealthHistory() {
		return healthHistory;
	}
	public void setHealthHistory(String healthHistory) {
		this.healthHistory = healthHistory;
	}
	public String getAllergyNotes() {
		return allergyNotes;
	}
	public void setAllergyNotes(String allergyNotes) {
		this.allergyNotes = allergyNotes;
	}
	public String getIsSmoking() {
		return isSmoking;
	}
	public void setIsSmoking(String isSmoking) {
		this.isSmoking = isSmoking;
	}
	public String getIsAlcohol() {
		return isAlcohol;
	}
	public void setIsAlcohol(String isAlcohol) {
		this.isAlcohol = isAlcohol;
	}
	public String getIsPregnant() {
		return isPregnant;
	}
	public void setIsPregnant(String isPregnant) {
		this.isPregnant = isPregnant;
	}
	public String getPanelCompany() {
		return panelCompany;
	}
	public void setPanelCompany(String panelCompany) {
		this.panelCompany = panelCompany;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getEmployeeCode() {
		return employeeCode;
	}
	public void setEmployeeCode(String employeeCode) {
		this.employeeCode = employeeCode;
	}
	public String getRelationship() {
		return relationship;
	}
	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	
	public void setPatient(HttpServletRequest request, String sIndex) {
		
		String sDOB = null;
		String dHeight = "0";
        String dWeight = "0";
        
        if (!request.getParameter("DOB").equals("")) {
            sDOB = request.getParameter("DOB"); 
        }
		if (!request.getParameter("HEIGHT").equals("")) {
            dHeight = request.getParameter("HEIGHT"); 
        }       
        if (!request.getParameter("WEIGHT").equals("")) {
            dWeight = request.getParameter("WEIGHT"); 
        }
		
        this.patientId = sIndex;
        this.name = request.getParameter("NAME");
        this.icNo = request.getParameter("IC_NO");
        this.dob = sDOB;
        this.contactNo = request.getParameter("CONTACT_NO");
        this.email = request.getParameter("EMAIL");
        this.gender = request.getParameter("GENDER");
        this.address = request.getParameter("ADDRESS");
        this.nationality = request.getParameter("NATIONALITY");
        
        this.ethnicGroup = request.getParameter("ETHNIC_GROUP");
        this.bloodGroup = request.getParameter("BLOOD_GROUP");
        this.height = dHeight;
        this.weight = dWeight;
        this.healthHistory = request.getParameter("HEALTH_HISTORY");
        this.allergyNotes = request.getParameter("ALLERGY_NOTES");
        this.isSmoking = request.getParameter("IS_SMOKING");
        this.isAlcohol = request.getParameter("IS_ALCOHOL");
        this.isPregnant = request.getParameter("IS_PREGNANT");
        this.panelCompany = request.getParameter("PANEL_COMPANY");
        
        this.employeeName = request.getParameter("EMPLOYEE_NAME");
        this.employeeCode = request.getParameter("EMPLOYEE_CODE");
        this.relationship = request.getParameter("RELATIONSHIP");
	}
	
	public CallableStatement set_SP_TRX_PATIENT_param(CallableStatement stmt, String SP_Method, String userCode) throws Exception {
				
		stmt.setString(1, SP_Method);
        stmt.setString(2, this.patientId); 
        stmt.setString(3, this.name);
        stmt.setString(4, this.icNo);
        stmt.setString(5, this.dob);
        stmt.setString(6, this.contactNo);
        stmt.setString(7, this.email);
        stmt.setString(8, this.gender);
        stmt.setString(9, this.address);
        stmt.setString(10, this.nationality);
        
        stmt.setString(11, this.ethnicGroup);
        stmt.setString(12, this.bloodGroup);
        stmt.setString(13, this.height);
        stmt.setString(14, this.weight);
        stmt.setString(15, this.healthHistory);
        stmt.setString(16, this.allergyNotes);
        stmt.setString(17, this.isSmoking);
        stmt.setString(18, this.isAlcohol);
        stmt.setString(19, this.isPregnant);
        stmt.setString(20, this.panelCompany);
        
        stmt.setString(21, this.employeeName);
        stmt.setString(22, this.employeeCode);
        stmt.setString(23, this.relationship);
        stmt.setString(24, userCode);
        stmt.registerOutParameter(25, java.sql.Types.VARCHAR);
        
        return stmt;
	}
}
