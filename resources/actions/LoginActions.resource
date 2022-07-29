*** Settings ***
Documentation                 Actions para realizar o preenchimento dos campos de login e submit do formulário

Resource                      ${EXECDIR}/resources/Base.resource


*** Keywords ***
Login With
    [Documentation]    Realizar preechimento dos campos de login e enviar o formulário
    [Arguments]                                       ${login}                                          ${password}

    Fill Text
    ...                                               id=email
    ...                                               ${login}
    Fill Text
    ...                                               id=password
    ...                                               ${password}

    Click                                             button[type=submit] >> text=Entrar

User Should Be Logged In
    [Documentation]    Verifica se o usuário passado como parâmetro conseguiu realizar login
    [Arguments]                                       ${user_name}

    Get Text
    ...                                               aside strong
    ...                                               should be
    ...                                               ${user_name}
