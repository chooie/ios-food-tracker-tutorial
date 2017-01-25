package FoodTracker.ios.util;

import io.appium.java_client.AppiumDriver;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.rules.TestRule;
import org.junit.rules.TestWatcher;
import org.junit.runner.Description;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.util.Date;
import java.util.concurrent.TimeUnit;

public class Setup {
  private AppiumDriver driver;

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
    int maxNumberOfSecondsToWait = 30;

    capabilities.setCapability("automationName", "XCUITest");
    capabilities.setCapability("appium-version", "1.6.3");
    capabilities.setCapability("platformVersion", "10.1");
    capabilities.setCapability("platformName", "iOS");
    capabilities.setCapability("deviceName", "iPhone Simulator");
    capabilities.setCapability("name", "Java iOS tutorial " + Setup.jobTime);
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