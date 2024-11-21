package DA;

import Models.Ingredent;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

public class IngredentDAOTest {

    @Mock
    private Connection mockConnection;

    @Mock
    private PreparedStatement mockPreparedStatement;

    @Mock
    private ResultSet mockResultSet;

    @InjectMocks
    @Spy
    private IngredentDAO ingredentDAO;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.openMocks(this); // Initialize the mocks
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);

//        ingredentDAO = spy(ingredentDAO);
    }


    @Test
    public void testGetIngredents() throws SQLException {
        List<Ingredent> expectedList = new ArrayList<>();
        expectedList.add(new Ingredent("Water", "H2O", "Universal solvent"));
        expectedList.add(new Ingredent("Salt", "NaCl", "Common salt"));

        when(mockResultSet.next()).thenReturn(true, true, false);
        when(mockResultSet.getString("name")).thenReturn("Water", "Salt");
        when(mockResultSet.getString("formula")).thenReturn("H2O", "NaCl");
        when(mockResultSet.getString("description")).thenReturn("Universal solvent", "Common salt");

        List<Ingredent> actualList = ingredentDAO.getIngredents();

        Assert.assertEquals(expectedList.size(), actualList.size());
        Assert.assertEquals(expectedList.get(0).getName(), actualList.get(0).getName());
        Assert.assertEquals(expectedList.get(1).getName(), actualList.get(1).getName());
    }

    @Test
    public void testGetIngredentByName_Found() throws SQLException {
        String testName = "Water";
        String expectedFormula = "H2O";
        String expectedDescription = "Universal solvent";


        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getString("name")).thenReturn(testName);
        when(mockResultSet.getString("formula")).thenReturn(expectedFormula);
        when(mockResultSet.getString("description")).thenReturn(expectedDescription);

        Optional<Ingredent> result = ingredentDAO.getIngredentByName(testName);

        Assert.assertTrue(result.isPresent());
        Ingredent ingredient = result.get();
        Assert.assertEquals(testName, ingredient.getName());
        Assert.assertEquals(expectedFormula, ingredient.getFormula());
        Assert.assertEquals(expectedDescription, ingredient.getDescription());
    }

    @Test
    public void testGetIngredentByName_NotFound() throws SQLException {
        String testName = "Unknown";


        when(mockResultSet.next()).thenReturn(false);

        Optional<Ingredent> result = ingredentDAO.getIngredentByName(testName);

        Assert.assertFalse(result.isPresent());
    }

    @Test
    public void testCheckIngredentExist_Found() throws SQLException {
        String testName = "Aspirin";


        when(mockResultSet.next()).thenReturn(true);

        boolean result = ingredentDAO.checkIngredentExist(testName);

        Assert.assertTrue(result);
    }

    @Test
    public void testCheckIngredentExist_NotFound() throws SQLException {
        String testName = "Nonexistent Ingredient";


        when(mockResultSet.next()).thenReturn(false);

        boolean result = ingredentDAO.checkIngredentExist(testName);

        Assert.assertFalse(result);
    }

    @Test
    public void testInsertIngredents_Success() throws SQLException {
        String name = "Aspirin";
        String formula = "C9H8O4";
        String description = "Pain reliever";


        Ingredent result = ingredentDAO.insertIngredents(name, formula, description);

        verify(mockPreparedStatement).setString(1, name);
        verify(mockPreparedStatement).setString(2, formula);
        verify(mockPreparedStatement).setString(3, description);
        verify(mockPreparedStatement).executeUpdate();

        Assert.assertNotNull(result);
        Assert.assertEquals(name, result.getName());
        Assert.assertEquals(formula, result.getFormula());
        Assert.assertEquals(description, result.getDescription());
    }

    @Test
    public void testInsertIngredents_SQLException() throws SQLException {
        String name = "Aspirin";
        String formula = "C9H8O4";
        String description = "Pain reliever";

        when(mockConnection.prepareStatement(anyString())).thenThrow(new SQLException("Database error"));

        Ingredent result = ingredentDAO.insertIngredents(name, formula, description);

        Assert.assertNull(result);

        verify(mockPreparedStatement, never()).setString(anyInt(), anyString());
        verify(mockPreparedStatement, never()).executeUpdate();
    }


    @Test
    public void testDeleteIngredents_Success() throws SQLException {
        String name = "Aspirin";

        boolean result = ingredentDAO.deleteIngredents(name);

        Assert.assertTrue(result);
        verify(mockPreparedStatement,times(2)).setString(1, name);
        verify(mockPreparedStatement,times(2)).executeUpdate();
    }

    @Test
    public void testDeleteIngredents_SQLException() throws SQLException {
        String name = "Unknown";
        doThrow(new SQLException("Database error")).when(mockPreparedStatement).executeUpdate();

        boolean result = ingredentDAO.deleteIngredents(name);

        Assert.assertFalse(result);
        verify(mockPreparedStatement,times(2)).setString(1, name);
        verify(mockPreparedStatement,times(2)).executeUpdate();
    }

    @Test
    public void testUpdateIngredents_Success() throws SQLException {
        String name = "Aspirin";
        String formula = "C9H10O4S";
        String description = "Pain relief medication";

        when(mockPreparedStatement.executeUpdate()).thenReturn(1);

        Ingredent updatedIngredent = ingredentDAO.updateIngredents(name, formula, description);

        Assert.assertNotNull(updatedIngredent);
        Assert.assertEquals(name, updatedIngredent.getName());
        Assert.assertEquals(formula, updatedIngredent.getFormula());
        Assert.assertEquals(description, updatedIngredent.getDescription());

        verify(mockPreparedStatement).setString(1, formula);
        verify(mockPreparedStatement).setString(2, description);
        verify(mockPreparedStatement).setString(3, name);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testUpdateIngredents_Failure() throws SQLException {
        String name = "NonExistentIngredient";
        String formula = "C1H1";
        String description = "Does not exist";

        when(mockPreparedStatement.executeUpdate()).thenReturn(0);

        Ingredent updatedIngredent = ingredentDAO.updateIngredents(name, formula, description);

        Assert.assertNull(updatedIngredent);

        verify(mockPreparedStatement).setString(1, formula);
        verify(mockPreparedStatement).setString(2, description);
        verify(mockPreparedStatement).setString(3, name);
        verify(mockPreparedStatement).executeUpdate();
    }

    @Test
    public void testDeleteMedIngredentRelationByIngre_SuccessfulDeletion() throws SQLException {
        doNothing().when(mockPreparedStatement).setString(1, "Vitamin C");
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);

        ingredentDAO.deleteMedIngredentRelationByIngre("Vitamin C");

        verify(mockConnection, times(1)).prepareStatement("DELETE FROM Med_Ingre WHERE ingreName = ?");
        verify(mockPreparedStatement, times(1)).setString(1, "Vitamin C");
        verify(mockPreparedStatement, times(1)).executeUpdate();
    }


}