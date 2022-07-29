*** Settings ***
Documentation                 Actions refentes aos testes de Alunos

Resource                      ${EXECDIR}/resources/Base.resource


*** Keywords ***
Access Student Registration
    [Documentation]    Keyword para acessar o formulário que deve ser
    ...    preenchido para cadastrar alunos
    Click                                             a[href="/alunos"]
    Wait For Elements State
    ...                                               h1 >> text=Gestão de Alunos
    ...                                               visible
    ...                                               5s
    Click                                             a[href="/alunos/new"]
    Wait For Elements State                           id=formStudent
    ...                                               visible
    ...                                               5s

Fill Student Data
    [Documentation]    Keyword para preencher os dados do aluno a ser cadastrado
    [Arguments]                                       ${student}
    Fill Text
    ...                                               id=name
    ...                                               ${student}[name]
    Fill Text
    ...                                               id=email
    ...                                               ${student}[email]
    Fill Text
    ...                                               id=age
    ...                                               ${student}[age]
    Fill Text
    ...                                               id=weight
    ...                                               ${student}[weight]
    Fill Text
    ...                                               id=feet_tall
    ...                                               ${student}[feet_tall]

Submit Student Registration
    [Documentation]    Submete e valida o toaster de sucesso/insucesso
    Click                                             button[type="submit"] >> text= Salvar

Verify If Student Appears
    [Documentation]    Verifica se os dados cadastrados aparecem na tabela de alunos cadastrados
    [Arguments]                                       ${student}
    Fill Text
    ...                                               input[placeholder="Buscar aluno"]
    ...                                               ${student}[name]
    Wait For Elements State                           text=${student}[name]
    Wait For Elements State                           text=${student}[email]
    Wait For Elements State                           text=${student}[age]

Add Student Data
    [Documentation]    Keyword responsável por inserir um aluno no sistema
    ...    Observação: Esta keyword não valida a inserção do aluno!!!
    [Arguments]                                       ${student}
    Access Student Registration
    Fill Student Data                                 ${student}
    Submit Student Registration
    Go To                                             ${BASE_URL}
