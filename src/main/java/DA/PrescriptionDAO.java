/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DA;

import Models.Medicine;
import Models.Prescription;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Optional;

/**
 *
 * @author khanh
 */
public class PrescriptionDAO {

    private Connection connection = new DBContext().connection;
    private MedicineDAO medDAO = new MedicineDAO();

///-----
    public List<Prescription> getPrescriptionOfAccount(String UUID) {
        List<Prescription> list = new ArrayList<>();
        String sql = "select * from Prescription where UUID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, UUID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int ID = rs.getInt("ID");
                String patientName = rs.getString("patientName");
                String doctorName = rs.getString("doctorName");
                int age = rs.getInt("age");
                int weight = rs.getInt("weight");
                int height = rs.getInt("height");
                Date createDate = rs.getDate("date");
                String diagnose = rs.getString("diagnose");
                String medicalHistory = rs.getString("medicalHistory");
                String Note = rs.getString("Note");
                LinkedHashMap MedicineList = getMedicineOfPres(ID);
                list.add(new Prescription(UUID, ID, patientName, doctorName, age, weight, height, createDate, diagnose, medicalHistory, Note, MedicineList));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getHighestPreID() {
        int ID = -1;
        String sql = "select top 1 ID from Prescription order by ID desc";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                ID = rs.getInt("ID");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return ID;
    }

    ///-----
    public LinkedHashMap getMedicineOfPres(int ID) {
        LinkedHashMap MedicinesList = new LinkedHashMap();
        String sql = "select * from Pres_Med where presID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, ID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                String medReg = rs.getString("medReg");
                String note = rs.getString("note");
                Medicine med = medDAO.getMedicineByReg(medReg);
                MedicinesList.put(med, note);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return MedicinesList;
    }

    public Prescription insertPrescription(String UUID, String patientName, String doctorName, int age, int weight, int height, Date date, String diagnose, String medicalHistory, String Note) {
        String sql = "INSERT INTO Prescription (UUID, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, Note) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, UUID);
            pre.setString(2, patientName);
            pre.setString(3, doctorName);
            pre.setInt(4, age);
            pre.setInt(5, weight);
            pre.setInt(6, height);
            pre.setDate(7, date);
            pre.setString(8, diagnose);
            pre.setString(9, medicalHistory);
            pre.setString(10, Note);
            pre.executeUpdate();
            return new Prescription(UUID, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, Note,null);
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }

    public boolean insertPresMedRelation(String UUID, int presID, String medReg, String note) {
        String sql = "INSERT INTO Pres_Med (UUID, presID, medReg, note) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, UUID);
            pre.setInt(2, presID);
            pre.setString(3, medReg);
            pre.setString(4, note);
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public void deletePresbyID(int ID) {
        deleteMedPresRelation(ID);
        String sql = "DELETE FROM Prescription WHERE ID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, ID);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean deleteMedPresRelation(int ID) {
        String sql = "DELETE FROM Pres_Med WHERE presID = ?";
        try {
            if (connection == null) {
                System.err.println("Database connection is not established.");
                return false;
            }

            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, ID);
            int affectedRows = pre.executeUpdate();

            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("SQL Exception occurred during deletion: " + e.getMessage());
            return false;
        }
    }


    public boolean updatePrescription(int ID, String patientName, String doctorName, int age, int weight, int height, Date date, String diagnose, String medicalHistory, String Note) {
        String sql = "UPDATE Prescription SET patientName = ?, doctorName = ?, age = ?, weight = ?, height = ?, date = ?, diagnose = ?, medicalHistory = ?, Note = ? WHERE ID = ?;";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, patientName);
            pre.setString(2, doctorName);
            pre.setInt(3, age);
            pre.setInt(4, weight);
            pre.setInt(5, height);
            pre.setDate(6, date);
            pre.setString(7, diagnose);
            pre.setString(8, medicalHistory);
            pre.setString(9, Note);
            pre.setInt(10, ID);
            pre.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public Optional<Prescription> getPrescriptionByID(int ID) {
        String sql = "SELECT * FROM Prescription WHERE ID = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, ID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                String UUID = rs.getString("UUID");
                String patientName = rs.getString("patientName");
                String doctorName = rs.getString("doctorName");
                int age = rs.getInt("age");
                int height = rs.getInt("height");
                int weight = rs.getInt("weight");
                Date date = rs.getDate("date");
                String diagnose = rs.getString("diagnose");
                String medicalHistory = rs.getString("medicalHistory");
                String note = rs.getString("Note");
                LinkedHashMap medicineList = getMedicineOfPres(ID);
                Prescription pres = new Prescription(UUID, ID, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, note, medicineList);
                return Optional.of(pres);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return Optional.empty();
    }

    public void setConnection(Connection mockConnection) {
        this.connection = mockConnection;
    }
}
