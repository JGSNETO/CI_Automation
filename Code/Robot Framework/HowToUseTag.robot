*** Settings ***
Test Tags       requirement: 42    smoke

*** Variables ***
${HOST}         10.0.1.42

*** Test Cases ***
No own tags
    [Documentation]    This test has tags 'requirement: 42' and 'smoke'.
    No Operation

Own tags
    [Documentation]    This test has tags 'requirement: 42', 'smoke' and 'not ready'.
    [Tags]    not ready
    No Operation

Own tags with variable
    [Documentation]    This test has tags 'requirement: 42', 'smoke' and 'host: 10.0.1.42'.
    [Tags]    host: ${HOST}
    No Operation

Set Tags and Remove Tags keywords
    [Documentation]    This test has tags 'smoke', 'example' and 'another'.
    Set Tags    example    another
    Remove Tags    requirement: *