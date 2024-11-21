/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DA;

import Models.Company;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author khanh
 */
public class CompanyDAO{

    Connection connection = new DBContext().connection;

    public List<Company> getCompany() {
        List<Company> list = new ArrayList<>();
        String sql = "select * from Company";
        try (PreparedStatement pre = connection.prepareStatement(sql)){
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String GCN = rs.getString("GCN");
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String imgURL = rs.getString("imgURL");
                list.add(new Company(GCN, name,address,phone,imgURL));
            }
        } catch (SQLException e) {
            System.out.println(e);;
        }
        return list;
    }

    public Company insertCompany(String GCN, String name, String address, String phone, String imgURL) throws SQLException {
        String sql = "INSERT INTO Company (GCN, name, address, phone, imgURL) VALUES (?, ?, ?, ?, ?)";
        try  {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, GCN);
            pre.setString(2, name);
            pre.setString(3, address);
            pre.setString(4, phone);
            pre.setString(5, imgURL);

            int affectedRows = pre.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Inserting company failed, no rows affected.");
            }

            return new Company(GCN, name, address, phone, imgURL);
        } catch (SQLException e) {
            throw new SQLException("Inserting company failed, no rows affected.");
        }
    }

    public boolean checkCompanyExist(String GCN){
        String sql = "select * from Company where GCN = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)){
            pre.setString(1, GCN);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public Company getCompanyByGCN(String GCN) {
        String sql = "SELECT * FROM Company WHERE GCN = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, GCN);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) { // Check if there is a result
                String name = rs.getString("name");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String imgURL = rs.getString("imgURL");
                return new Company(GCN, name, address, phone, imgURL);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving company: " + e.getMessage());
        }
        return null;
    }
        
    public void deleteCompany(String GCN) {
        MedicineDAO medDao = new MedicineDAO();
        medDao.deleteMedicinebyGCN(GCN);
        String sql = "DELETE FROM Company WHERE GCN = ?";
        try(PreparedStatement pre = connection.prepareStatement(sql)){
            pre.setString(1, GCN);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }



    public boolean updateCompany(String GCN, String name, String address, String phone, String imgURL) {
        String sql = "UPDATE Company SET name = ?, address = ?, phone = ?, imgURL = ? WHERE GCN = ?;";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, name);
            pre.setString(2, address);
            pre.setString(3, phone);
            pre.setString(4, imgURL);
            pre.setString(5, GCN);

            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating company: " + e.getMessage());
            return false;
        }
    }
}
