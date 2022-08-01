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
    RETURN                                            ${alert}

Check Type Fields
    [Documentation]    Keyword para validar se os campos numéricos estão
    ...    corretamente configurados com o type number
    [Arguments]                                       ${element}                                        ${type}
    ${attribute}                                      Get Attribute
    ...                                               ${element}
    ...                                               type
    Should Be Equal
    ...                                               ${attribute}
    ...                                               ${type}

Search Should Return No Data
    [Documentation]    Valida que a busca realizada não encontrou registros
    Wait For Elements State
    ...                                               text=Nenhum registro encontrado.
    ...                                               visible
    ...                                               5s
    Wait For Elements State
    ...                                               table
    ...                                               detached
    ...                                               5s
