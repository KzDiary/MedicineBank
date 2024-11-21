/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DA;

import Models.Ingredent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


/**
 *
 * @author khanh
 */
public class IngredentDAO {

    private Connection connection = new DBContext().connection;


    public List<Ingredent> getIngredents() {
        List<Ingredent> list = new ArrayList<>();
        String sql = "SELECT * FROM Ingredent";

        try (PreparedStatement pre = connection.prepareStatement(sql);
             ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                String name = rs.getString("name");
                String formula = rs.getString("formula");
                String description = rs.getString("description");
                list.add(new Ingredent(name, formula, description));
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
        }
        return list;
    }

    public Optional<Ingredent> getIngredentByName(String name) {
        String sql = "SELECT * FROM Ingredent WHERE name = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, name);
            try (ResultSet rs = pre.executeQuery()) {
                if (rs.next()) {
                    String ingreName = rs.getString("name");
                    String formula = rs.getString("formula");
                    String description = rs.getString("description");
                    return Optional.of(new Ingredent(ingreName, formula, description));
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
        }
        return Optional.empty();
    }
    
    public boolean checkIngredentExist(String name) {
        String sql = "select * from Ingredent where name = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, name);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public Ingredent insertIngredents(String name, String formula, String description) {
        String sql = "INSERT INTO Ingredent (name, formula, description) VALUES (?, ?, ?)";
        try(PreparedStatement pre = connection.prepareStatement(sql)){
            pre.setString(1, name);
            pre.setString(2, formula);
            pre.setString(3, description);
            pre.executeUpdate();
            return new Ingredent(name, formula, description);
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
    
    public boolean deleteIngredents(String name){
        deleteMedIngredentRelationByIngre(name);
        String sql = "DELETE FROM Ingredent WHERE name = ?";
        try(PreparedStatement pre = connection.prepareStatement(sql)){
            pre.setString(1, name);
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public Ingredent updateIngredents(String name, String formula, String des) {
        String sql = "UPDATE Ingredent SET formula = ?, description = ? WHERE name = ?;";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, formula);
            pre.setString(2, des);
            pre.setString(3, name);
            int rowsAffected = pre.executeUpdate();
            if (rowsAffected > 0) {
                return new Ingredent(name, formula, des);
            } else {
                return null;
            }
        } catch (SQLException e) {
            System.out.println("Error updating ingredient: " + e.getMessage());
            return null;
        }
    }

    public void deleteMedIngredentRelationByIngre(String name) {
        String sql = "DELETE FROM Med_Ingre WHERE ingreName = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, name);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
