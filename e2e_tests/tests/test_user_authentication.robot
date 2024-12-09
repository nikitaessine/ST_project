*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/variables.robot
Resource          ../resources/keywords.robot


*** Test Cases ***
User Can Register To The Application
    [Documentation]    Verify that a user can successfully register to the application.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/register    headlessfirefox       
    Input Registration Details
    Submit Registration Form
    Wait Until Page Does Not Contain    Register    timeout=10s
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
    Press Logout Button
    Wait Until Page Contains    Log in    timeout=30s
    Close Browser

User Can Create Public Post 
    [Documentation]    Verify that a user can successfully create a public post.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Log out    timeout=30s
    Type Text In Post And Choose Public
    Press Publish Button
    Wait Until Page Contains    This is a public post.    timeout=30s
    Close Browser

User Can Create Private Post
    [Documentation]    Verify that a user can successfully create a private post.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox 
    Input Login Details
    Submit Login Form
    Wait Until Page Contains    Log out    timeout=30s
    Type Text In Post And Choose Private
    Press Publish Button
    Element Should Be Visible    ${PRIVATE_ICON}    timeout=30s
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

User Is Able To See Post Made By Another User
    [Documentation]    Verify that a user can see a post made by another user.
    [Tags]    smoke
    Open Browser    ${BASE_URL}/login    headlessfirefox
    Input Login Details
    Submit Login Form
    Type Text In Post And Choose Public
    Press Publish Button
    Wait Until Page Contains    This is a public post.    timeout=30s
    Press Logout Button
    Go To    ${BASE_URL}/register
    Input Registration Details For Another User
    Submit Registration Form
    Wait Until Page Does Not Contain    Register    timeout=10s
    Input Login Details For Another User
    Submit Login Form
    Input Text    ${SEARCH_INPUT}    testuser
    Wait Until Element Is Visible    ${DROPDOWN_CONTENT}
    Scroll Element Into View    ${DROPDOWN_CONTENT}
    Click Element    ${DROPDOWN_CONTENT}
    Wait Until Page Contains    This is a public post.    timeout=30s
    Wait Until Page Contains    testuser    timeout=30s
    Close Browser
