Feature: FA01 Kullanici Get request sonucu donen response test eder

  Scenario: TC01 Get request'e donen response'in beklenilen ozelliklerde olmasi gerekir

    Given url 'https://fakerapi.it/api/v1/persons'
    # And path  yerine  param kullandik cunku path sadece endpoint icin, Query parametlerle param kullanilir
    And param _quantity = 1
    When method GET
    Then status 200
    #And print response // donen response'u gormek icin kullanilabilir
    And match responseStatus == 200
    And assert responseHeaders['Content-Type'][0] == 'application/json'
    And assert response.data[0].firstname.length > 0
    And assert response.data[0].lastname.length > 0








