*** Settings ***
Documentation                 Task que utiliza o banco de dados para suportar os testes

Library                       DatabaseLibrary
Resource                      dbconnect.resource


*** Keywords ***
Insert Student Into DB
    [Documentation]    Executa a query para inserir um aluno na base de dados
    [Arguments]                                       ${student}
    ${query}                                          Set Variable
    ...                                               insert into students (name, email, age, weight, feet_tall, created_at, updated_at) values('${student}[name]', '${student}[email]', '${student}[age]', '${student}[weight]', '${student}[feet_tall]', NOW(), NOW());
    Connect To DB
    ${log}                                            Execute SQL String
    ...                                               ${query}
    Log                                               ${log}
    Disconnect From Database

Delete Student In DB
    [Documentation]    Executa a query para remover pelo nome um aluno na base de dados
    [Arguments]                                       ${student}
    ${query}                                          Set Variable
    ...                                               delete from students where name LIKE '%${student}%'
    Connect To DB
    ${log}                                            Execute SQL String
    ...                                               ${query}
    Log                                               ${log}
    Disconnect From Database
