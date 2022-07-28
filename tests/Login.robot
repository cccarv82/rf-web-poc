*** Settings ***
Documentation                 Funcionalidade de Login

Resource                      ${EXECDIR}/resources/Base.resource

# Define as ações que serão executadas no início de cada teste/suite (setup) e no final de cada teste/suite (teardown)
Suite Setup                   Start Session
Test Setup                    Go To Initial Page
Test Teardown                 After Test


*** Test Cases ***
Login com sucesso
    [Documentation]    Dado que acesso a página de login
    ...    Quando faço login como Administrador
    ...    Então sou redirecionado para o Dashboard
    [Tags]                                            smoke

    ${user}                                           Factory Users
    ...                                               admin
    Login With
    ...                                               ${user}[login]
    ...                                               ${user}[password]
    User Should Be Logged In                          Administrador

    # Este cenário específico precisa ter um teardown diferente dos demais
    [Teardown]                                        Clear Local Storage

Senha incorreta
    [Documentation]    Dado que informo a senha incorreta na página de login
    ...    Então o sistema deve apresentar a mensagem "Usuário ou senha inválido"
    [Tags]                                            negativo

    ${user}                                           Factory Users
    ...                                               admin
    Login With
    ...                                               ${user}[login]
    ...                                               senhaincorreta
    Toaster Message Should Be                         Usuário e/ou senha inválidos.

    # Devido a característica do Toaster implementado este cenário necessita de um teardown específico
    [Teardown]                                        Thinking Before Take A Screenshot                 1s

Email não cadastrado
    [Documentation]    Dado que informo um email não cadastrado na página de login
    ...    Então o sistema deve apresentar a mensagem "Usuário ou senha inválido"
    [Tags]                                            negativo

    ${user}                                           Factory Users
    ...                                               admin
    Login With
    ...                                               emailnaocadastrado@bodytest.com
    ...                                               ${user}[password]
    Toaster Message Should Be                         Usuário e/ou senha inválidos.
    # Devido a característica do Toaster implementado este cenário necessita de um teardown específico
    [Teardown]                                        Thinking Before Take A Screenshot                 2s

Email incorreto
    [Documentation]    Dado que informo um email incorreto
    ...    Então o sistema deve apresentar a mensagem "Informe um e-mail válido"
    [Tags]                                            negativo

    ${user}                                           Factory Users
    ...                                               admin
    Login With
    ...                                               email&bodytest.com
    ...                                               ${user}[password]
    Alert Text Should Be                              Informe um e-mail válido

Senha não informada
    [Documentation]    Dado que tento submeter o formulário de login sem informar a senha
    ...    Então o sistema deve apresentar a mensagem "A senha é obrigatória"
    [Tags]                                            negativo

    ${user}                                           Factory Users
    ...                                               admin

    Login With
    ...                                               ${user}[login]
    ...                                               ${EMPTY}

    Alert Text Should Be                              A senha é obrigatória

Email não informado
    [Documentation]    Dado que tento submeter o formulário de login sem informar o email
    ...    Então o sistema deve apresentar a mensagem "O e-mail é obrigatório"
    [Tags]                                            negativo

    ${user}                                           Factory Users
    ...                                               admin

    Login With
    ...                                               ${EMPTY}
    ...                                               ${user}[password]

    Alert Text Should Be                              O e-mail é obrigatório

Email e Senha não informados
    [Documentation]    Dado que tento submeter o formulário de login sem informar email e senha
    ...    Então o sistema deve apresentar as mensagens "A senha é obrigatória"
    ...    e "O e-mail é obrigatório"
    [Tags]                                            negativo

    Login With
    ...                                               ${EMPTY}
    ...                                               ${EMPTY}

    Alert Text Should Be                              O e-mail é obrigatório
    Alert Text Should Be                              A senha é obrigatória
