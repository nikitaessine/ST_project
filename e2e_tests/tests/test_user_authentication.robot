*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/locators.robot
Resource          ../resources/variables.robot

*** Variables ***
${BASE_URL}       http://localhost:80

*** Test Cases ***
User Can Register To The Application
    [Documentation]    Verify that a user can successfully register to the application.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/register   ${BROWSER}  
    Input Registration Details
    Submit Registration Form
    Close Browser

User Can Login To The Application
    [Documentation]    Verify that a user can successfully login to the application.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Publish    timeout=10s
    Close Browser

User Gets Error When Login With Wrong Credentials
    [Documentation]    Verify that a user can successfully login to the application.
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Wrong Input Login Details
    Submit Login Form
    Wait Until Page Contains    Invalid email/password combination
    Close Browser

*** Keywords ***
Input Registration Details
    [Documentation]    Fill the registration form with valid user details.
    Input Text    ${REGISTRATION_USERNAME}    testuser
    Sleep    3 seconds
    Input Text    ${REGISTRATION_EMAIL}       testuser@example.com
    Sleep    3 seconds
    Input Text    ${REGISTRATION_PASSWORD}    TestPassword123!
    Sleep    3 seconds

Input Login Details
    [Documentation]    Fill the login form with valid user details.
    Sleep    3 seconds
    Input Text    ${LOGIN_EMAIL}    testuser@example.com
    Sleep    3 seconds
    Input Text    ${LOGIN_PASSWORD}    TestPassword123!
    Sleep    3 seconds

Wrong Input Login Details
    [Documentation]    Fill the login form with valid user details.
    Sleep    3 seconds
    Input Text    ${LOGIN_EMAIL}    testuser
    Sleep    3 seconds
    Input Text    ${LOGIN_PASSWORD}    TestPassword123!
    Sleep    3 seconds
Submit Registration Form
    [Documentation]    Submit the registration form.
    Click Button    ${REGISTER_BUTTON}

Submit Login Form
    [Documentation]    Submit the login form.
    Click Button    ${LOGIN_BUTTON}
