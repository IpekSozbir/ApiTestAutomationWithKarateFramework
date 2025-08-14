Feature: Kullanici Delete amaci ile olusturdugu booking'in request sonucu donen response'unu test eder

  Background: Test datalarini tanimlama
    * def requestBody = read("rb_td_request.json")

  Scenario: TC01 Kullanici yeni bir booking create edebilmeli, delete edebilmeli ve dogrulayabilmeli
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=abc123'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    And request requestBody
    When method POST
    Then status 200
    * def id = response.bookingid

  # delete
    Given url 'https://restful-booker.herokuapp.com/booking'
    And path id
    And header Cookie = 'token=abc123'
    And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    When method DELETE
    Then status 201

  # verify
    Given url 'https://restful-booker.herokuapp.com/booking'
    And path id
    When method GET
    Then status 404