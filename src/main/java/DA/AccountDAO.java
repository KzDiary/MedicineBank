/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DA;

import Models.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author khanh
 */
public class AccountDAO {

    private Connection connection = new DBContext().connection;
    
    public void insertAccount(Account a) {
        String sql = "insert into Account(UUID,username,password,email,phone,roleid) values(?,?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, a.getUUID());
            pre.setString(2, a.getUsername());
            pre.setString(3, a.getPassword());
            pre.setString(4, a.getEmail());
            pre.setString(5, a.getPhone());
            pre.setInt(6, a.getRoleid());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    
    public boolean updateAccount(String uuid, String username, String email, String phone) {
        String sql = "UPDATE Account SET username = ?, email = ?, phone = ? WHERE UUID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, email);
            pre.setString(3, phone);
            pre.setString(4, uuid);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        return true;
    }
    
    
    public Account getAccountByUsername(String name) {
        Account a = null;
        String sql = "select * from Account where username = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String UUID = rs.getString("UUID");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                int roleid = rs.getInt("roleid");
                a=new Account(UUID,username,password,email,phone,roleid);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return a;
    }
    
    public String getRoleAccount(String UUID){
        String role=null;
        String sql = "select name from Account inner join Role on roleid = id where UUID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, UUID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                role = rs.getString("name");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return role;
    }


}
