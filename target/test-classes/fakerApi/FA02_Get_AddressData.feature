Feature: FA02 Kullanici Get request sonucu donen response test eder

  Scenario: TC01 Get request'e donen response'in beklenilen ozelliklerde olmasi gerekir

    Given url 'https://fakerapi.it/api/v1/addresses'
    And param _quantity = 1
    When method GET
    Then status 200
    And match responseStatus == 200
    And assert  responseHeaders['Content-Type'][0] == 'application/json'
    And assert  response.data[0].city.length > 0
    #Test datasi oldugu  icin country alani surekli degişiyor. Bu yuzden string  data icerip icermedigini kontrol ettim
    And match response.data[0] contains { country: '#string' }


