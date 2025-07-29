Feature: JPH05 Kullanici  disaridan kullandigi Json objelerinde degisikilik yapabilmeli
  
  Background:

    * def baseUrl = 'https://jsonplaceholder.typicode.com'
    * def pathParams = ['posts', 70]
    * def requestBody = read ("td_request.json")
    * def expectedResponseBody = read ("td_expectedResponseBody.json")


  Scenario:TC05 disaridan Json Obje  Kullanilabilmeli

    Given url  baseUrl
    And path  pathParams
    Then set requestBody.title = "Karate"
    And set requestBody.body = "Framework"
    And request  requestBody
    When method Put
    Then status 200
    And match header Content-Type == 'application/json; charset=utf-8'
    And match header Connection == 'keep-alive'
    Then set expectedResponseBody.title = "Karate"
    And set expectedResponseBody.body = "Framework"
    And  match response == expectedResponseBody
