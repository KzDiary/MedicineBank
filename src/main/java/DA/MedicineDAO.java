/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DA;

import Models.Company;
import Models.Medicine;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedHashMap;

/**
 *
 * @author khanh
 */
public class MedicineDAO {

     private Connection connection = new DBContext().connection;

    public List<Medicine> getMedicine() {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine";

        try (PreparedStatement pre = connection.prepareStatement(sql);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                String regNumber = rs.getString("regNumber");
                String name = rs.getString("name");
                Boolean Rx = rs.getBoolean("Rx");
                String dosageForm = rs.getString("dosageForm");
                String EXPDate = rs.getString("EXPDate");
                String GCN = rs.getString("GCN");
                CompanyDAO comDAO = new CompanyDAO();
                Company company = comDAO.getCompanyByGCN(GCN);
                LinkedHashMap<String, String> ingredients = getIngredentOfMedicine(regNumber); // Correct type used
                String imgURL = rs.getString("imgURL");
                list.add(new Medicine(regNumber, name, Rx, dosageForm, EXPDate, company, ingredients, imgURL));
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching medicines", e); // Better error handling
        }
    }


    public int getTotalMedicine(){
        int count = 0;
        String sql = "select * from Medicine";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return count;
    }

    public List<Medicine> getMedicineByGCN(String GCN) {
        List<Medicine> list = new ArrayList<>();
        String sql = "select * from Medicine where GCN = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, GCN);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String regNumber = rs.getString("regNumber");
                String name = rs.getString("name");
                Boolean Rx = rs.getBoolean("Rx");
                String dosageForm = rs.getString("dosageForm");
                String EXPDate = rs.getString("EXPDate");
                CompanyDAO ComDAO = new CompanyDAO();
                Company company = ComDAO.getCompanyByGCN(GCN);
                LinkedHashMap Ingredents = getIngredentOfMedicine(regNumber);
                String imgURL = rs.getString("imgURL");
                list.add(new Medicine(regNumber, name, Rx, dosageForm, EXPDate, company, Ingredents, imgURL));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    
    public List<Medicine> searchMedicine(String search) {
        List<Medicine> list = new ArrayList<>();
        String sql = "select * from Medicine where name like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            String searchQuery = "%" + search + "%";
            pre.setString(1, searchQuery);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String regNumber = rs.getString("regNumber");
                String name = rs.getString("name");
                Boolean Rx = rs.getBoolean("Rx");
                String dosageForm = rs.getString("dosageForm");
                String EXPDate = rs.getString("EXPDate");
                String GCN = rs.getString("GCN");
                CompanyDAO ComDAO = new CompanyDAO();
                Company company = ComDAO.getCompanyByGCN(GCN);
                LinkedHashMap Ingredents = getIngredentOfMedicine(regNumber);
                String imgURL = rs.getString("imgURL");
                list.add(new Medicine(regNumber, name, Rx, dosageForm, EXPDate, company, Ingredents, imgURL));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
        public List<Medicine> getMedicineByIngredent(String ingreName) {
        List<Medicine> list = new ArrayList<>();
        String sql = "select * from Med_Ingre where ingreName like ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, ingreName);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String regNumber = rs.getString("medReg");
                Medicine med = this.getMedicineByReg(regNumber);
                list.add(med);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public LinkedHashMap<String,String> getIngredentOfMedicine(String medName) {
        LinkedHashMap<String,String> Ingredents = new LinkedHashMap();
        String sql = "select * from Med_Ingre where medReg = ?";
        try(PreparedStatement pre = connection.prepareStatement(sql)){
            pre.setString(1, medName);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String ingreName = rs.getString("ingreName");
                String dosageAmount = rs.getString("dosageAmount");
                Ingredents.put(ingreName, dosageAmount);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return Ingredents;
    }

    public void insertMedicine(String regNumber, String medName, Boolean Rx, String dosageForm, String EXPDate, String GCN, String imgURL) {
        String sql = "INSERT INTO Medicine (regNumber, name, Rx, dosageForm, EXPDate, GCN, imgURL) VALUES (?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, regNumber);
            pre.setString(2, medName);
            pre.setBoolean(3, Rx);
            pre.setString(4, dosageForm);
            pre.setString(5, EXPDate);
            pre.setString(6, GCN);
            pre.setString(7, imgURL);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateMedicine(String regNumber, boolean Rx, String dosageForm, String EXPDate, String GCN, String imgURL) {
        String sql = "UPDATE Medicine SET Rx = ?, dosageForm = ?, EXPDate = ?, GCN = ?, imgURL = ? WHERE regNumber = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setBoolean(1, Rx);
            pre.setString(2, dosageForm);
            pre.setString(3, EXPDate);
            pre.setString(4, GCN);
            pre.setString(5, imgURL);
            pre.setString(6, regNumber);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteMedicinebyRegNumber(String regNumber) {
        this.deleteMedPresRelation(regNumber);
        deleteMedIngredentRelation(regNumber);
        String sql = "DELETE FROM Medicine WHERE regNumber = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, regNumber);
            pre.executeQuery();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
        public void deleteMedPresRelation(String medReg) {
        String sql = "DELETE FROM Pres_Med WHERE medReg = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, medReg);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }


    public void deleteMedicinebyGCN(String GCN) {
        List<String> list = getMedRegByGCN(GCN);
        list.forEach((n) -> {
            this.deleteMedPresRelation(n);
            deleteMedIngredentRelation(n);
            deleteMedicinebyRegNumber(n);
        });
    }

    

    public List<String> getMedRegByGCN(String GCN) {
        List<String> list = new ArrayList();
        String sql = "select * from Medicine where GCN = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, GCN);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String regNumber = rs.getString("regNumber");
                list.add(regNumber);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void deleteMedIngredentRelation(String regNumber) {
        String sql = "DELETE FROM Med_Ingre WHERE medReg = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, regNumber);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertMedIngredientRelation(String medReg, String ingredient, String dosageAmount) {
        String sql = "INSERT INTO Med_Ingre (medReg, ingreName, dosageAmount) VALUES (?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, medReg);
            pre.setString(2, ingredient);
            pre.setString(3, dosageAmount);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Medicine getMedicineByReg(String regNumber) {
        Medicine med = null;
        String sql = "select * from Medicine where regNumber = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, regNumber);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                Boolean Rx = rs.getBoolean("Rx");
                String dosageForm = rs.getString("dosageForm");
                String EXPDate = rs.getString("EXPDate");
                String GCN = rs.getString("GCN");
                CompanyDAO ComDAO = new CompanyDAO();
                Company company = ComDAO.getCompanyByGCN(GCN);
                LinkedHashMap Ingredents = getIngredentOfMedicine(regNumber);
                String imgURL = rs.getString("imgURL");
                med = new Medicine(regNumber, name, Rx, dosageForm, EXPDate, company, Ingredents, imgURL);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return med;
    }



    public static void main(String[] args) {
        MedicineDAO DAO = new MedicineDAO();
        for (Medicine a : DAO.getMedicine()) {
            System.out.println(a.getName());
        }
//        Medicine m = DAO.getMedicineByReg("VD-18416-13");
//        System.out.println(m.getRegNumber() + m.getName());
//
//        System.out.println(DAO.getTotalMedicine());
    }

}
