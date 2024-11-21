package model.entities;

import model.enumerations.Gender;
import jakarta.persistence.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.Set;

@Entity
@Table(name = "patients", schema = "diagnosticsdb", indexes = {
        @Index(name = "fk_Patients_InsuranceInfo1_idx", columnList = "insurance_provider")
}, uniqueConstraints = {
        @UniqueConstraint(name = "contact_number_UNIQUE", columnNames = {"contact_number"})
})
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "patient_id", nullable = false)
    private Integer id;

    @Column(name = "last_name", nullable = false, length = 20)
    private String lastName;

    @Column(name = "first_name", nullable = false, length = 20)
    private String firstName;

    @Column(name = "middle_name", nullable = false, length = 20)
    private String middleName;

    @Column(name = "date_of_birth", nullable = false)
    private LocalDate dateOfBirth;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = false)
    private Gender gender;

    @Column(name = "contact_number", nullable = false, length = 13)
    private String contactNumber;

    @Column(name = "street", nullable = false, length = 45)
    private String street;

    @Column(name = "city", nullable = false, length = 45)
    private String city;

    @Column(name = "province", nullable = false, length = 45)
    private String province;

    @Column(name = "zip_code", nullable = false)
    private Integer zipCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    @JoinColumn(name = "insurance_provider")
    private RefInsuranceinfo insuranceProvider;

    @OneToMany(mappedBy = "patient")
    private Set<Appointment> appointments = new LinkedHashSet<>();

    public Patient() {

    }

    public Integer getId() {
        return id;
    }

    public Patient(String lastName, String firstName, String middleName, LocalDate dateOfBirth, Gender gender,
                   String contactNumber, String street, String city, String province, Integer zipCode,
                   RefInsuranceinfo insuranceProvider) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.middleName = middleName;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.contactNumber = contactNumber;
        this.street = street;
        this.city = city;
        this.province = province;
        this.zipCode = zipCode;
        this.insuranceProvider = insuranceProvider;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
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

    public Integer getZipCode() {
        return zipCode;
    }

    public void setZipCode(Integer zipCode) {
        this.zipCode = zipCode;
    }

    public RefInsuranceinfo getInsuranceProvider() {
        return insuranceProvider;
    }

    public void setInsuranceProvider(RefInsuranceinfo insuranceProvider) {
        this.insuranceProvider = insuranceProvider;
    }

    public Set<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(Set<Appointment> appointments) {
        this.appointments = appointments;
    }

}