# Study Outlet Milestone 5--Unit Testing
### Who: 
Zoë Koppenhofer, Alexander Ray, Woosung Jang, Ryan Whitmer, and Pengqi Yin(Bill)
### Vision statement:
Provide an organized testing framework to help students review.
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


