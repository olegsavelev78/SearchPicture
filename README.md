# SearchPicture
An app that will search images on Google by the query text. 
The API that must return the result is described here: https://serpapi.com/images-results
The page must look like the page of the NavigationController where a search field must be placed on the top of the page where users can write the text for the query. The result images must be shown below the search field as a collection view.
A tap on the preview image must open an image in the full screen view with buttons “Next” and “Prev” that allow users to view previous and next images from the search result. Also, please add a button to open the original source page. Clicking on that button must open a website on Web View Controller inside the app. Users can close that Web View to return to images.
App must be made using UIKit.
API service also allows to realise pagination for loading images. Please use for the first result
limit of 20 images for the page, and then if user scrolls down and sees the last row with images,
send second API request to get next 20-40 images in results.
Also, the service allows to apply different filters for results, we could add “Tools” button where
we could select for example a type of responses (let’s keep images by default and video as an
additional type of supported media), the user could filter by the result’s size (any size (default),
large, medium, icon), filter results by country, language (multiple languages).
It will be good if the images are cached on a device.
