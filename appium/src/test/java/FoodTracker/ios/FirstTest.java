package FoodTracker.ios;

import FoodTracker.ios.util.AppiumTest;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

public class FirstTest extends AppiumTest {
  @org.junit.Test
  public void app_opens_to_your_meals_page() throws Exception {
    By homePageTitleElementReference = By.xpath(
      "//XCUIElementTypeApplication[1]" +
          "/XCUIElementTypeWindow[1]" +
          "/XCUIElementTypeOther[1]" +
          "/XCUIElementTypeNavigationBar[1]" +
          "/XCUIElementTypeStaticText[1]"
    );
    WebElement homePageTitleElement =
        this.driver.findElement(homePageTitleElementReference);
    String homePageElementText = homePageTitleElement.getText();
    Assert.assertTrue(homePageElementText.contains("Your Meals"));
  }

  @org.junit.Test
  public void caprese_salad_is_first_element_in_list() throws Exception {
    By mealListElementReference = By.xpath(
        "//XCUIElementTypeApplication[1]" +
            "/XCUIElementTypeWindow[1]" +
            "/XCUIElementTypeOther[1]" +
            "/XCUIElementTypeOther[1]" +
            "/XCUIElementTypeOther[1]" +
            "/XCUIElementTypeTable[1]" +
            "/XCUIElementTypeCell[1]" +
            "/XCUIElementTypeStaticText[1]");
    WebElement mealListElement =
        this.driver.findElement(mealListElementReference);
    String mealListElementText = mealListElement.getText();
    Assert.assertTrue(mealListElementText.contains("Caprese Salad"));
  }
}
