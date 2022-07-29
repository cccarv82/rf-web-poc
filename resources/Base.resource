*** Settings ***
Documentation                 Arquivo base do projeto

Library                       Collections
Library                       Browser
Library                       ScreenCapLibrary
Library                       factories/Users.py
Library                       Utils.py
Library                       DatabaseLibrary
Resource                      actions/_SharedActions.resource
Resource                      actions/LoginActions.resource
Resource                      actions/AlunosActions.resource
Resource                      ${EXECDIR}/tasks/dbconnect.resource
Resource                      ${EXECDIR}/tasks/dbcleaner.robot
Resource                      ${EXECDIR}/tasks/dbseeder.resource


*** Variables ***
${BASE_URL}                   https://bodytest-web-stg.herokuapp.com


*** Keywords ***
Start Session
    [Documentation]    Implementação da inicialização do navegador utilizando a biblioteca Browser
    New Browser
    ...                                               ${BROWSER}
    ...                                               headless=${HEADLESS}
    ...                                               slowMo=00:00:00
    New Page                                          about:blank
    Set Viewport Size
    ...                                               1280
    ...                                               768

Go To Initial Page
    [Documentation]    Vai para a página inicial do sistema alvo
    Delete All Cookies
    Go To                                             ${BASE_URL}

After Test
    [Documentation]    Finalização do caso de teste capturando screenshot
    # Fix #3 para o relatório conter os screenshots quando executado em paralelo
    Take A Screenshot

Clear Local Storage
    [Documentation]    Keyword criada para pegar a evidência de usuário logado e
    ...    deslogar o usuário limpando o Local Storage
    ${screenshot_name}                                Screenshot Name
    Take A Screenshot
    LocalStorage Clear

Thinking Before Take A Screenshot
    [Documentation]    Algumas situações necessitam de uma espera forçada antes de ser evidenciada
    ...    Como exemplo, os toasters usados nessa aplicação levam um tepinho para serem
    ...    apresentados devido a animação do componente
    ...    Para casos assim podemos abrir uma excessão e usar um sleep
    [Arguments]                                       ${timer}
    Sleep                                             ${timer}
    Take A Screenshot

Take A Screenshot
    [Documentation]    Implementação para pegar uma evidência de tela
    ${screenshot_name}                                Screenshot Name
    Browser.Take Screenshot
    ...                                               fullPage=True
    ...                                               filename=${screenshot_name}

Login As Admin
    [Documentation]    Realiza login no sistema como administrador
    ...    Atenção, não é escopo realizar a validação da funcionalidade
    ...    Login, apenas realizar o login para ser usado em outros cenários
    ${admin}                                          Factory Users
    ...                                               admin
    Start Session
    Go To                                             ${BASE_URL}
    Login With
    ...                                               ${admin}[login]
    ...                                               ${admin}[password]
    User Should Be Logged In                          Administrador
