Configuring IntelliJ for debugging appium tests
===============================================

- Open IntelliJ
- Run > Edit Configurations
    - Click the '+' icon
    - Select 'Remote'
    - Fill these fields:
        - Name: Mvn Appium
        - Host: localhost, Port: 5005

Now you will be able to run all the appium tests and use certain IDE
features like breakpoints:

- At the command line
    - Make sure Appium is running

            appium

      - To stop appium from closing the simulator and reopening it
      (which is god-awfully slow):

                appium --no-reset

    - Run the tests with Maven which will then wait for you to connect

            mvn -f ./appium -Dmaven.surefire.debug clean test

    - Connect the IDE

            Run > Debug 'Mvn Appium'

Using the inspector
-------------------
The inspector is useful when you need to find the paths to certain
elements or explore how you would like to carry out your automated
tests.

Currently it does not work well so some tweaking is required. This guide
is based off of the information that was found
[here](https://github.com/appium/appium-dot-app/issues/577).

![Developer Settings](/appium/resources/developer_settings)