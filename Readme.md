# BTC - Tracker Docs

Sizwe S. Maluleke


# Project Overview

This project is a basic application built in Xcode using swift. It utilizes the Fixer API to fetch currency exchange rates and provide real-time info about the value of Bitcoin in different currencies based on the amount of Bitcoin the user inputs as an investment value. The user interface is constructed using SwiftUI.


# Features

The application provides the following features:



1. ** Bitcoin amount Input & storage:** The user can enter the    amount of bitcoin they own using a designated input field in the app. The amount entered is stored and updated each time the user updates the amount
2. **Currency Value Display List: **The app displays the current value of the user’s Bitcoin in different currencies. The supported currencies include BTC (the base currency), ZAR, USD, AUD
3. **Asset Value Fluctuation: **The app indicates whether the value of the user’s Bitcoin has increased or decreased since the previous day for each currency. 

 \
 \



# Architecture

This App accomplishes its features by using 2 components: 



1. **BTC Investment **- responsible for  1. Bitcoin amount Input & storage
2. **Currency List - **responsible for 2,3 Currency Value Display List & Asset Value Fluctuation

And **Network Manager -** responsible for network API calls to the fixer API

The Components follow a MVVM architectural pattern with each component having a Model, View and View Model 



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")



# File Structure



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")



# Technical Overview


## BTC Investment


### InvestmentViewModel

The **InvestmentViewModel **class is responsible for managing the investment amount in Bitcoin (BTC). it conforms to the Observable Object protocol, allowing it to publish changes to its properties. The class includes the following properties

**bitcoinAmount: **a published property responsible for managing the investment amount in Bitcoin. It is stored in the user defaults and automatically updates the stored value whenever it changes. The **@Published **property wrapper ensures that aby views observing this property are updated when it changes.


#### Initialization


```
init()
```


The initializer retrieves the investment amount from the user defaults, if available, and assigns it to the ** bitcoinAmount ** property if no value is found, the property is initialized with the default value of 0.0


#### Storing the Bitcoin Amount

The  **bitcoinAmount **property includes a **didSet **property observer that is called everytime the value of  **bitcoinAmount** segt . the updated investment amount is stored in a the user defaults using the **UserDefaults.standard.set(_:forKey) **method:


```
UserDefaults.standard.set(bitcoinAmount, forKey: "BitcoinAmount")
```


By storing the amount is user defaults, the value will persist even when the app is closed and reopened


### InvestmentView

The **InvestmentView **struct is a SwiftUI view that displays and allows users to update the investment amount. It utilizes an instance of the InvestmentViewModel** **class to manage the investment amount. The struct includes the following properties and body:


#### Properties



* **viewModel**: an observed object of type **InvestmentViewModel** that manages the investment amount
* **inputValue: ** a state property that holds the input value entered by the user 


#### Body

Consists of a **VStack** containing:



* A nested **Vstack **displaying the current investment and a label
* A **HStack **containing a text field for entering the BTC amount and a button to update the investment amount.

The **TextField** uses the **onReceive **modifier to filter the input value and only allow numeric characters, commas, and periods. The updated investment amount is set in the view model when the user taps the “Update” button


## NetworkManager

The **networkManager** class is responsible for handling network operations, specifically fetching data from an API endpoint. It provides a convenient method called **fetchData** that allows you to make GET requests and decode the received data into a specific type.


### Initialization

To create an instance of **NetworkManager**, you need to provide an API key and a base URL. These values are passed to the initializer when creating a **NetworkManager** objec. The API key is used to authenticate the requests, and the base URL represents the root url of the API


```
let networkManager = NetworkManager(apiKey: "your-api-key", baseURL: "https://api.example.com/")
```



### Fetching Data


```
func fetchData() -> AnyPublisher<T, Error>
```


The **FetchData **method is used to fetch data from a specific API endpoint. It takes an endpoint parameter, which represents the specific endpoint to request data from.

Example usage:


```
networkManager.fetchData(forEndpoint: "/currencylist")
    .sink { completion in
        // Handle completion (success or failure)
    } receiveValue: { data in
        // Handle the received data
    }
```


Inside the **fetchData** method a URL is made by appending the endpoint to the baseURL. Then a HTTP GET request is made to the constructed URL with the provided API key added as a value for the “apikey” header field

The response data is decoded into a type T and returned as AnyPublisher&lt;A, Error>.


## Currency List


### BTC Service

The **BTCService **class is responsible for interacting with the API to fetch currency rates and fluctuations related to Bitcoin (BTC) it uses the **NetworkManager **class to make API requests and handle network operations


#### Initialization


```
let btcService = BTCService()
```


 \
To create an instance if the BTCService class, call the initializer. The network property is initialized with a hardcoded apikey and baseURL


#### Fetching Currency Rates 


```
func fetchCurrencyRates() -> AnyPublisher<Currency, Error>
```


The ** fetchCurrencyRates **method is used to fetch the latest currency rates for the specified symbols and base currency. It returns a publisher that emits a **Currency **object or an error

Example usage:


```
btcService.fetchCurrencyRates()
    .sink { completion in
        // Handle completion (success or failure)
    } receiveValue: { currency in
        // Handle the received currency rates
    }
```



#### Fetching Currency Fluctuations


```
func fetchCurrencyFluctuations() -> AnyPublisher<Fluctuations, Error>
```


