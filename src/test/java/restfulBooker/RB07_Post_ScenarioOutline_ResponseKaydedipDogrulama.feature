Feature: Kullanici farkli verilerle coklu POST request gonderir

  Scenario Outline: TC01 POST request sonrasi response dogrulama
    * def requestBody =
    """
    {
      "firstname": "<firstname>",
      "lastname": "<lastname>",
      "totalprice": <totalprice>,
      "depositpaid": <depositpaid>,
      "bookingdates": {
        "checkin": "<checkin>",
        "checkout": "<checkout>"
      },
      "additionalneeds": "<additionalneeds>"
    }
    """

    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request requestBody
    When method POST
    Then status 200

    * def savedResponse = response

    And match savedResponse.booking.firstname == "<firstname>"
    And match savedResponse.booking.lastname == "<lastname>"
    And match savedResponse.booking.totalprice == <totalprice>
    And match savedResponse.booking.depositpaid == <depositpaid>
    And match savedResponse.booking.bookingdates.checkin == "<checkin>"
    And match savedResponse.booking.bookingdates.checkout == "<checkout>"
    And match savedResponse.booking.additionalneeds == "<additionalneeds>"

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Ipek      | Sozbir   | 500        | false       | 2026-01-10 | 2026-01-20 | wi-fi           |
      | Volga     | Sozbir   | 700        | true        | 2026-01-10 | 2026-01-20 | breakfast       |