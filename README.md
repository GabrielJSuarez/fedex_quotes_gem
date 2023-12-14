## FedEX Client Interface 

- interface to get quotes from FedEx services, barebones applications that can be use for tests pourpuses with the included sanbox keys. It also accepts your own credentials for custom auth tokens.

## ACCEPTED PARAMS

## QUOTE PARAMS
```javascript
quote_param: {
  address_from: {
    zip: "64000",
    country: "MX"
  },
  address_to: {
    zip: "66000",
    country: "MX"
  },
  parcel: {
    length: 25.0,
    width: 28.0,
    height: 46.0,
    distance_unit: "cm",
    weight: 6.5,
    mass_unit: "kg"
  }
}
```
## CREDENTIALS

```javascript
credentials: {
  client_id: "FEDEX API KEY",
  client_secret: "FEDEX SECRET KEY",
  account_number: "FEDEX ACCOUNT NUMBER"
}
```

Note: Credentials on this repo are not mandatory, if you don't pass them it will use sandbox api keys that come with the project.

## USAGE METHODS

```ruby
# with credentials

rates = Fedex::Rates.get(quote_params, credentials)

# with no credentials

rates = Fedex::Rates.get(quote_params)
```

## EXPECTED RESPONSE


```ruby
response = [
              {
                "price": 218.05,
                "currency": "mxn",
                "service_level": {
                  "name": "Standard Overnight",
                  "token": "STANDARD_OVERNIGHT"
                }
              },
              {
                "price": 139.08,
                "currency": "MXN",
                "service_level": {
                  "name": "Fedex Express Saver",
                  "token": "FEDEX_EXPRESS_SAVER"
                }
              }
          ]
```



