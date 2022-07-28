*** Settings ***
Documentation                 Task que realiza a conexão ao banco de dados

Resource                      ${EXECDIR}/resources/Base.resource


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
