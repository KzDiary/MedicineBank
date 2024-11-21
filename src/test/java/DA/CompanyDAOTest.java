package DA;

import Models.Company;
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

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.*;

public class CompanyDAOTest {

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private ResultSet resultSet;

    @InjectMocks
    private CompanyDAO companyDAO;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.openMocks(this);
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
    }

    @Test
    public void testGetCompany_Success() throws SQLException {
        when(resultSet.next()).thenReturn(true).thenReturn(true).thenReturn(false);  // Simulate 2 rows
        when(resultSet.getString("GCN")).thenReturn("GCN1").thenReturn("GCN2");
        when(resultSet.getString("name")).thenReturn("Company A").thenReturn("Company B");
        when(resultSet.getString("address")).thenReturn("Address A").thenReturn("Address B");
        when(resultSet.getString("phone")).thenReturn("123456789").thenReturn("987654321");
        when(resultSet.getString("imgURL")).thenReturn("img1.jpg").thenReturn("img2.jpg");

        List<Company> companies = companyDAO.getCompany();

        Assert.assertEquals(2, companies.size());
        Assert.assertEquals("GCN1", companies.get(0).getGCN());
        Assert.assertEquals("Company A", companies.get(0).getName());
        Assert.assertEquals("Address A", companies.get(0).getAddress());
        Assert.assertEquals("123456789", companies.get(0).getPhone());
        Assert.assertEquals("img1.jpg", companies.get(0).getImgURL());
        Assert.assertEquals("GCN2", companies.get(1).getGCN());
        Assert.assertEquals("Company B", companies.get(1).getName());
        Assert.assertEquals("Address B", companies.get(1).getAddress());
        Assert.assertEquals("987654321", companies.get(1).getPhone());
        Assert.assertEquals("img2.jpg", companies.get(1).getImgURL());
        verify(resultSet, times(3)).next();
    }

    @Test
    public void testGetCompany_WhenNoCompanies() throws SQLException {
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);

        List<Company> companies = companyDAO.getCompany();

        assertTrue(companies.isEmpty());
        verify(preparedStatement, times(1)).executeQuery();
    }



    @Test
    public void testInsertCompany_Success() throws SQLException {
        when(preparedStatement.executeUpdate()).thenReturn(1);

        String GCN = "12345";
        String name = "Test Company";
        String address = "123 Test St";
        String phone = "0928921892";
        String imgURL = "http://example.com/image.jpg";

        Company company = companyDAO.insertCompany(GCN, name, address, phone, imgURL);

        verify(preparedStatement).setString(1, GCN);
        verify(preparedStatement).setString(2, name);
        verify(preparedStatement).setString(3, address);
        verify(preparedStatement).setString(4, phone);
        verify(preparedStatement).setString(5, imgURL);
        verify(preparedStatement).executeUpdate();

        Assert.assertNotNull(company);
        Assert.assertEquals(GCN, company.getGCN());
        Assert.assertEquals(name, company.getName());
        Assert.assertEquals(address, company.getAddress());
        Assert.assertEquals(phone, company.getPhone());
        Assert.assertEquals(imgURL, company.getImgURL());
    }

    @Test
    public void testInsertCompany_Failure_NoRowsAffected() throws SQLException {
        when(preparedStatement.executeUpdate()).thenReturn(0);

        String GCN = "12345";
        String name = "Test Company";
        String address = "123 Test St";
        String phone = "928921892";
        String imgURL = "http://example.com/image.jpg";

        SQLException exception = assertThrows(SQLException.class, () -> {
            companyDAO.insertCompany(GCN, name, address, phone, imgURL);
        });

        Assert.assertEquals("Inserting company failed, no rows affected.", exception.getMessage());

        verify(preparedStatement).executeUpdate();
    }

    @Test
    public void testCheckCompanyExist_True() throws SQLException {
        when(resultSet.next()).thenReturn(true);

        String GCN = "12345";
        boolean exists = companyDAO.checkCompanyExist(GCN);

        verify(preparedStatement).setString(1, GCN);
        verify(preparedStatement).executeQuery();
        verify(resultSet).next();

        Assert.assertTrue(exists);
    }

    @Test
    public void testCheckCompanyExist_False() throws SQLException {
        when(resultSet.next()).thenReturn(false); // Simulate no rows exist

        String GCN = "54321";
        boolean exists = companyDAO.checkCompanyExist(GCN);

        verify(preparedStatement).setString(1, GCN);
        verify(preparedStatement).executeQuery();
        verify(resultSet).next();

        Assert.assertFalse(exists);
    }

    @Test
    public void testUpdateCompany_Success() throws SQLException {
        when(preparedStatement.executeUpdate()).thenReturn(1); // Simulate successful update

        String GCN = "12345";
        String name = "Updated Company";
        String address = "456 Update St";
        String phone = "928921892";
        String imgURL = "http://example.com/newimage.jpg";

        boolean result = companyDAO.updateCompany(GCN, name, address, phone, imgURL);

        verify(preparedStatement).setString(1, name);
        verify(preparedStatement).setString(2, address);
        verify(preparedStatement).setString(3, phone);
        verify(preparedStatement).setString(4, imgURL);
        verify(preparedStatement).setString(5, GCN);
        verify(preparedStatement).executeUpdate();

        Assert.assertTrue(result);
    }

    @Test
    public void testUpdateCompany_NoRowsAffected() throws SQLException {
        when(preparedStatement.executeUpdate()).thenReturn(0);

        String GCN = "NotExisted";
        boolean result = companyDAO.updateCompany(GCN, "New Name", "New Address", "555-555-5555", "http://example.com/image.jpg");

        verify(preparedStatement).executeUpdate();

        Assert.assertFalse(result);
    }
    @Test
    public void testGetCompanyByGCN_Success() throws SQLException {
        String GCN = "GCN123";
        String name = "Test Company";
        String address = "123 Test St";
        String phone = "1234567890";
        String imgURL = "http://example.com/image.jpg";

        when(connection.prepareStatement(any(String.class))).thenReturn(preparedStatement);
        when(resultSet.getString("name")).thenReturn(name);
        when(resultSet.getString("address")).thenReturn(address);
        when(resultSet.getString("phone")).thenReturn(phone);
        when(resultSet.getString("imgURL")).thenReturn(imgURL);

        when(resultSet.next()).thenReturn(true).thenReturn(false);

        when(resultSet.getString(1)).thenReturn(GCN);

        Company company = companyDAO.getCompanyByGCN(GCN);

        Assert.assertNotNull(company);
        Assert.assertEquals(GCN, company.getGCN());
        Assert.assertEquals(name, company.getName());
        Assert.assertEquals(address, company.getAddress());
        Assert.assertEquals(phone, company.getPhone());
        Assert.assertEquals(imgURL, company.getImgURL());
    }

    @Test
    public void testGetCompanyByGCN_NoResults() throws SQLException {
        String GCN = "GCN321";

        when(connection.prepareStatement(any(String.class))).thenReturn(preparedStatement);

        when(resultSet.next()).thenReturn(false);

        Company company = companyDAO.getCompanyByGCN(GCN);

        Assert.assertNull(company);
    }

    @Test
    public void testGetCompanyByGCN_SQLException() throws SQLException {
        String GCN = "GCN123";

        when(connection.prepareStatement(any(String.class))).thenThrow(new SQLException("Database error"));

        Company company = companyDAO.getCompanyByGCN(GCN);

        Assert.assertNull(company);
    }

}
