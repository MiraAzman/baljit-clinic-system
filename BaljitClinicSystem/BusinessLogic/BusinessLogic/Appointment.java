package BusinessLogic;

public class Appointment {

    private int app_id;
    private String app_description;
    private String app_patientid;
    private String app_doctorid;
    private String app_date;
    private String app_starttime;
    private String app_endtime;
    private String createdby;
    private String createddt;

    public Appointment(){
        this.app_description = "";
        this.app_patientid = "";
        this.app_doctorid = "";
        this.app_date = "";
        this.app_starttime = "";
        this.app_endtime = "";
        this.createdby = "";
        this.createddt = "";
    }

    public Appointment(String app_description, String app_patientid, String app_doctorid, String app_date, String app_starttime, String app_endtime, String createdby, String createddt) {
        this.app_description = app_description;
        this.app_patientid = app_patientid;
        this.app_doctorid = app_doctorid;
        this.app_date = app_date;
        this.app_starttime = app_starttime;
        this.app_endtime = app_endtime;
        this.createdby = createdby;
        this.createddt = createddt;
    }

    //getter
    public int getApp_id() {
        return app_id;
    }

    public String getApp_description() {
        return app_description;
    }

    public String getApp_patientid() {
        return app_patientid;
    }

    public String getApp_doctorid() {
        return app_doctorid;
    }

    public String getApp_date() {
        return app_date;
    }

    public String getApp_starttime() {
        return app_starttime;
    }

    public String getApp_endtime() {
        return app_endtime;
    }

    public String getCreatedby() {
        return createdby;
    }

    public String getCreateddt() {
        return createddt;
    }
    
    //setter
    public void setApp_id(int app_id) {
        this.app_id = app_id;
    }

    public void setApp_description(String app_description) {
        this.app_description = app_description;
    }

    public void setApp_patientid(String app_patientid) {
        this.app_patientid = app_patientid;
    }

    public void setApp_doctorid(String app_doctorid) {
        this.app_doctorid = app_doctorid;
    }

    public void setApp_date(String app_date) {
        this.app_date = app_date;
    }

    public void setApp_starttime(String app_starttime) {
        this.app_starttime = app_starttime;
    }

    public void setApp_endtime(String app_endtime) {
        this.app_endtime = app_endtime;
    }

    public void setCreatedby(String createdby) {
        this.createdby = createdby;
    }

    public void setCreateddt(String createddt) {
        this.createddt = createddt;
    }
    
}