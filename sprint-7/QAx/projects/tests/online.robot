*** Settings ***

Resource   ../resources/base.robot

*** Test Cases ***
webapp deve estar online

    Start Session
    Get Title     equal       Mark85 by QAx 

    