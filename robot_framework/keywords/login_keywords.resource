*** Settings ***
Resource    ../base/base_test.resource

*** Keywords ***

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_INPUT}    ${username}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Click Button    ${SUBMIT_BUTTON}

Verify Successful Login
    ${current_url} =    Get Location
    ${current_path} =    Get Url Path    ${current_url}
    Should Be Equal    ${current_path}    ${HOME_URL}
    Wait Until Page Contains    ${USERNAME}