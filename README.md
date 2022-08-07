# iOS Development - SimpleApp
As an avid fan of the famous animation show Rick and Morty, I have developed this iOS application to display the information of the characters that appeared on the show. This application presents basic information of the character such as, name, status, origin, and the location where the character was last seen on the map along with the image of each character. To show appreciation to the incredible producers of Rick and Morty and to exhibit a demonstration of my learning curve in iOS development, I have made this application using the programming language Swift, the IDE Xcode, and an integration of the Firestore Cloud storage.
In general, the application has 2 views: Character List and Character Card.

![SimpleApp Gif](https://drive.google.com/uc?export=view&id=12BtniESaCZ5jJmYSbRsyMXPk0Xg0KqcF)

![SimpleApp](https://i.imgur.com/WhbfoL4.png)
![SimpleApp](https://i.imgur.com/2Q7OxVc.png)

## List

![SimpleApp](https://i.imgur.com/JxyHoVT.png)

The list of characters display Rick and Morty characters with each row showing the name, status, species and origin of the respective character as well as an image of them. 
### API
The characters in the list were retrieved using Rick and Morty API. 
### Search

 ![SimpleApp](https://i.imgur.com/VM0OzKy.png)
 
The search feature of this application allows users to search for characters based on their name.
## Card

 ![SimpleApp](https://i.imgur.com/Nr0ex1F.png)
 
When clicking on a character on the list, users will be redirected to the information view of that character. In this view, the character’s image is shown on the top and the detailed information of that character is also presented.
### Note

 ![SimpleApp](https://i.imgur.com/YijGrBX.png)
 
Users can add notes to characters by inputting in the Note text area. The note is saved on the cloud storage of Firestore so that it can be fetched, update and delete as they wish.
### Map

 ![SimpleApp](https://i.imgur.com/P4B13WL.png)
 
The Map View in the character card shows where the character is currently on the map. A marker is pinned on the map so that users can easily locate the chosen character.
# Features
### Main features
•	A List View showing summary information of the characters.
o	Display name of the characters.
o	Display image of the characters.
•	Detailed View of each character.
o	Display name, address, description of the characters.
o	Extra information: a map showing the current location of the character.
•	An app icon.
•	Built using Swift framework.
### Extra features
•	Fetch data from the [Rick and Morty API].
•	Search characters by name using array filter and a “search text” state variable.
•	Dark-themed UI.
•	Save note to cloud storage.
•	Map with marker and title for better display of the characters’ current location.

[//]: #

   [Rick and Morty API]: <https://rickandmortyapi.com/>
