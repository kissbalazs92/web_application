*** Settings ***
Resource    ../base/base_test.robot
Test Setup    Common Test Setup
Test Teardown    Common Test Teardown

*** Variables ***


*** Test Cases ***
Register new user
    ${page_source}=     Get Source
    Log  Source:${page_source}    console=${True}
    Go To    ${BASE_URL}${REGISTRATION_URL}
    Fill Registration Form With Random Test Data
    Click Button    ${SUBMIT_BUTTON}
    Verify Successful Registration