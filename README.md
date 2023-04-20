# Currency conversion app for personal use.
- From the beginning, I've been treating this app as a practice playground. I've tried lots of things along with the main features I wanted to implement. Outside additional improvements and some main features, I don't intend to update the app.

# Features
- API Call - JSON
- MVVM
- Picker
- User Data 
- Charts
- NavigationView


![Screenshot 2023-04-13 at 20 05 43](https://user-images.githubusercontent.com/119931873/231872100-d29b80c9-64df-4aae-9079-5137941a95b4.jpg)

- Figma Design of the proposed end product.

As of 18/04/2023, here's what I call, the Alpha phase.


![CurrencyView1](https://user-images.githubusercontent.com/119931873/232620424-b8f14662-7291-4b6e-82d3-d934489eb2f1.png)


Here are some of the missing features: 
- Can't change 2nd, 3rd, or 4th currency. Can't change their values either.
- The API is rather limited in terms of currencies. Can easily upgrade to the 'premium' version which even has crypto. The project uses FreecurrencyAPI.
- Default currencies don't save to user preferences.
- Currency change 'triangles' don't do anything. The main currency can be changed by clicking the text below the main currency amount.
- No other themes yet.
- Network calls made to the API are only made once per hour. This is actually a feature. More frequent refreshes can be made into a premium feature.

![Picker](https://user-images.githubusercontent.com/119931873/232621278-463495ec-79d0-48f4-bc8a-44954784cc5f.png)

![AccountViewSS](https://user-images.githubusercontent.com/119931873/232621351-a3b0d17a-9685-42e6-8ffa-a46a8673b32d.png)

- Added Basic Graph with 30-day history. Currencies cannot be changed as of now.

![CurrencyViewGraph](https://user-images.githubusercontent.com/119931873/233222777-0cb7571d-d633-4e6d-965c-16de46e319c5.png)
