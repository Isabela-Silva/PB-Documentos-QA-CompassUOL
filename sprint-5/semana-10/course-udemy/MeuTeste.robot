*** Settings ***
Resource  MeuResource.robot

*** Test Cases ***
Fluxo Completo De Reserva Na API
    Criar Sessao Para API
    Obter Token de Autenticacao
    Criar Nova Reserva
    Validar Dados Da Reserva    ${booking_id}    Isabela    Regina
    Atualizar Reserva    ${booking_id}
    Validar Dados Da Reserva    ${booking_id}    Isa    Regina
    Excluir Reserva    ${booking_id}