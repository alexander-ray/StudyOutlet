# Study Outlet Milestone 5--Unit Testing
### Who: 
Zoë Koppenhofer, Alexander Ray, Woosung Jang, Ryan Whitmer, and Pengqi Yin(Bill)
### Vision statement:
Provide an organized testing framework to help students review.
### What are we testing?:
We've developed tests for 3 features: register, login, and a date picker in our app (that needs a date sometime in the future). For registration and login, we test to ensure that our email regex works (correct response for valid & invalid email addresses), that our password regex works (only accepts passwords with at least one uppercase letter and at least one number), and that the app responds correctly for both valid and invalid input. For the date checker, we simply test the app's reaction to a date in the past and a date in the future.

For all of these features, we perform both positive and negative tests across a wide variety of inputs.
### How to run:
*Note that this assumes one has cloned the repo and managed all dependencies such that the app will build and run correctly.*

Simply open the app in Xcode and go to the `StudyOutletUITests` group in project navigator. Open the file that tests the desired feature and press the small diamond button near the top of the file in the left gutter. This will run every test in the file (tests can be run individually with the diamond at the line of the test). As tests pass/fail, a green/red icon will appear next to each test.
### Automated tests explanation
To do our automated testing we're using the XCTestCase class provided by XCode. This framework is very similar to the Python framework we used in our Unit Testing lab.

For each of the three testing files, there's a setup function that gets the app to the point at which we're testing (e.g. for register, we need to tap the "register" button to be able to test registration input). There's also a teardown-like function that shuts everything down after a test. With those in place, we can create any set of tests for any feature we'd like.

We did UI testing, where the tests all hinge on what a user would "see" after doing a certain action. For example, in `LoginUITests.swift` the code for `testPositive1()` essentially says "tap username field, input alex@alex.com, tap password field, input 1Alex, wait for 5 seconds, check to see if the current page has "GRE_Title.png"". This works, as after we enter that (correct) login info, we expect the app to go to the main page that contains "GRE_Title.png".

A couple of issues we ran into included accounting for server lag when doing correct logins/registrations (hence the sleeping before checking the result) as well as debugging textfield autocorrect that kept messing with valid login/registration input.

Note that we have demoed our tests to Yogitha, who has seen all tests being run and OKed not providing test output in this doc (as Xcode doesn't give textual feedback). Here is a screenshot to show that the tests run correctly:

![Tests](https://cloud.githubusercontent.com/assets/13969549/25142403/fc0901b4-2423-11e7-80bb-e1ae00341950.png)

The test code can be found [here](StudyOutlet/StudyOutletUITests/).

### User Acceptance Test Plans
![uat_plans](https://cloud.githubusercontent.com/assets/25576113/25074200/a15347e0-22aa-11e7-980f-5cde51a73da5.PNG)


