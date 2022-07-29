*** Settings ***
Documentation                 Funcionalidade de Gestão de Alunos

Resource                      ${EXECDIR}/resources/Base.resource

# Define as ações que serão executadas no início de cada teste/suite (setup) e no final de cada teste/suite (teardown)
Suite Setup                   Login As Admin
Test Setup                    Go To Initial Page
Test Teardown                 After Test


*** Test Cases ***
Novo aluno
    [Documentation]    Dado que realizo login no sistema como administrador
    ...    E acesso a área de Alunos
    ...    Quando acesso a funcionalidade de Cadastrar aluno
    ...    E envio o formulário com os dados a serem cadastrados
    ...    Então o sistema registra o novo aluno com sucesso
    [Tags]                                            smoke

    ${student}                                        Factory Users
    ...                                               student
    Access Student Registration
    Fill Student Data                                 ${student}
    Submit Student Registration
    Toaster Message Should Be                         Aluno cadastrado com sucesso.
    Verify If Student Appears                         ${student}

Cadastro duplicado de emails
    [Documentation]    Dado que realizo login no sistema como administrador
    ...    E acesso a área de Alunos
    ...    Quando acesso a funcionalidade de Cadastrar aluno
    ...    E envio o formulário com os dados a serem cadastrados utilizando um email já cadastrado
    ...    Então o sistema deve bloquear o registro
    ...    E apresentar mensagem informando o motivo
    [Tags]                                            negativo
    ${student}                                        Factory Users
    ...                                               student
    Add Student Data                                  ${student}
    # Insert Student Into DB    ${student}
    Access Student Registration
    Fill Student Data                                 ${student}
    Submit Student Registration
    Toaster Message Should Be                         Email já existe no sistema.

    [Teardown]                                        Thinking Before Take A Screenshot                 1s

Campos obrigatórios
    [Documentation]    Dado que acesso o formulário de cadastro de aluno
    ...    Quando tento submeter o formulário sem preencher as informações obrigatórias
    ...    Então o sistema deve apresentar mensagem informando que o campo é obrigatório
    [Tags]                                            negativo
    @{required_alerts}                                Set Variable
    ...                                               Nome é obrigatório
    ...                                               O e-mail é obrigatório
    ...                                               idade é obrigatória
    ...                                               o peso é obrigatório
    ...                                               a Altura é obrigatória
    @{system_required_alerts}                         Create List

    Access Student Registration
    Submit Student Registration

    FOR    ${index}    IN RANGE    1    6
        ${alert}                                          Get Alerts
        ...                                               ${index}
        Append To List
        ...                                               ${system_required_alerts}
        ...                                               ${alert}
    END

    Lists Should Be Equal
    ...                                               ${required_alerts}
    ...                                               ${system_required_alerts}

Campos numericos
    [Documentation]    Valida se os campos numéricos estão configurados
    ...    corretamente para aceitar apenas números
    [Tags]                                            smoke                                             teste
    [Template]                                        Check Numeric Fields On Student Form
    input[name=age]
    input[name=weight]
    input[name=feet_tall]


*** Keywords ***
Check Numeric Fields On Student Form
    [Documentation]    Template para validação de campos numéricos
    [Arguments]                                       ${element}
    Go To Initial Page
    Access Student Registration
    Check Numeric Fields                              ${element}
