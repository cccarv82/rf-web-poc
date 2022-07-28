*** Settings ***
Documentation                 Actions que são utilizadas por mais de uma suíte de testes


*** Keywords ***
Toaster Message Should Be
    [Documentation]    Validação da mensagem apresentada no componente toaster
    [Arguments]                                       ${expected_message}

    Wait For Elements State
    ...                                               .Toastify__toast-body >> text=${expected_message}
    ...                                               visible
    ...                                               5s
