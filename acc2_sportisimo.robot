*** Settings ***
Documentation    Example test case is testing sportisimo web shop
...    functionality. Selecting two most expensive low trekking
...    shoes, selecting their size and adding them to the chart.
...    Tested on browsers Chrome, Firefox and Edge.
...    Selenium version 4.15.0
Library    SeleniumLibrary

*** Variables ***
${BROWSER}   chrome
${URL}   https://www.sportisimo.cz
${SLEEP}   1

*** Test Cases ***
Adding Trekking Shoes to Chart
    Open Sportisimo Application
    Navigate to Low Trekking Shoes
    Select the Most Expensive Shoes List
    Scroll Down Page
    Select First Most Expensive Shoe
    Select Shoe Size
    Add Shoe to Chart
    Navigate Back to the Most Expensive Shoes List
    Select Second Most Expensive Shoe
    Select Shoe Size
    Add Shoe to Chart
    Navigate Back to the Most Expensive Shoes List
    Scroll Up Page
    End Test

*** Keywords ***
Open Sportisimo Application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    //button[@id="didomi-notice-agree-button"]
    Click Element    //button[@id="didomi-notice-agree-button"]

Navigate to Low Trekking Shoes
    Wait Until Page Contains Element       //a[contains(@href, "https://www.sportisimo.cz/boty/")]
    Click Link   //a[contains(@href, "https://www.sportisimo.cz/boty/")]
    Wait Until Page Contains Element    //a[contains(@href, "https://www.sportisimo.cz/nizke-trekove-boty/")]
    Click Link    //a[contains(@href, "https://www.sportisimo.cz/nizke-trekove-boty/")]

Select the Most Expensive Shoes List
    Wait Until Page Contains Element     //span[@class="products-panel__sort-head"]
    Click Element    //span[@class="products-panel__sort-head"]
    Wait Until Page Contains Element    //label[@for="sort_input_nejdrazsi"]
    Click Element   //label[@for="sort_input_nejdrazsi"]

Scroll Down Page
    Sleep    ${SLEEP}s
    Execute Javascript   window.scrollTo(0,600)

Select First Most Expensive Shoe
    Wait Until Page Contains Element    //div[@class="product-boxes"]//div
    Click Element    //div[@class="product-boxes"]//div

Select Shoe Size
    Execute Javascript   window.scrollTo(0,400)
    Sleep    ${SLEEP}s
    Click Element    //div[@id="select-variant-8-head"]
    Wait Until Page Contains Element    //div[@id="attr-label-8-0"]
    Click Element    //div[@id="attr-label-8-0"]

Add Shoe to Chart
    Sleep    ${SLEEP}s
    Wait Until Page Contains Element    //div[@class="variant__buttons--sticky-in"]//div
    Click Element    //div[@class="variant__buttons--sticky-in"]//div

Navigate Back to the Most Expensive Shoes List
    Wait Until Page Contains Element    //table[@class="cart-added__buttons"]/tbody/tr/td/a
    Click Element        //table[@class="cart-added__buttons"]/tbody/tr/td/a
    Execute Javascript    history.back()

Select Second Most Expensive Shoe
    Wait Until Page Contains Element    //div[@class="product-boxes"]/div[position()=2]
    Click Element    //div[@class="product-boxes"]/div[position()=2]

Scroll Up Page
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)

End Test
    Close Browser