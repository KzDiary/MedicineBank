import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.*;

import java.time.Duration;

public class TC_001_Valid {
    WebDriver driver;

    @BeforeTest
    public void init() {
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
    }

    @BeforeMethod
    public void setUp(){
        driver.get("http://localhost:8080/DrugBank_war_exploded/Login.jsp");
    }

    @DataProvider(name = "userData")
    public Object[][] userData() {
        return new Object[][]{
                {"newUser1", "newemail1@example.com", "0987654321"},
                {"newUser2", "valid@example.com", "0123456789"},
                {"newUser", "newemail3@example.com", "9876543210"}
        };
    }

    @Test(dataProvider = "userData")
    public void test(String username, String email, String phone) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        driver.findElement(By.xpath("//input[@name='username']")).sendKeys("sa");
        driver.findElement(By.xpath("//input[@name='password']")).sendKeys("123");
        driver.findElement(By.xpath("//input[@type='submit']")).click();

        Actions actions = new Actions(driver);
        actions.moveToElement(driver.findElement(By.xpath("//li[@class='dropdown ']"))).perform();
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[@href='AccountDetails.jsp' and text()='Thông tin Tài Khoản']"))).click();
        driver.findElement(By.xpath("//*[@id='editBtn']")) .click();
        driver.findElement(By.xpath("//*[@id='username']")).clear();
        driver.findElement(By.xpath("//*[@id='email']")).clear();
        driver.findElement(By.xpath("//*[@id='phone']")).clear();
        driver.findElement(By.xpath("//*[@id='username']")).sendKeys(username);
        driver.findElement(By.xpath("//*[@id='email']")).sendKeys(email);
        driver.findElement(By.xpath("//*[@id='phone']")).sendKeys(phone);
        driver.findElement(By.xpath("//*[@id='submitBtn']")).click();
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//span[@class='text-dark']")));
        String message = driver.findElement(By.xpath("//span[@class='text-dark']")).getText();
        Assert.assertEquals("Cập nhật thành công!", message);
    }

    @AfterMethod
    public void closing(){
        driver.findElement(By.xpath("//*[@id='editBtn']")).click();
        driver.findElement(By.xpath("//*[@id='username']")).clear();
        driver.findElement(By.xpath("//*[@id='username']")).sendKeys("sa");
        driver.findElement(By.xpath("//*[@id='submitBtn']")).click();
    }

    @AfterTest
    public void tearDown() {
        driver.quit();
    }
}
