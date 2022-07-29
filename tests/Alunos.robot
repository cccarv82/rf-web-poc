*** Settings ***
Documentation                 Funcionalidade de Gestão de Alunos

Resource                      ${EXECDIR}/resources/Base.resource

# Define as ações que serão executadas no início de cada teste/suite (setup) e no final de cada teste/suite (teardown)
Suite Setup                   Login As Admin
Test Setup                    Go To Initial Page
Test Teardown                 After Test


*** Test Cases ***
Cenario: Novo aluno
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

Cenario: Cadastro duplicado de emails
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

Cenario: Campos obrigatórios
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

Cenario: Campos numericos
    [Documentation]    Valida se os campos numéricos estão configurados
    ...    corretamente para aceitar apenas números
    [Tags]                                            smoke
    [Template]                                        Check Type Fields On Student Form
    ${AGE_FIELD}    number
    ${WEIGHT_FIELD}    number
    ${FEET_TALL_FIELD}    number

Cenario: Campos email
    [Documentation]    Valida se os campos de email estão configurados
    ...    corretamente para aceitar apenas email no formato válido
    [Tags]                                            smoke
    [Template]                                        Check Type Fields On Student Form
    ${EMAIL_FIELD}    email

Cenario: Abaixo de 14 anos
    [Documentation]    Dado que realizo login no sistema como administrador
    ...    E acesso a área de Alunos
    ...    Quando acesso a funcionalidade de Cadastrar aluno
    ...    E envio o formulário com os dados a serem cadastrados informando a idade abaixo de 14 anos
    ...    Então o sistema deve bloquear o registro
    ...    E apresentar mensagem informando o motivo
    [Tags]                                            negativo
    ${student_below_14}                               Factory Users
    ...                                               student_below_14
    Access Student Registration
    Fill Student Data                                 ${student_below_14}
    Submit Student Registration
    Alert Text Should Be                              A idade deve ser maior ou igual 14 anos

Cenario: Remover aluno
    [Documentation]    Dado que realizo login no sistema como administrador
    ...    E acesso a área de Alunos
    ...    Quando aciono a funcionalidade de Apagar aluno
    ...    E confirmo a exclusão
    ...    Então o sistema deve remover o registro do sistema
    ${student}                                        Factory Users
    ...                                               student
    Add Student Data                                  ${student}
    Search For Student                                ${student}
    Delete User                                       True

Cenario: Desistir da exclusão
    [Documentation]    Dado que realizo login no sistema como administrador
    ...    E acesso a área de Alunos
    ...    Quando aciono a funcionalidade de Apagar aluno
    ...    E desisto da exclusão
    ...    Então deve manter o registro do estudante
    ${student}    Factory Users
    ...    student
    Add Student Data                                  ${student}
    Search For Student                                ${student}
    Delete User                                       False


*** Keywords ***
Check Type Fields On Student Form
    [Documentation]    Template para validação de campos numéricos
    [Arguments]                                       ${element}                                        ${type}
    Go To Initial Page
    Access Student Registration
    Check Type Fields
    ...                                               ${element}
    ...                                               ${type}
