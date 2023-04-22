*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    Collections
Library    String
Library    json
Library    OperatingSystem

Library    ../resources/webdriver-helper.py
Library    ../resources/random_data_generator.py
Library    ../resources/url_helper.py

Resource    ../pages/home_page.resource
Resource    ../pages/login_page.resource
Resource    ../pages/admin_page.resource
Resource    ../pages/admin_dashboard_page.resource
Resource    ../pages/registration_page.resource

Resource    ../keywords/login_keywords.resource
Resource    ../keywords/admin_keywords.resource
Resource    ../keywords/registration_keyword.resource

Resource    ../resources/common.resource

Resource    ../components/menu.resource

Variables    ../resources/common_variables.py

*** Variables ***
${BROWSERS}    ${EMPTY}

*** Keywords ***
Common Test Setup
    ${BROWSERS}=    Read Browsers From JSON
    ${BROWSER}=    Convert To Lower Case    ${BROWSER}
    ${is_browser_valid}=    Evaluate    ${BROWSER} in ${BROWSERS}
    Log    ${is_browser_valid}    console=${True}
    IF    ${is_browser_valid} == $True
        Setup Browser    ${BROWSER}
    END
    Log    ${BROWSER}    console=${True}
    Go To    ${BASE_URL}
    FOR    ${i}    IN RANGE    60
        Reload Page
        ${contains_element}=    Run Keyword And Return Status    Element Should Be Visible    ${HOME_PAGE_TEXT}
        Exit For Loop If    '${contains_element}' == 'True'
        Sleep    1s
    END

Setup Browser
    [Arguments]    ${BROWSER}
    IF    $BROWSER == chrome
        Setup Chrome
    END
    IF    $BROWSER == firefox
        Setup Firefox
    END
    IF    $BROWSER == edge
        Setup Edge
    END

Setup Chrome
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    ${chrome_driver_path}=    Get Chrome Driver Path
    Create WebDriver    ${BROWSER}    executable_path=${chrome_driver_path}    chrome_options=${chrome_options}

Setup Firefox
    ${firefox_options} =    Evaluate    selenium.webdriver.FirefoxOptions()
    Call Method    ${firefox_options}    add_argument    --headless
    Call Method    ${firefox_options}    add_argument    --window-size\=1920,1080
    Call Method    ${firefox_options}    add_argument    --start-maximized
    ${firefox_driver_path}=    Get Firefox Driver Path
    Create WebDriver    ${BROWSER}    executable_path=${firefox_driver_path}    options=${firefox_options}

Setup Edge
    ${edge_options} =    Evaluate    selenium.webdriver.EdgeOptions()
    Call Method    ${edge_options}    add_argument    --no-sandbox
    Call Method    ${edge_options}    add_argument    --headless
    Call Method    ${edge_options}    add_argument    --window-size\=1920,1080
    Call Method    ${edge_options}    add_argument    --start-maximized
    Call Method    ${edge_options}    add_argument    --disable-gpu
    ${edge_driver_path}=    Get Edge Driver Path
    Create WebDriver    ${BROWSER}    executable_path=${edge_driver_path}    options=${edge_options}

Common Test Teardown 
    Close All Browsers
