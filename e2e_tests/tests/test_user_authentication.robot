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
    Open Browser    ${BASE_URL}/register    headlessfirefox    
    Input Registration Details
    Submit Registration Form
    Wait Until Page Does Not Contain    email already taken    timeout=10s
    Close Browser

User Can Login To The Application
    [Documentation]    Verify that a user can successfully login to the application.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Log out    timeout=30s
    Close Browser

User Can Logout From The Application
    [Documentation]    Verify that a user can successfully logout from the application.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Log out    timeout=30s
    Sleep    3 seconds
    Press Logout Button
    Sleep    3 seconds
    Wait Until Page Contains    Log out    timeout=30s
    Sleep    3 seconds
    Close Browser

User Can Create Public Post 
    [Documentation]    Verify that a user can successfully create a public post.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Log out    timeout=30s
    Type Text In Post And Choose Public
    Sleep    3 seconds
    Press Publish Button
    Sleep    3 seconds
    Wait Until Page Contains    This is a public post.    timeout=30s
    Sleep    2 seconds
    Close Browser

User Can Create Private Post
    [Documentation]    Verify that a user can successfully create a private post.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox 
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Log out    timeout=30s
    Type Text In Post And Choose Private
    Sleep    3 seconds
    Press Publish Button
    Sleep    3 seconds
    Element Should Be Visible    ${PRIVATE_ICON}    timeout=30s
    Sleep    2 seconds
    Close Browser

# kommentti    
User Gets Error When Login With Wrong Credentials
    [Documentation]    Verify that a user can successfully login to the application.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox
    Wrong Input Login Details
    Submit Login Form
    Wait Until Page Contains    Invalid email/password combination
    Close Browser

*** Keywords ***
Input Registration Details
    [Documentation]    Fill the registration form with valid user details.
    Input Text    ${REGISTRATION_USERNAME}    user1
    Sleep    3 seconds
    Input Text    ${REGISTRATION_EMAIL}       user1@example.com
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

Press Logout Button
    [Documentation]    Press the logout button.
    Click Button    ${LOGOUT_BUTTON}

Press Publish Button
    [Documentation]    Press the publish button.
    Click Button    ${PUBLISH_BUTTON}
Type Text In Post And Choose Public
    [Documentation]    Type text in the post.
    Input Text    ${POST_TEXT}    This is a public post.
    Select From List By Label    xpath=//select[@name='privacy']    public
    Sleep    3 seconds

Type Text In Post And Choose Private
    [Documentation]    Type text in the post.
    Input Text    ${POST_TEXT}    This is a private post.
    Select From List By Label    xpath=//select[@name='privacy']    friends
    Sleep    3 seconds