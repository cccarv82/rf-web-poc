*** Settings ***
Documentation                 Task que realiza a limpeza do banco de dados
...                           comando: robot -l NONE -o NONE -r NONE tasks/dbcleaner.robot

Resource                      ${EXECDIR}/resources/Base.resource


*** Tasks ***
Database Cleaner
    [Documentation]    Realiza a conexão ao banco, executa a query e finaliza a conexão
    Connect To Base
    Clean User DB
    Disconnect from Database


*** Keywords ***
Connect To Base
    [Documentation]    Realiza a conexão ao banco de dados
    Connect To Database
    ...                                               psycopg2
    ...                                               dbi4b1lgaealsp
    ...                                               nzlbkrpakjfpwu
    ...                                               1f356bfe1b74cb3c97661e55028c8c6c7b975f8b8eb02cb81b6d28472f7dde27
    ...                                               ec2-107-22-122-106.compute-1.amazonaws.com
    ...                                               5432

Clean User DB
    [Documentation]    Executa a query para limpar a tabela de usuários
    Execute SQL String                                DELETE from students;
