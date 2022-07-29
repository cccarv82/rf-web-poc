*** Settings ***
Documentation                 Actions refentes aos testes de Alunos

Resource                      ${EXECDIR}/resources/Base.resource


*** Variables ***
${NAME_FIELD}                 id=name
${EMAIL_FIELD}                id=email
${AGE_FIELD}                  id=age
${WEIGHT_FIELD}               id=weight
${FEET_TALL_FIELD}            id=feet_tall
${SEARCH_STUDENT_FIELD}       input[placeholder="Buscar aluno"]


*** Keywords ***
Access Student Registration
    [Documentation]    Keyword para acessar o formulário que deve ser
    ...    preenchido para cadastrar alunos
    Go To                                             ${BASE_URL}
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
    ...                                               ${NAME_FIELD}
    ...                                               ${student}[name]
    Fill Text
    ...                                               ${EMAIL_FIELD}
    ...                                               ${student}[email]
    Fill Text
    ...                                               ${AGE_FIELD}
    ...                                               ${student}[age]
    Fill Text
    ...                                               ${WEIGHT_FIELD}
    ...                                               ${student}[weight]
    Fill Text
    ...                                               ${FEET_TALL_FIELD}
    ...                                               ${student}[feet_tall]

Submit Student Registration
    [Documentation]    Submete e valida o toaster de sucesso/insucesso
    Click                                             button[type="submit"] >> text= Salvar

Verify If Student Appears
    [Documentation]    Verifica se os dados cadastrados aparecem na tabela de alunos cadastrados
    [Arguments]                                       ${student}
    Search For Student                                ${student}
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

Search For Student
    [Documentation]    Keyword que realiza a busca de um aluno
    [Arguments]                                       ${student}

    Fill Text
    ...                                               input[placeholder="Buscar aluno"]
    ...                                               ${student}[name]
    Wait For Elements State
    ...                                               text=${student}[email]
    ...                                               visible
    ...                                               5s

Delete User
    [Documentation]    Deleta um estudante a partir do frontend do sistema
    [Arguments]                                       ${delete}
    Click                                             id=trash >> text=Apagar
    Wait For Elements State                           text=Você está certo disso?

    IF    ${delete} == True
        Click                                             button >> text=SIM, pode apagar!
        Toaster Message Should Be                         Aluno removido com sucesso.
    ELSE
        Click                                             button >> text=NÃO
    END
