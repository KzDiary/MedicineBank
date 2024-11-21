/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.LinkedHashMap;

/**
 *
 * @author Kz
 */
public class Medicine {
    private String regNumber,name;
    private boolean Rx;
    private String dosageForm,EXPDate;
    private Company company;
    private LinkedHashMap<String,String>  Ingredents;
    private String imgURL;

    public Medicine(){
    }
    public Medicine(String regNumber, String name, boolean Rx, String dosageForm, String EXPDate, Company company, LinkedHashMap Ingredents, String imgURL) {
        this.regNumber = regNumber;
        this.name = name;
        this.Rx = Rx;
        this.dosageForm = dosageForm;
        this.EXPDate = EXPDate;
        this.company = company;
        this.Ingredents = Ingredents;
        this.imgURL = imgURL;
    }

    public String getRegNumber() {
        return regNumber;
    }

    public void setRegNumber(String regNumber) {
        this.regNumber = regNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isRx() {
        return Rx;
    }

    public void setRx(boolean Rx) {
        this.Rx = Rx;
    }

    public String getDosageForm() {
        return dosageForm;
    }

    public void setDosageForm(String dosageForm) {
        this.dosageForm = dosageForm;
    }

    public String getEXPDate() {
        return EXPDate;
    }

    public void setEXPDate(String EXPDate) {
        this.EXPDate = EXPDate;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public LinkedHashMap<String,String> getIngredents() {
        return Ingredents;
    }

    public void setIngredents(LinkedHashMap<String,String>  Ingredents) {
        this.Ingredents = Ingredents;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
    

    
}
