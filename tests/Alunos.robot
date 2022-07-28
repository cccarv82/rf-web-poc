*** Settings ***
Documentation                 Funcionalidade de Gestão de Alunos

Resource                      ${EXECDIR}/resources/Base.resource

# Define as ações que serão executadas no início de cada teste/suite (setup) e no final de cada teste/suite (teardown)
Suite Setup                   Login As Admin
Test Setup                    Go To Initial Page
Test Teardown                 After Test


*** Test Cases ***
Novo Aluno
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
