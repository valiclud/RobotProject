*** Settings ***
Library           SeleniumLibrary
Library     function.py

*** Variables ***
${BROWSER}    firefox
${PORT}    8089
${URL_BASE}    localhost
${URL_HOME}    http://${URL_BASE}:${PORT}/
${URL_DESIGN}    http://${URL_BASE}:${PORT}/design
${URL_ORDER}    http://${URL_BASE}:${PORT}/orders/current
${URL_ALL_ORDERS}    http://${URL_BASE}:${PORT}/allOrdersForm
${SLEEP}    1

*** Test Cases ***
TC0
    Open TacoCloud Application
    Enter Taco Lunch Composition
    Check Redirect to Order Page
    Check PY Function for Fun
    Enter Taco Order Data
    Check Redirect to Home Page
    Select All Orders Form Page
    Check Redirect to All Order Page
    Check All Order Table Data
    End TacoCloud Test

*** Keywords ***
Open TacoCloud Application
    Open Browser    ${URL_DESIGN}    ${BROWSER}

Enter Taco Lunch Composition
    Select Checkbox    id:ingredients1
    Select Checkbox    id:ingredients4
    Select Checkbox    id:ingredients5
    Input Text    id:name    Lunch 1
    Click Button    Submit your Taco

Check Redirect to Order Page
    ${url}    Get Location
    Log    ${url}
    Should Be Equal As Strings    ${url}    ${URL_ORDER}

Check PY Function for Fun
    ${value}    function.add_one_to_integer   ${1}
    SHOULD BE EQUAL     ${value}         ${2}

Enter Taco Order Data
    Input Text    id:clientDto.deliveryName    Ludvík Valíček
    Input Text    id:clientDto.deliveryStreet    Balabánova 4
    Input Text    id:clientDto.deliveryCity    Praha
    Input Text    id:clientDto.deliveryState    ČR
    Input Text    id:clientDto.deliveryZip    18200
    Input Text    id:ccNumber    123456789
    Input Text    id:ccExpiration    12/23
    Input Text    id:ccVV    789
    Submit Form

Check Redirect to Home Page
    Sleep    ${SLEEP}s
    ${urlhome}    Get Location
    Log    ${urlhome}
    Should Be Equal As Strings    ${urlhome}    ${URL_HOME}

Select All Orders Form Page
    Click Link    //a[contains(@href, "/allOrdersForm")]

Check Redirect to All Order Page
    Sleep    ${SLEEP}s
    ${urlallorders}    Get Location
    Log    ${urlhome}
    Should Be Equal As Strings    ${urlallorders}    ${URL_ALL_ORDERS}

Check All Order Table Data
    ${rows} =    Get Element Count    //table/tbody/tr
    Log    Pocet radku ${rows}
    FOR    ${row_num}    IN RANGE    ${rows}
    @{cells} =    Get WebElements    //table/tbody/tr[${row_num}]/td
    ${data} =    Create List
    FOR    ${cell}    IN    @{cells}
        Wait Until Element Is Visible    ${cell}
        ${text} =    Get Element Attribute    ${cell}    innerText
        ${data} =    Evaluate    [cell.text for cell in $cells]
        Log    ${cell} contains text: ${text}
    END
    Log    Row ${row_num} data: ${data}
    END

End TacoCloud Test
    Close Browser
