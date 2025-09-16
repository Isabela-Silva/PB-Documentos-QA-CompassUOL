*** Settings ***
Resource  MeuResource3.robot

*** Variables ***
${EMAIL_VALIDO}       isabela@teste.com
${SENHA_VALIDA}       123456
${NOME_USUARIO}       Isabela Regina

*** Test Cases ***

TC01 - Criar Usuario Com Campos Validos
    [Documentation]    Testa a criacao de um usuario com todos os campos validos
    [Tags]    usuario    criacao    positivo
    
    Criar Sessao Para API ServerRest
    Criar Novo Usuario Valido
    Should Not Be Empty    ${usuario_id}
    Log To Console    Usuario criado com sucesso: ${usuario_id}

TC02 - Criar Usuario Com Email Duplicado
    [Documentation]    Testa a criacao de um usuario com email ja existente
    [Tags]    usuario    criacao    negativo
    
    Criar Sessao Para API ServerRest
    Criar Usuario Com Email Duplicado
    ${response}=    Criar Usuario Com Email Duplicado
    Should Be Equal As Strings    ${response.status_code}    400

TC03 - Criar Usuario Com Campos Nulos
    [Documentation]    Testa a criacao de um usuario com campos obrigatorios nulos
    [Tags]    usuario    criacao    negativo
    
    Criar Sessao Para API ServerRest
    ${response}=    Criar Usuario Com Campos Nulos
    Should Be Equal As Strings    ${response.status_code}    400

TC04 - Obter Todos Os Usuarios
    [Documentation]    Testa a consulta de todos os usuarios cadastrados
    [Tags]    usuario    consulta    positivo
    
    Criar Sessao Para API ServerRest
    ${response}=    Obter Todos Os Usuarios
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Total de usuarios encontrados

TC05 - Obter Usuario Por ID Valido
    [Documentation]    Testa a consulta de um usuario especifico por ID valido
    [Tags]    usuario    consulta    positivo
    
    Criar Sessao Para API ServerRest
    ${usuario_id}=    Criar Novo Usuario Valido
    ${response}=    Obter Usuario Por ID Valido    ${usuario_id}
    Should Be Equal As Strings    ${response.status_code}    200

TC06 - Obter Usuario Com ID Incompleto
    [Documentation]    Testa a consulta de um usuario com ID incompleto/invalido
    [Tags]    usuario    consulta    negativo
    
    Criar Sessao Para API ServerRest
    ${response}=    Obter Usuario Com ID Incompleto    123
    Should Be Equal As Strings    ${response.status_code}    400

TC07 - Atualizar Usuario Valido
    [Documentation]    Testa a atualizacao de um usuario com dados validos
    [Tags]    usuario    atualizacao    positivo
    
    Criar Sessao Para API ServerRest
    ${usuario_id}=    Criar Novo Usuario Valido
    ${response}=    Atualizar Usuario Valido    ${usuario_id}
    Should Be Equal As Strings    ${response.status_code}    200

TC08 - Atualizar Usuario Sem Email
    [Documentation]    Testa a atualizacao de um usuario sem informar o email
    [Tags]    usuario    atualizacao    negativo
    
    Criar Sessao Para API ServerRest
    ${usuario_id}=    Criar Novo Usuario Valido
    ${response}=    Atualizar Usuario Sem Email    ${usuario_id}
    Should Be Equal As Strings    ${response.status_code}    400

TC09 - Realizar Login Com Credenciais Validas
    [Documentation]    Testa o login com email e senha validos
    [Tags]    login    autenticacao    positivo
    
    Criar Sessao Para API ServerRest
    Criar Novo Usuario Valido
    ${token}=    Realizar Login Valido
    Should Not Be Empty    ${token}
    Log To Console    Login realizado com sucesso

TC10 - Realizar Login Com Email Invalido
    [Documentation]    Testa o login com email inexistente
    [Tags]    login    autenticacao    negativo
    
    Criar Sessao Para API ServerRest
    ${response}=    Realizar Login Com Email Invalido
    Should Be Equal As Strings    ${response.status_code}    400
