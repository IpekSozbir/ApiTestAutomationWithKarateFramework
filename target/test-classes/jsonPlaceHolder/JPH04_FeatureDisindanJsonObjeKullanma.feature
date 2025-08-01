Feature: JPH04 Kullanici Json objesi olan Test datalarini Feature disinda ollusturabilmeli

  Background:

    * def baseUrl = 'https://jsonplaceholder.typicode.com'
    * def pathParams = ['posts', 70]
    * def requestBody = read ("td_request.json")
    * def expectedResponseBody = read ("td_expectedResponseBody.json")

  Scenario: TC04 disaridan Json Obje  Kullanilabilmeli
    Given url  baseUrl
    And path  pathParams
    When request  requestBody
    And method Put
    Then status 200
    And assert response.id == expectedResponseBody.id
    And assert response.title == expectedResponseBody.title
    And assert response.body == expectedResponseBody.body
    And assert response.userId == expectedResponseBody.userId
