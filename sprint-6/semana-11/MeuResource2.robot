*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${URL}    https://restful-booker.herokuapp.com


*** Keywords ***
Criar Sessao Para API
    Create Session    minha_sessao    ${URL}

Obter Token de Autenticacao
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    minha_sessao    /auth    json=${payload}    headers=${headers}
    ${token}=    Get From Dictionary    ${response.json()}    token
    Set Test Variable    ${token}
    Log To Console    O token de autenticacao e: ${token}
    RETURN    ${token}

Criar Nova Reserva
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json
    ${booking_dates}=    Create Dictionary    checkin=2025-05-01    checkout=2025-05-10
    ${payload}=    Create Dictionary
    ...    firstname=Isabela
    ...    lastname=Regina
    ...    totalprice=111
    ...    depositpaid=${TRUE}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Breakfast
    ${response}=    POST On Session    minha_sessao    /booking    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    ${booking_id}=    Get From Dictionary    ${response.json()}    bookingid
    Set Test Variable    ${booking_id}
    Log To Console    ID da nova reserva: ${booking_id}
    RETURN    ${booking_id}

Validar Dados Da Reserva
    [Arguments]    ${id_da_reserva}    ${primeiro_nome}    ${ultimo_nome}
    ${response}=    GET On Session    minha_sessao    /booking/${id_da_reserva}    expected_status=200
    ${conteudo}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${conteudo}[firstname]    ${primeiro_nome}
    Should Be Equal As Strings    ${conteudo}[lastname]    ${ultimo_nome}

Atualizar Reserva
    [Arguments]    ${id_da_reserva}
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json    Cookie=token=${token}
    ${booking_dates_atualizadas}=    Create Dictionary    checkin=2025-06-01    checkout=2025-06-10
    ${payload}=    Create Dictionary
    ...    firstname=Isa
    ...    lastname=Regina
    ...    totalprice=222
    ...    depositpaid=${TRUE}
    ...    bookingdates=${booking_dates_atualizadas}
    ...    additionalneeds=Lunch
    ${response}=    PUT On Session    minha_sessao    /booking/${id_da_reserva}    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
    ${conteudo}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${conteudo}[firstname]    Isa

Excluir Reserva
    [Arguments]    ${id_da_reserva}
    ${headers}=    Create Dictionary    Content-Type=application/json    Cookie=token=${token}
    ${response}=    DELETE On Session    minha_sessao    /booking/${id_da_reserva}    headers=${headers}
    Status Should Be    201    ${response}

