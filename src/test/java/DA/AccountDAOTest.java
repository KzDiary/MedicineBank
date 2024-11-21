package DA;

import Models.Account;
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

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

public class AccountDAOTest {

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement mockPreparedStatement;

    @Mock
    private ResultSet mockResultSet;

    @InjectMocks
    private AccountDAO accountDAO;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.openMocks(this);
        when(connection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
    }


    @Test
    public void testInsertAccount_Success() throws SQLException {
        Account account = new Account("UUID-1234", "user1", "pass123", "user1@example.com", "1234567890", 2);

        accountDAO.insertAccount(account);

        verify(mockPreparedStatement).setString(1, account.getUUID());
        verify(mockPreparedStatement).setString(2, account.getUsername());
        verify(mockPreparedStatement).setString(3, account.getPassword());
        verify(mockPreparedStatement).setString(4, account.getEmail());
        verify(mockPreparedStatement).setString(5, account.getPhone());
        verify(mockPreparedStatement).setInt(6, account.getRoleid());
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testUpdateAccount_Success() throws SQLException {
        String uuid = "UUID-1234";
        String username = "newuser";
        String email = "newemail@example.com";
        String phone = "0987654321";

        boolean result = accountDAO.updateAccount(uuid, username, email, phone);

        Assert.assertTrue(result);
        verify(mockPreparedStatement).setString(1, username);
        verify(mockPreparedStatement).setString(2, email);
        verify(mockPreparedStatement).setString(3, phone);
        verify(mockPreparedStatement).setString(4, uuid);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testUpdateAccount_Failure() throws SQLException {
        String uuid = "UUID-2345";
        String username = "newuser";
        String email = "existedEmail@example.com";
        String phone = "9876543210";

        doThrow(new SQLException("SQL error")).when(mockPreparedStatement).executeUpdate();

        boolean result = accountDAO.updateAccount(uuid, username, email, phone);

        Assert.assertFalse(result);
        verify(mockPreparedStatement).setString(1, username);
        verify(mockPreparedStatement).setString(2, email);
        verify(mockPreparedStatement).setString(3, phone);
        verify(mockPreparedStatement).setString(4, uuid);
    }

    @Test
    public void testGetAccountByUsername_Success() throws SQLException {
        String username = "user1";

        when(mockResultSet.next()).thenReturn(true).thenReturn(false); // Simulate that result exists
        when(mockResultSet.getString("UUID")).thenReturn("50b91f08-6c1a-4b48-860a-94b3d64efde6");
        when(mockResultSet.getString("username")).thenReturn("user1");
        when(mockResultSet.getString("password")).thenReturn("pass123");
        when(mockResultSet.getString("email")).thenReturn("user1@example.com");
        when(mockResultSet.getString("phone")).thenReturn("1234567890");
        when(mockResultSet.getInt("roleid")).thenReturn(2);

        Account result = accountDAO.getAccountByUsername(username);

        Assert.assertNotNull(result);
        Assert.assertEquals("50b91f08-6c1a-4b48-860a-94b3d64efde6", result.getUUID());
        Assert.assertEquals("user1", result.getUsername());
        Assert.assertEquals("pass123", result.getPassword());
        Assert.assertEquals("user1@example.com", result.getEmail());
        Assert.assertEquals("1234567890", result.getPhone());
        Assert.assertEquals(2, result.getRoleid());
        verify(mockPreparedStatement).setString(1, username);
        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetAccountByUsername_NotFound() throws SQLException {
        String username = "nonexistentuser";

        when(mockResultSet.next()).thenReturn(false);

        Account result = accountDAO.getAccountByUsername(username);

        Assert.assertNull(result);
        verify(mockPreparedStatement).setString(1, username);
        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetAccountByUsername_SQLException() throws SQLException {
        String username = "user1";

        when(mockPreparedStatement.executeQuery()).thenThrow(new SQLException("SQL error"));

        Account result = accountDAO.getAccountByUsername(username);

        Assert.assertNull(result);
        verify(mockPreparedStatement).setString(1, username);
        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetRoleAccount_Success() throws SQLException {
        String uuid = "50b91f08-6c1a-4b48-860a-94b3d64efde6";
        String expectedRole = "Admin";

        when(mockResultSet.next()).thenReturn(true).thenReturn(false);
        when(mockResultSet.getString("name")).thenReturn(expectedRole);

        String result = accountDAO.getRoleAccount(uuid);

        Assert.assertEquals(expectedRole, result);
        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetRoleAccount_NotFound() throws SQLException {
        String uuid = "UUID-1234";

        when(mockResultSet.next()).thenReturn(false);

        String result = accountDAO.getRoleAccount(uuid);

        Assert.assertNull(result);
        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement).executeQuery();
    }

    @Test
    public void testGetRoleAccount_SQLException() throws SQLException {
        String uuid = "UUID-1234";

        when(mockPreparedStatement.executeQuery()).thenThrow(new SQLException("SQL error"));

        String result = accountDAO.getRoleAccount(uuid);

        Assert.assertNull(result);
        verify(mockPreparedStatement).setString(1, uuid);
        verify(mockPreparedStatement).executeQuery();
    }
}