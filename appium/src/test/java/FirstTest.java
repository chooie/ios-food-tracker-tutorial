import FoodTracker.ios.util.AppiumTest;

import static FoodTracker.ios.util.Helpers.*;

public class FirstTest extends AppiumTest {
  @org.junit.Test
  public void test() throws Exception {
    text_exact("Your Meals");
  }
}
