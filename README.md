# Photo Album

Swift MVVM with Coordinator

## Design Pattern

- I have used MVVM design pattern becuase it seprates UI from logic, seperate unit tests are easier and code is event driven. Coordinator Pattern is used to segregate and manage UI routing independently. 

## Dependcies

- No external Library is used.

## Project Structure

- Project is divided into respective folders as the folder name describes.
- Features Folder has UIs: Photos & Albums. Each of the has its own Model, View and View Model folders.
- There are commons and helper folder which have global app constans and common utility functions.
- Netwok Folder has API Service. Basic networking is implemented which can be improved based on needs. 

## Logic

- All views are added programmatically using autolayouts constraints, there is no storyborad or xib.
- There base classes for view controller, tablle view and collection view.
- Image View is extended to handle download and cache image from URL. It also checks for displaying correct image for given URL in case of collection view and table view to avoid flickering.
- Data is fetched from API service assuming URL is valid. In case of invalid URL error is shown. 
- Simple Loader is shown.
- View Model handles all the logic and notifies the view controller whenever data is fetched successfully or if there is an error. 
- Photos view shows single line title on top of image.
- Albums and Photo Detail UIs can be improved if there is more data like albums with album thumbnail and photo detail with description and tags.

## Testing 

- I have included basic unit and UI tests as well. Tests are divided into respective folder structure.

