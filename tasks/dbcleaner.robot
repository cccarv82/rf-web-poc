*** Settings ***
Documentation                 Task que realiza a limpeza do banco de dados
...                           comando: robot -l NONE -o NONE -r NONE tasks/dbcleaner.robot

Resource                      dbconnect.resource


*** Tasks ***
Database Cleaner
    [Documentation]    Realiza a conexão ao banco, executa a query e finaliza a conexão
    Connect To DB
    Clean User DB
    Disconnect From Database


*** Keywords ***
Clean User DB
    [Documentation]    Executa a query para limpar a tabela de usuários
    Execute SQL String                                DELETE from students;
