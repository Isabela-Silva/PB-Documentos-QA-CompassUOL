*** Settings ***
Documentation

Resource  ../resources/base.robot

Suite Setup         Log      Antes dos testes
Suite Teardown      Log      Depois dos testes


Test Setup     Start Session
Test Teardown  Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuário

    &{user}             Create Dictionary
    ...                 name=IsaDev
    ...                 email=isa123@gmail.com
    ...                 password=isaq@2024

    Remove user from database    ${user['email']}

    Start Session

    Go To          http://localhost:3000/signup
    
    Wait For Elements State    css=h1   visible   5
    Get Text                   css=h1   equal     Faça seu cadastro

    Fill Text    id=name       ${user['name']}
    Fill Text    id=email      ${user['email']}
    Fill Text    id=password   ${user['password']}
    
    Click        id=buttonSignup

    Wait For Elements State    css=.notice p  visible   5
    Get Text                   css=.notice p  equal     Boas vindas ao Mark85, o seu gerenciador de tarefas.

    Take Screenshot

    
Não deve permitir o cadastro com email duplicado
    [Tags]     dup 

    ${user}             Create Dictionary
    ...                 name=IsaDev
    ...                 email=isa123@gmail.com
    ...                 password=isaq@2024

    Remove user from database    ${user['email']}
    Insert user from database    ${user}

    Start Session

    Go To          http://localhost:3000/signup
    
    Wait For Elements State    css=h1   visible   5
    Get Text                   css=h1   equal     Faça seu cadastro

    Fill Text    id=name       ${user['name']}
    Fill Text    id=email      ${user['email']} 
    Fill Text    id=password   ${user['password']}
    
    Click        id=buttonSignup

    Wait For Elements State    css=.notice p  visible   5
    Get Text                   css=.notice p  equal     Oops! Já existe uma conta com o e-mail informado.

    Take Screenshot