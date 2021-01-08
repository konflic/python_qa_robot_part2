*** Settings ***
Documentation  API Testing small example
Library  ../../Libs/CustomRequests.py


*** Variables ***
${API}  https://my-api-examaple.herokuapp.com/api
${LOGIN}  ${API}/auth/login
${STATUS}  ${API}/auth/status


*** Test Cases ***
Test Authorization
    Create Session  authorized_session  ${API}
    ${auth_data} =  Create Dictionary  login=admin  password=admin
    ${resp} =  LOGIN On Session  authorized_session  ${LOGIN}  json=${auth_data}
    Request Should Be Successful  ${resp}
    Should Be Equal As Strings  ${resp.json().get("status")}  authorized


Test Authorized Status
    ${resp} =  GET On Session  authorized_session  /auth/status
    Should Be Equal As Strings  ${resp.json().get("authorized")}  True
