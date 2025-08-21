Feature: Kullanici PUT ile guncelleme yapar ve dogrular

  Background:
    * def base = 'https://restful-booker.herokuapp.com'
    * def bookingPath = 'booking'
    * def authHeader = 'Basic YWRtaW46cGFzc3dvcmQxMjM='

  Scenario: TC01 PUT sonrasi yapilan guncellemeyi dogrular
    # 1) Yeni booking olustur
    * def requestBody = read("rb_td_request.json")
    Given url base
    And path bookingPath
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request requestBody
    When method POST
    Then status 200
    * def bookingId = response.bookingid
    And print 'Oluşturulan bookingId:', bookingId

    # 2) Auth token al
    Given url base
    And path 'auth'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    * def token = response.token
    And print 'Token:', token

    # 3) PUT ile tum alanlari guncelle
    Given url base
    And path bookingPath, bookingId
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + token
    # Alternatif: Cookie yerine Basic Auth kullanmak istersen
    # And header Authorization = authHeader

    And request
    """
    {
      "firstname": "Volga",
      "lastname": "S",
      "totalprice": 1234,
      "depositpaid": true,
      "bookingdates": {
        "checkin": "2026-08-10",
        "checkout": "2026-08-20"
      },
      "additionalneeds": "breakfast"
    }
    """
    When method PUT
    Then status 200
    * def putResponse = response
    And print 'PUT response:', putResponse

    # 4) PUT donuşunu alan bazinda dogrula
    And assert putResponse.firstname == "Volga"
    And assert putResponse.lastname == "S"
    And assert putResponse.totalprice == 1234
    And assert putResponse.depositpaid == true
    And assert putResponse.bookingdates.checkin == "2026-08-10"
    And assert putResponse.bookingdates.checkout == "2026-08-20"
    And assert putResponse.additionalneeds == "breakfast"

    # 5) (Opsiyonel) GET ile de dogrula
    Given url base
    And path bookingPath, bookingId
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response ==
    """
    {
      firstname: "Volga",
      lastname: "S",
      totalprice: 1234,
      depositpaid: true,
      bookingdates: { checkin: "2026-08-10", checkout: "2026-08-20" },
      additionalneeds: "breakfast"
    }
    """