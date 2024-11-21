package DA;

import Models.Medicine;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import static org.junit.Assert.assertThrows;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

public class MedicineDAOTest {

//    private final CompanyDAO companyDAO = spy(new CompanyDAO());
    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement mockPreparedStatement;

    @Mock
    private ResultSet mockResultSet;

    @InjectMocks
    private MedicineDAO medicineDAO;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.openMocks(this);
        when(connection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
        medicineDAO = spy(medicineDAO);
    }

//    @Test
//    public void testGetMedicine_Success() throws SQLException {
//        when(connection.prepareStatement(any(String.class))).thenReturn(mockPreparedStatement);
//
//
//        when(mockResultSet.next()).thenReturn(true).thenReturn(false);
//        when(mockResultSet.getString("regNumber")).thenReturn("REG123");
//        when(mockResultSet.getString("name")).thenReturn("Aspirin");
//        when(mockResultSet.getBoolean("Rx")).thenReturn(false);
//        when(mockResultSet.getString("dosageForm")).thenReturn("Tablet");
//        when(mockResultSet.getString("EXPDate")).thenReturn("2025-12-31");
//        when(mockResultSet.getString("GCN")).thenReturn("GCN123");
//
//        Company company = new Company("GCN123","ABC","ABC","","");
//        companyDAO.connection = connection;
//        when(companyDAO.getCompanyByGCN("GCN123")).thenReturn(company);
//        when(mockResultSet.getString("imgURL")).thenReturn("http://example.com/image.jpg");
//
//
//        LinkedHashMap<String, String> mockIngredients = new LinkedHashMap<>();
//        mockIngredients.put("Ingredient1", "Value1");
//        when(medicineDAO.getIngredentOfMedicine("REG123")).thenReturn(mockIngredients);
//
//        List<Medicine> result = medicineDAO.getMedicine();
//
//        assertNotNull(result);
//        assertEquals(1, result.size());
//
//        Medicine medicine = result.get(0);
//        assertEquals("REG123", medicine.getRegNumber());
//        assertEquals("Aspirin", medicine.getName());
//        assertFalse(medicine.isRx());
//        assertEquals("Tablet", medicine.getDosageForm());
//        assertEquals("2025-12-31", medicine.getEXPDate());
//        assertEquals(company, medicine.getCompany());
//        assertEquals(mockIngredients, medicine.getIngredents());
//        assertEquals("http://example.com/image.jpg", medicine.getImgURL());
//    }


    @Test
    public void testGetMedicine_EmptyResultSet() throws SQLException {
        when(mockResultSet.next()).thenReturn(false);

        List<Medicine> result = medicineDAO.getMedicine();

        Assert.assertNotNull(result);
        Assert.assertTrue(result.isEmpty());
    }

    @Test
    public void testGetMedicine_SQLException() throws SQLException {
        when(mockPreparedStatement.executeQuery()).thenThrow(new SQLException("Database error"));

        assertThrows(RuntimeException.class, () -> {
            medicineDAO.getMedicine();
        });
    }

    @Test
    public void testGetTotalMedicine_Success() throws SQLException {
        when(mockResultSet.next()).thenReturn(true).thenReturn(true).thenReturn(true).thenReturn(false);

        int total = medicineDAO.getTotalMedicine();

        Assert.assertEquals(3, total);
    }

    @Test
    public void testGetTotalMedicine_EmptyResultSet() throws SQLException {
        when(mockResultSet.next()).thenReturn(false);

        int total = medicineDAO.getTotalMedicine();

        Assert.assertEquals(0, total);
    }
//
//    @Test
//    public void testGetMedicineByGCN_Success() throws SQLException {
//        String GCN = "GCN123";
//        String regNumber = "REG123";
//        String name = "Aspirin";
//        Boolean Rx = false;
//        String dosageForm = "Tablet";
//        String EXPDate = "2025-12-31";
//        String imgURL = "http://example.com/image.jpg";
//        Company mockCompany = new Company("GCN",null,null,null,null);
//
//        when(mockResultSet.next()).thenReturn(true).thenReturn(false);
//        when(mockResultSet.getString("regNumber")).thenReturn(regNumber);
//        when(mockResultSet.getString("name")).thenReturn(name);
//        when(mockResultSet.getBoolean("Rx")).thenReturn(Rx);
//        when(mockResultSet.getString("dosageForm")).thenReturn(dosageForm);
//        when(mockResultSet.getString("EXPDate")).thenReturn(EXPDate);
//        when(mockResultSet.getString("imgURL")).thenReturn(imgURL);
//        when(companyDAO.getCompanyByGCN(GCN)).thenReturn(mockCompany);
//
//        LinkedHashMap<String, String> mockIngredients = new LinkedHashMap<>();
//        mockIngredients.put("Ingredient1", "Value1");
//        doReturn(mockIngredients).when(mock(MedicineDAO.class)).getIngredentOfMedicine(regNumber);
//
//        List<Medicine> result = medicineDAO.getMedicineByGCN(GCN);
//
//        assertNotNull(result);
//        assertEquals(1, result.size());
//        Medicine medicine = result.get(0);
//        assertEquals(regNumber, medicine.getRegNumber());
//        assertEquals(name, medicine.getName());
//        assertEquals(dosageForm, medicine.getDosageForm());
//        assertEquals(EXPDate, medicine.getEXPDate());
//        assertEquals(mockCompany, medicine.getCompany());
//        assertEquals(mockIngredients, medicine.getIngredents());
//        assertEquals(imgURL, medicine.getImgURL());
//    }

    @Test
    public void testGetMedicineByGCN_EmptyResultSet() throws SQLException {
        String GCN = "GCN123";

        when(mockResultSet.next()).thenReturn(false);

        List<Medicine> result = medicineDAO.getMedicineByGCN(GCN);

        Assert.assertNotNull(result);
        Assert.assertEquals(0, result.size());
    }

    @Test
    public void testUpdateMedicine() throws SQLException {
        String regNumber = "RX123";
        boolean Rx = true;
        String dosageForm = "Tablet";
        String EXPDate = "2025-12-31";
        String GCN = "123456";
        String imgURL = "http://example.com/image.png";

        medicineDAO.updateMedicine(regNumber, Rx, dosageForm, EXPDate, GCN, imgURL);

        verify(mockPreparedStatement).setBoolean(1, Rx);
        verify(mockPreparedStatement).setString(2, dosageForm);
        verify(mockPreparedStatement).setString(3, EXPDate);
        verify(mockPreparedStatement).setString(4, GCN);
        verify(mockPreparedStatement).setString(5, imgURL);
        verify(mockPreparedStatement).setString(6, regNumber);
        verify(mockPreparedStatement).executeUpdate();
    }

}