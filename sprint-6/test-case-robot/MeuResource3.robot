*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${URL}    https://serverest.dev

*** Keywords ***

Criar Sessao Para API ServerRest
    Create Session    minha_sessao    ${URL}

# Keywords para Usuarios
Criar Novo Usuario Valido
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Isabela Regina
    ...    email=isabela@teste.com
    ...    password=123456
    ...    administrador="true"
    ${response}=    POST On Session    minha_sessao    /usuarios    json=${payload}    headers=${headers}
    Status Should Be    201    ${response}
    ${usuario_id}=    Get From Dictionary    ${response.json()}    _id
    Set Test Variable    ${usuario_id}
    Log To Console    ID do novo usuario: ${usuario_id}
    RETURN    ${usuario_id}

Criar Usuario Com Email Duplicado
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Usuario Duplicado
    ...    email=isabela@teste.com
    ...    password=123456
    ...    administrador="false"
    ${response}=    POST On Session    minha_sessao    /usuarios    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Criar Usuario Com Campos Nulos
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=
    ...    email=
    ...    password=
    ...    administrador=
    ${response}=    POST On Session    minha_sessao    /usuarios    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Obter Todos Os Usuarios
    ${response}=    GET On Session    minha_sessao    /usuarios
    Status Should Be    200    ${response}
    RETURN    ${response}

Obter Usuario Por ID Valido
    [Arguments]    ${usuario_id}
    ${response}=    GET On Session    minha_sessao    /usuarios/${usuario_id}
    Status Should Be    200    ${response}
    RETURN    ${response}

Obter Usuario Com ID Incompleto
    [Arguments]    ${id_incompleto}
    ${response}=    GET On Session    minha_sessao    /usuarios/${id_incompleto}    expected_status=400
    RETURN    ${response}

Atualizar Usuario Valido
    [Arguments]    ${usuario_id}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Isabela Atualizada
    ...    email=isabela.atualizada@teste.com
    ...    password=654321
    ...    administrador="true"
    ${response}=    PUT On Session    minha_sessao    /usuarios/${usuario_id}    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    RETURN    ${response}

Atualizar Usuario Sem Email
    [Arguments]    ${usuario_id}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Usuario Sem Email
    ...    password=123456
    ...    administrador="false"
    ${response}=    PUT On Session    minha_sessao    /usuarios/${usuario_id}    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Excluir Usuario Valido
    [Arguments]    ${usuario_id}
    ${response}=    DELETE On Session    minha_sessao    /usuarios/${usuario_id}
    Status Should Be    200    ${response}
    RETURN    ${response}

# Keywords para Produtos
Criar Novo Produto Valido
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Produto Teste
    ...    descricao=Descricao do produto teste
    ...    preco=29.99
    ...    quantidade=10
    ${response}=    POST On Session    minha_sessao    /produtos    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    ${produto_id}=    Get From Dictionary    ${response.json()}    _id
    Set Test Variable    ${produto_id}
    Log To Console    ID do novo produto: ${produto_id}
    RETURN    ${produto_id}

Criar Produto Com Quantidade Invalida
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Produto Quantidade Invalida
    ...    descricao=Produto com quantidade negativa
    ...    preco=15.99
    ...    quantidade=-5
    ${response}=    POST On Session    minha_sessao    /produtos    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Criar Produto Com Descricao Nula
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Produto Sem Descricao
    ...    descricao=
    ...    preco=19.99
    ...    quantidade=5
    ${response}=    POST On Session    minha_sessao    /produtos    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Criar Produto Com Preco Negativo
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Produto Preco Negativo
    ...    descricao=Produto com preco negativo
    ...    preco=-10.00
    ...    quantidade=3
    ${response}=    POST On Session    minha_sessao    /produtos    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Obter Todos Os Produtos
    ${response}=    GET On Session    minha_sessao    /produtos
    Status Should Be    200    ${response}
    RETURN    ${response}

Obter Produto Por ID Valido
    [Arguments]    ${produto_id}
    ${response}=    GET On Session    minha_sessao    /produtos/${produto_id}
    Status Should Be    200    ${response}
    RETURN    ${response}

Atualizar Produto Valido
    [Arguments]    ${produto_id}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    nome=Produto Atualizado
    ...    descricao=Descricao atualizada do produto
    ...    preco=35.99
    ...    quantidade=15
    ${response}=    PUT On Session    minha_sessao    /produtos/${produto_id}    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    RETURN    ${response}

Excluir Produto No Carrinho
    [Arguments]    ${produto_id}
    ${response}=    DELETE On Session    minha_sessao    /produtos/${produto_id}    expected_status=400
    RETURN    ${response}

# Keywords para Login
Realizar Login Valido
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    email=isabela@teste.com
    ...    password=123456
    ${response}=    POST On Session    minha_sessao    /login    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    ${token}=    Get From Dictionary    ${response.json()}    authorization
    Set Test Variable    ${token}
    Log To Console    Token de login: ${token}
    RETURN    ${token}

Realizar Login Com Email Invalido
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    email=email_inexistente@teste.com
    ...    password=123456
    ${response}=    POST On Session    minha_sessao    /login    json=${payload}    headers=${headers}
    Status Should Be    401    ${response}
    RETURN    ${response}

Realizar Login Com Senha Nula
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    email=isabela@teste.com
    ...    password=
    ${response}=    POST On Session    minha_sessao    /login    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}

Realizar Login Com Valores Nulos
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary
    ...    email=
    ...    password=
    ${response}=    POST On Session    minha_sessao    /login    json=${payload}    headers=${headers}
    Status Should Be    400    ${response}
    RETURN    ${response}
