package FoodTracker.ios.util;

import io.appium.java_client.AppiumDriver;

import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.rules.TestRule;
import org.junit.rules.TestWatcher;
import org.junit.runner.Description;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Paths;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class AppiumTest {
  protected AppiumDriver driver;

  private static final Date jobTime = new Date();

  @Rule
  public TestRule printTests = new TestWatcher() {
    protected void starting(Description description) {
      System.out.println(" Test: " + description.getMethodName());
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
    DesiredCapabilities capabilities = getDesiredCapabilities();
    this.driver = createAppiumDriver(capabilities);
  }

  private DesiredCapabilities getDesiredCapabilities() {
    DesiredCapabilities capabilities = new DesiredCapabilities();
    String appPath = getAppPath();
    capabilities.setCapability("app", appPath);
    capabilities.setCapability("automationName", "XCUITest");
    capabilities.setCapability("appium-version", "1.6.3");
    capabilities.setCapability("platformVersion", "10.1");
    capabilities.setCapability("platformName", "iOS");
    capabilities.setCapability("deviceName", "iPhone Simulator");
    capabilities.setCapability(
        "name",
        "Java iOS tutorial " + AppiumTest.jobTime
    );
    return capabilities;
  }

  private String getAppPath() {
    String userDir = System.getProperty("user.dir");
    String localApp = "../ios/build/Release-iphonesimulator/FoodTracker.app";
    return Paths.get(userDir, localApp).toAbsolutePath().toString();
  }

  private AppiumDriver createAppiumDriver(DesiredCapabilities capabilities)
      throws MalformedURLException {
    AppiumDriver driver = new AppiumDriver(
        new URL("http://127.0.0.1:4723/wd/hub"),
        capabilities
    );
    int maxNumberOfSecondsToImplicitlyWait = 30;
    driver.manage().timeouts().implicitlyWait(
        maxNumberOfSecondsToImplicitlyWait,
        TimeUnit.SECONDS
    );

    return driver;
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