/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Kz
 */
public class Company {
    private String GCN, name, address, phone,imgURL;

    public Company(){
    }
    public Company(String GCN, String name, String address, String phone,String imgURL) {
        this.GCN = GCN;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.imgURL = imgURL;
    }

    
    public String getGCN() {
        return GCN;
    }

    public void setGCN(String GCN) {
        this.GCN = GCN;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }
    
}
