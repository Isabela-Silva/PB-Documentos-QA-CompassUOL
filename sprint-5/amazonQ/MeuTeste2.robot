*** Settings ***
Resource  MeuResource2.robot

*** Variables ***
${NOME_INICIAL}       Isabela
${SOBRENOME_INICIAL}  Regina
${NOME_ATUALIZADO}    Isa
${SOBRENOME_ATUALIZADO}    Regina

*** Test Cases ***
Fluxo Completo De Reserva Na API
    [Documentation]    Testa o ciclo completo de uma reserva: criação, validação, atualização e exclusão
    [Tags]    api    reserva    crud    smoke
   

    Criar Sessao Para API
    Obter Token de Autenticacao
    Criar Nova Reserva
    Validar Dados Da Reserva    ${booking_id}    ${NOME_INICIAL}     ${SOBRENOME_INICIAL}
    Atualizar Reserva           ${booking_id}
    Validar Dados Da Reserva    ${booking_id}    ${NOME_ATUALIZADO}  ${SOBRENOME_ATUALIZADO} 
    Excluir Reserva             ${booking_id}