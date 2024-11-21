package DA;

import Models.Prescription;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

public class PrescriptionDAOTest {

    @Mock
    private Connection mockConnection;

    @Mock
    private PreparedStatement mockPreparedStatement;

    @Mock
    private ResultSet mockResultSet;

    @InjectMocks
    @Spy
    private PrescriptionDAO prescriptionDAO;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.openMocks(this);
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);

        prescriptionDAO.setConnection(mockConnection);
//        prescriptionDAO = spy(prescriptionDAO);
    }


    @Test
    public void testGetPrescriptionOfAccount_Success() throws SQLException {
        String uuid = "UUID-1234";

        when(mockResultSet.next()).thenReturn(true).thenReturn(false); // One result
        when(mockResultSet.getInt("ID")).thenReturn(1);
        when(mockResultSet.getString("patientName")).thenReturn("John Doe");
        when(mockResultSet.getString("doctorName")).thenReturn("Dr. Smith");
        when(mockResultSet.getInt("age")).thenReturn(30);
        when(mockResultSet.getInt("weight")).thenReturn(70);
        when(mockResultSet.getInt("height")).thenReturn(175);
        when(mockResultSet.getDate("date")).thenReturn(new Date(2022,11,11));
        when(mockResultSet.getString("diagnose")).thenReturn("Flu");
        when(mockResultSet.getString("medicalHistory")).thenReturn("No significant history");
        when(mockResultSet.getString("Note")).thenReturn("Take rest");

        List<Prescription> result = prescriptionDAO.getPrescriptionOfAccount(uuid);

        Assert.assertNotNull(result);
        Assert.assertEquals(1, result.size());
        Prescription prescription = result.get(0);
        Assert.assertEquals(uuid, prescription.getUUID());
        Assert.assertEquals(1, prescription.getID());
        Assert.assertEquals("John Doe", prescription.getPatientName());
        Assert.assertEquals("Dr. Smith", prescription.getDoctorName());
        Assert.assertEquals(30, prescription.getAge());
        Assert.assertEquals(70, prescription.getWeight());
        Assert.assertEquals(175, prescription.getHeight());
        Assert.assertNotNull(prescription.getCreateDate());
        Assert.assertEquals("Flu", prescription.getDiagnose());
        Assert.assertEquals("No significant history", prescription.getMedicalHistory());
        Assert.assertEquals("Take rest", prescription.getNote());

        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement, times(2)).executeQuery();
    }

    @Test
    public void testGetPrescriptionOfAccount_SQLException() throws SQLException {
        String uuid = "UUID-failed";

        when(mockPreparedStatement.executeQuery()).thenThrow(new SQLException("SQL error"));

        List<Prescription> result = prescriptionDAO.getPrescriptionOfAccount(uuid);

        Assert.assertNotNull(result);
        Assert.assertTrue(result.isEmpty());
        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetHighestPreID_ReturnsCorrectID() throws SQLException {
        when(mockResultSet.next()).thenReturn(true).thenReturn(false);
        when(mockResultSet.getInt("ID")).thenReturn(5);


        int result = prescriptionDAO.getHighestPreID();

        Assert.assertEquals(5, result);

        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetHighestPreID_NoRecords() throws SQLException {
        when(mockResultSet.next()).thenReturn(false);

        int result = prescriptionDAO.getHighestPreID();

        Assert.assertEquals(-1, result);

        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testInsertPrescription_Success() throws SQLException {
        String uuid = "UUID-1234";
        String patientName = "John Doe";
        String doctorName = "Dr. Smith";
        int age = 30;
        int weight = 70;
        int height = 175;
        Date date = new Date(2000,12,12);
        String diagnose = "Flu";
        String medicalHistory = "No significant history";
        String note = "Take rest";

        Prescription result = prescriptionDAO.insertPrescription(uuid, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, note);

        Assert.assertNotNull(result);
        Assert.assertEquals(uuid, result.getUUID());
        Assert.assertEquals(patientName, result.getPatientName());
        Assert.assertEquals(doctorName, result.getDoctorName());
        Assert.assertEquals(age, result.getAge());
        Assert.assertEquals(weight, result.getWeight());
        Assert.assertEquals(height, result.getHeight());
        Assert.assertEquals(date, result.getCreateDate());
        Assert.assertEquals(diagnose, result.getDiagnose());
        Assert.assertEquals(medicalHistory, result.getMedicalHistory());
        Assert.assertEquals(note, result.getNote());

        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement).setString(2, patientName);
        verify(mockPreparedStatement).setString(3, doctorName);
        verify(mockPreparedStatement).setInt(4, age);
        verify(mockPreparedStatement).setInt(5, weight);
        verify(mockPreparedStatement).setInt(6, height);
        verify(mockPreparedStatement).setDate(7, (java.sql.Date) date);
        verify(mockPreparedStatement).setString(8, diagnose);
        verify(mockPreparedStatement).setString(9, medicalHistory);
        verify(mockPreparedStatement).setString(10, note);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testInsertPrescription_SQLException() throws SQLException {
        String uuid = "UUID-1234";
        String patientName = "John Doe";
        String doctorName = "Dr. Smith";
        int age = 30;
        int weight = 70;
        int height = 175;
        Date date = new Date(2000,12,12);
        String diagnose = "Flu";
        String medicalHistory = "No significant history";
        String note = "Take rest";

        when(mockConnection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));

        Prescription result = prescriptionDAO.insertPrescription(uuid, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, note);

        Assert.assertNull(result);
    }



    @Test
    public void testInsertPresMedRelation_Success() throws SQLException {
        String uuid = "UUID-1234";
        int presID = 1;
        String medReg = "MedReg-001";
        String note = "Take with water";

        boolean result = prescriptionDAO.insertPresMedRelation(uuid, presID, medReg, note);

        Assert.assertTrue(result);

        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement).setInt(2, presID);
        verify(mockPreparedStatement).setString(3, medReg);
        verify(mockPreparedStatement).setString(4, note);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testInsertPresMedRelation_SQLException() throws SQLException {
        String uuid = "UUID-1234";
        int presID = 1;
        String medReg = "MedReg-001";
        String note = "Take with water";

        when(mockConnection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));

        boolean result = prescriptionDAO.insertPresMedRelation(uuid, presID, medReg, note);

        Assert.assertFalse(result);
    }

    @Test
    public void testDeletePresbyID_Success() throws SQLException {
        int id = 1;

        when(prescriptionDAO.deleteMedPresRelation(id)).thenReturn(true);

        prescriptionDAO.deletePresbyID(id);

        verify(mockPreparedStatement, times(2)).setInt(1, id);
        verify(mockPreparedStatement, times(2)).executeUpdate();
    }

    @Test
    public void testDeleteMedPresRelation_Success() throws SQLException {
        int id = 1;
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);

        boolean result = prescriptionDAO.deleteMedPresRelation(id);

        Assert.assertTrue(result);
        verify(mockPreparedStatement).setInt(1, id);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testDeleteMedPresRelation_NoRowsAffected() throws SQLException {
        int id = 1;
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);

        boolean result = prescriptionDAO.deleteMedPresRelation(id);

        Assert.assertFalse(result);
    }

    @Test
    public void testDeleteMedPresRelation_SQLException() throws SQLException {
        when(mockPreparedStatement.executeUpdate()).thenThrow(new SQLException("Database error"));

        boolean result = prescriptionDAO.deleteMedPresRelation(1);

        Assert.assertFalse(result);
    }

    @Test
    public void testUpdatePrescription_Success() throws SQLException {
        int id = 1;
        String patientName = "John Doe";
        String doctorName = "Dr. Smith";
        int age = 30;
        int weight = 70;
        int height = 175;
        Date date = Date.valueOf("2024-01-01");
        String diagnose = "Flu";
        String medicalHistory = "No previous conditions";
        String note = "Follow-up in a week";

        when(mockPreparedStatement.executeUpdate()).thenReturn(1);

        boolean result = prescriptionDAO.updatePrescription(id, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, note);

        Assert.assertTrue(result);
        verify(mockPreparedStatement).setString(1, patientName);
        verify(mockPreparedStatement).setString(2, doctorName);
        verify(mockPreparedStatement).setInt(3, age);
        verify(mockPreparedStatement).setInt(4, weight);
        verify(mockPreparedStatement).setInt(5, height);
        verify(mockPreparedStatement).setDate(6, date);
        verify(mockPreparedStatement).setString(7, diagnose);
        verify(mockPreparedStatement).setString(8, medicalHistory);
        verify(mockPreparedStatement).setString(9, note);
        verify(mockPreparedStatement).setInt(10, id);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testUpdatePrescription_SQLException() throws SQLException {
        int id = 1;
        String patientName = "John Doe";
        String doctorName = "Dr. Smith";
        int age = 30;
        int weight = 70;
        int height = 175;
        Date date = Date.valueOf("2024-01-01");
        String diagnose = "Flu";
        String medicalHistory = "No previous conditions";
        String note = "Follow-up in a week";

        when(mockPreparedStatement.executeUpdate()).thenThrow(new SQLException("Database error"));

        boolean result = prescriptionDAO.updatePrescription(id, patientName, doctorName, age, weight, height, date, diagnose, medicalHistory, note);

        Assert.assertFalse(result);
    }

    @Test
    public void testGetPrescriptionByID_Found() throws SQLException {
        int id = 1;
        when(mockResultSet.next()).thenReturn(true).thenReturn(false);
        when(mockResultSet.getString("UUID")).thenReturn("1234-UUID");
        when(mockResultSet.getString("patientName")).thenReturn("John Doe");
        when(mockResultSet.getString("doctorName")).thenReturn("Dr. Smith");
        when(mockResultSet.getInt("age")).thenReturn(30);
        when(mockResultSet.getInt("weight")).thenReturn(70);
        when(mockResultSet.getInt("height")).thenReturn(175);
        when(mockResultSet.getDate("date")).thenReturn(Date.valueOf("2024-01-01"));
        when(mockResultSet.getString("diagnose")).thenReturn("Flu");
        when(mockResultSet.getString("medicalHistory")).thenReturn("No previous conditions");
        when(mockResultSet.getString("Note")).thenReturn("Follow-up in a week");

        Optional<Prescription> prescriptionOpt = prescriptionDAO.getPrescriptionByID(id);

        Assert.assertTrue(prescriptionOpt.isPresent());
        Prescription prescription = prescriptionOpt.get();
        Assert.assertEquals("1234-UUID", prescription.getUUID());
        Assert.assertEquals("John Doe", prescription.getPatientName());
        Assert.assertEquals("Dr. Smith", prescription.getDoctorName());
        Assert.assertEquals(30, prescription.getAge());
    }

    @Test
    public void testGetPrescriptionByID_NotFound() throws SQLException {
        when(mockResultSet.next()).thenReturn(false);

        Optional<Prescription> prescriptionOpt = prescriptionDAO.getPrescriptionByID(1);

        Assert.assertFalse(prescriptionOpt.isPresent());
    }

    @Test
    public void testGetPrescriptionByID_SQLException() throws SQLException {
        when(mockPreparedStatement.executeQuery()).thenThrow(new SQLException("Database error"));

        Optional<Prescription> prescriptionOpt = prescriptionDAO.getPrescriptionByID(1);

        Assert.assertFalse(prescriptionOpt.isPresent());
    }

}