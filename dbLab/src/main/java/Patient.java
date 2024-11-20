import enumerations.Gender;

import java.sql.Date;
import java.util.List;

public class Patient {
    private int patient_id;
    private String last_name;
    private String first_name;
    private String middle_name;
    private java.sql.Date birty_date;
    private Gender gender;
    private String contact_number;
    private String city;
    private String province;
    private Short zip_code;

    private REFInsuranceInfo insuranceInfo;
    private List<Appointment> appointments;

    public int getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(int patient_id) {
        this.patient_id = patient_id;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getMiddle_name() {
        return middle_name;
    }

    public void setMiddle_name(String middle_name) {
        this.middle_name = middle_name;
    }

    public Date getBirty_date() {
        return birty_date;
    }

    public void setBirty_date(Date birty_date) {
        this.birty_date = birty_date;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getContact_number() {
        return contact_number;
    }

    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public Short getZip_code() {
        return zip_code;
    }

    public void setZip_code(Short zip_code) {
        this.zip_code = zip_code;
    }

    public REFInsuranceInfo getInsuranceInfo() {
        return insuranceInfo;
    }

    public void setInsuranceInfo(REFInsuranceInfo insuranceInfo) {
        this.insuranceInfo = insuranceInfo;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }
}
