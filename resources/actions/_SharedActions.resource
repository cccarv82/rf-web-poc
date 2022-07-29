*** Settings ***
Documentation                 Actions que são utilizadas por mais de uma suíte de testes

Resource                      ${EXECDIR}/resources/Base.resource


*** Keywords ***
Toaster Message Should Be
    [Documentation]    Validação da mensagem apresentada no componente toaster
    [Arguments]                                       ${expected_message}

    Wait For Elements State
    ...                                               .Toastify__toast-body >> text=${expected_message}
    ...                                               visible
    ...                                               5s

Alert Text Should Be
    [Documentation]    Valida as mensagens de alerta apresentadas pelo sistema
    [Arguments]                                       ${expected_alert}

    Wait For Elements State
    ...                                               form span >> text=${expected_alert}
    ...                                               visible
    ...                                               5s

Get Alerts
    [Documentation]    Keyword utilizada para recuperar alertas apresentados pelo sistema
    [Arguments]                                       ${index}
    ${alert}                                          Get Text
    ...                                               xpath=(//form//span)[${index}]
    RETURN                                          ${alert}
