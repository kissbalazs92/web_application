*** Settings ***
Resource    ../base/base_test.robot

*** Variables ***

${LOGIN_URL}    /login.php
${USERNAME_INPUT}    id:username
${PASSWORD_INPUT}    id:password
${SUBMIT_BUTTON}    //button[@type='submit']