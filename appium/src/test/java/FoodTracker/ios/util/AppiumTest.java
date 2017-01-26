package FoodTracker.ios.util;

import io.appium.java_client.AppiumDriver;

import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.rules.TestRule;
import org.junit.rules.TestWatcher;
import org.junit.runner.Description;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.URL;
import java.nio.file.Paths;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class AppiumTest {
  private AppiumDriver driver;

  public static WebElement wait(By locator) {
    return Helpers.wait(locator);
  }

  private static final Date jobTime = new Date();

  @Rule
  public TestRule printTests = new TestWatcher() {
    protected void starting(Description description) {
      System.out.print(" test: " + description.getMethodName());
    }

    protected void finished(Description description) {
      // Do nothing
    }
  };

  /**
   * Run before each test
   */
  @Before
  public void setUp() throws Exception {
    DesiredCapabilities capabilities = new DesiredCapabilities();

    capabilities.setCapability("automationName", "XCUITest");
    capabilities.setCapability("appium-version", "1.6.3");
    capabilities.setCapability("platformVersion", "10.1");
    capabilities.setCapability("platformName", "iOS");
    capabilities.setCapability("deviceName", "iPhone Simulator");
    capabilities.setCapability("name", "Java iOS tutorial " +
        AppiumTest.jobTime);

    String userDir = System.getProperty("user.dir");
    String localApp = "../ios/build/Release-iphonesimulator/FoodTracker.app";
    String appPath = Paths.get(userDir, localApp).toAbsolutePath().toString();
    capabilities.setCapability("app", appPath);
    driver = new AppiumDriver(new URL("http://127.0.0.1:4723/wd/hub"),
        capabilities);
    int maxNumberOfSecondsToWait = 30;
    driver.manage().timeouts().implicitlyWait(maxNumberOfSecondsToWait,
        TimeUnit.SECONDS);
    Helpers.init(driver);
  }

  /**
   * Run after each test
   */
  @After
  public void tearDown() throws Exception {
    if (driver!= null) {
      driver.quit();
    }
  }
}