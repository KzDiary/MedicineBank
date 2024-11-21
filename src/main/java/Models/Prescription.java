/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;
import java.util.LinkedHashMap;

/**
 *
 * @author Kz
 */
public class Prescription {
    private String UUID;
    private int ID;
    private String patientName,doctorName;
    private int age,weight,height;
    private Date createDate;
    private String diagnose,medicalHistory,Note;
    private LinkedHashMap<Medicine,String> medicineList;

    public Prescription(String UUID, String patientName, String doctorName, int age, int weight, int height, Date createDate, String diagnose, String medicalHistory, String note, LinkedHashMap<Medicine, String> medicineList) {
        this.UUID = UUID;
        this.patientName = patientName;
        this.doctorName = doctorName;
        this.age = age;
        this.weight = weight;
        this.height = height;
        this.createDate = createDate;
        this.diagnose = diagnose;
        this.medicalHistory = medicalHistory;
        Note = note;
        this.medicineList = medicineList;
    }

    public Prescription(String UUID, int ID, String patientName, String doctorName, int age, int weight, int height, Date createDate, String diagnose, String medicalHistory, String Note, LinkedHashMap<Medicine, String> medicineList) {
        this.UUID = UUID;
        this.ID = ID;
        this.patientName = patientName;
        this.doctorName = doctorName;
        this.age = age;
        this.weight = weight;
        this.height = height;
        this.createDate = createDate;
        this.diagnose = diagnose;
        this.medicalHistory = medicalHistory;
        this.Note = Note;
        this.medicineList = medicineList;
    }

    
    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }


    public String getUUID() {
        return UUID;
    }

    public void setUUID(String UUID) {
        this.UUID = UUID;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getDiagnose() {
        return diagnose;
    }

    public void setDiagnose(String diagnose) {
        this.diagnose = diagnose;
    }

    public String getMedicalHistory() {
        return medicalHistory;
    }

    public void setMedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }

    public String getNote() {
        return Note;
    }

    public void setNote(String Note) {
        this.Note = Note;
    }

    public LinkedHashMap<Medicine, String> getMedicineList() {
        return medicineList;
    }

    public void setMedicineList(LinkedHashMap<Medicine, String> medicineList) {
        this.medicineList = medicineList;
    }
    
}