The fetch **Currency Fluctuations **method is used to fetch currency fluctuations for the specified symbols and base currency within specified date range. It returns a publisher that emits a ** Fluctuations ** Object or an error

Example usage:


```
btcService.fetchCurrencyFluctuations()
    .sink { completion in
        // Handle completion (success or failure)
    } receiveValue: { fluctuations in
        // Handle the received currency fluctuations
    }
```



#### Model structs

The ** BTCService **class relies on the following model structs to represent data received from the API


##### Currency


```
struct Currency: Codable {
    let base: String
    let date: String
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
}
```



##### Fluctuations


```
struct Fluctuations: Codable {
    let base: String
    let end_date: String
    let fluctuation: Bool
    let rates: [String: Rate]
    let start_date: String
    let success: Bool
}
```



##### Rate


```
struct Rate: Codable {
    let change: Double
    let change_pct: Double
    let end_rate: Double
    let start_rate: Double
}
```


These model structs provide a structured representation of the currency and fluctuation data received from the API. They are used to decode the API response into Swift objects and work with the data.


## CurrencyListViewModel

The **CurrencyListViewModel **class is responsible for managing the currency rates and fluctuations for bitcoin investments. It conforms to the **ObservableObject **protocol**,** allowing it to publish changes to its properties. The class includes the following properties and initialization:


### Properties



* **btcService: **an instance of **BTCService **class that handles API requests for fetching currency rates and fluctuations.
* **currencies:  **a published property representing the currency rates. Optional value of type **Currency.**
* **fluctuations: **a published property representing the currency fluctuations. Optional value of type **Fluctuations**
* **cancellables: **a set of **AnyCancellable **objects that store the cancellable subscriptions for API requests.
* **investmentViewModel: **an instance of **InvestmentViewModel **class that manages the investment amount
* **convertedRates: **a computed property that calculates the converted rates based on the Bitcoin amount in the **InvestmentViewModel. **It returns a dictionary with currency codes as keys and their corresponding converted rates values. If **currencies **property is nil an empty dictionary is returned


### Initialization


```
init(btcService: BTCService, investmentViewModel: InvestmentViewModel)
```


 The initializer takes an instance of BTCService class and an instance of the **InvestmentViewModel **class and assigns the corresponding properties mentioned above


### Fetching Currency Rates and Fluctuations



* **fetchCurrencyRates(): **this method calls the **fetchCurrencyRates() **method of the **btcService. **It receives the response on the main dispatch queue and updates the **currencies **property. Any error will be printed to the console.
* **fetchFluctuations(): **this method calls the **FetchCurrencyFluctuations() **method of the **btcService. **It recieves the response on the main dispatch queue and updates the **fluctuations** property. Any error will be printed to the console.

*note these methods receive responses on the main thread as they are updating published properties to the view*


## CurrencyListView 

The **CurrencyListView **struct is a SwiftUI view that displays the converted currency rates and fluctuations based on the Bitcoin investment amount. It utilizes an instance of the **CurrencyViewModel **class to manage the currency rates and fluctuations. The struct includes the following properties and body:


### Properties



* **viewModel: **an observed object of type ** CurrencyListViewModel **that manages the currency rates and fluctuations
* **investmentViewModel: **an observed object if type **InvestmentViewModel **that manages the investment amount


### Body

The views body consists of a **List **that displays the investment value for each currency. Each currency is represented by an **HStack **containing an image(Currency country flag), the country code, the converted rate and the fluctuation percentage. The fluctuation percentage is displayed in green if it's positive and red if it's negative.

The view also includes an ** onAppear **modifier that triggers the **fetchCurrencyRates() **and **fetchFluctuations() **methods of the **viewModel **when the view appears


## ContentView

The **ContentView** struct is a SwiftUI view that combines the **InvestmentView** and **CurrencyListView** views. It includes two observed objects: **currencyListViewModel** of type **CurrencyListViewModel** and **investmentViewModel** of type **InvestmentViewModel**. The struct's body consists of a **VStack** that contains the following views:

**InvestmentView**: this view is initialized with the **investmentViewModel** and displays the investment amount and related information.

**CurrencyListView**: this view is initialized with the **currencyListViewModel** and **investmentViewModel** and displays the converted currency rates and fluctuations.


## BTC_TrackerAPP

The **BTC_TrackerApp** struct is the entry point of the app and adopts the **App** protocol. It includes a single scene defined by the WindowGroup type. The struct's body consists of the following:



* **btcService**: An instance of the **BTCService** class.
* **investmentViewModel**: An instance of the **InvestmentViewModel** class.
* **currencyListViewModel**: An instance of the **CurrencyListViewModel** class initialized with **btcService** and **investmentViewModel**.
* **ContentView**: The main view of the app, initialized with **currencyListViewModel** and **investmentViewModel**.


## Extra Measures needed 



1. Error handling and logging: Enhance the error handling this includes handling network errors, API request failures, and any other potential errors that can occur during runtime.
2. Security and data protection: secure storage of API keys, encryption of user data, and securing network communication.
3. Automated testing: Implement automated testing strategy to cover different aspects of the app, including unit tests, integration tests, and UI tests. 
4. Optimized build and release process: Set up a streamlined build and release process to automate the deployment of the app. (CI/CD) tools to automate building, testing, and releasing new versions of the app.

