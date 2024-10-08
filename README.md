<h1 align="center">
Travel Planner
</h1>
<h3 align="center">
Mobile App for iOS to plan your future trips.
</h3>
<br>

With this app, you can create markers and enter their name, description, and upload your own images. You can search for places or cities by name, or explore them on your own using the map. At any time, you can edit or delete your markers by tapping on them, whether in the **Map** or **Places to Visit** sections.


## Table of contents 
- [Used technologies and libraries](https://github.com/VrickPL/Travel-Planner/tree/main?tab=readme-ov-file#used-technologies-and-libraries)
- [Map](https://github.com/VrickPL/Travel-Planner/tree/main?tab=readme-ov-file#map)
- [Places to visit](https://github.com/VrickPL/Travel-Planner/tree/main?tab=readme-ov-file#places-to-visit)
- [Settings](https://github.com/VrickPL/Travel-Planner/tree/main?tab=readme-ov-file#settings)

## Used technologies and libraries
- **[Swift](https://www.swift.org/documentation/)**,  
- **[SwiftUI](https://developer.apple.com/tutorials/swiftui)**,
- **[SwiftData](https://developer.apple.com/documentation/swiftdata)**, 
- **[MapKit](https://developer.apple.com/documentation/mapkit/)**,
- **[TipKit](https://developer.apple.com/documentation/tipkit/)**,
- **[PhotosPicker](https://developer.apple.com/documentation/photokit/photospicker/)**

Project has been written in **MVVM** pattern.

## Map
In the **Map** section, you can explore the entire Earth! It is based on **Apple Maps**. You can search for places or cities by name, or explore them on your own. When you find something interesting, click on the **plus** icon and tap on the map to add a marker. You can then enter the name, description, and choose a photo of the place from your photo library. The name of the place will be entered automatically, but you can change it if you'd like (be careful, name cannot be empty!).
<br>
<br>
If you tap on an existing marker, you can either delete it or edit it (by tapping on the image, you'll also go to the edit screen). You can also go to the **Apple Maps** app by clicking a button.
<br>
<br>
When you enter the app for the first time, you will be asked to **share your location** to display your current position on the map. Next, you will see a **tip** that explains how to add a new marker.
<br>
<br>
If you lose orientation and are unsure where you are, don't worry! In the top right corner, you'll find a button to return to your current position.

<p align="center"> 
<img src="https://github.com/user-attachments/assets/763846ac-36c2-4aea-9378-8d936f860b9f" width="310" height="660">
<img src="https://github.com/user-attachments/assets/c4b29fb0-d03c-419b-91b4-97b596117a4d" width="310" height="660">
</p>

<p align="center"> 
<img src="https://github.com/user-attachments/assets/5236bed5-3bd9-4b38-bf5f-8e375fd9b995" width="310" height="660">
<img src="https://github.com/user-attachments/assets/25a5c626-a936-4542-95fc-01215c5a320a" width="310" height="660">
</p>


## Places to visit
Here, you will see the markers that you have added in the **Map** section. You can filter them by country, city, or leave the filters off if you'd prefer.
<br>
<br>
If you display them with a filter, you'll notice some animations when opening the list. Choose a place and click on it! You will be taken to a screen where you can edit the name, description, and change the photo. You will also see a map with the place you are currently viewing.
<br>
<br>
At the top of the screen, there is a gear-shaped icon. Clicking on it will open the **Settings** screen.
<br>
<br>
Everything is saved using **SwiftData**, so it's unlikely that you'll encounter any bugs. However, if something hasn't updated correctly, you can drag the screen down to refresh it!

<p align="center"> 
<img src="https://github.com/user-attachments/assets/ef2020f6-398e-4d6f-8759-16ecafbfc6ff" width="310" height="660">
<img src="https://github.com/user-attachments/assets/39130a79-3d02-4196-9171-91eb290b3e6d" width="310" height="660">
</p>

<p align="center"> 
<img src="https://github.com/user-attachments/assets/cce9bc09-beac-42f4-b047-de431585abd9" width="310" height="660">
<img src="https://github.com/user-attachments/assets/2cf60214-7891-4b58-8156-ab77337038b3" width="310" height="660">
</p>


<a name="settings"></a>
## Settings
In Settings you can change:  
- Language (English, Polish or auto),  
- Theme (Dark, light or auto)
  
Your choices will be saved in **AppStorage**.

In this section, you can also find my **GitHub** and **LinkedIn** profiles. 

<p align="center"> 
<img src="https://github.com/user-attachments/assets/ac274b38-f864-4406-a2b3-b1c18e74205b" width="310" height="660">
<img src="https://github.com/user-attachments/assets/9b738c31-003e-4b1d-be2d-001ef3afda55" width="310" height="660">
</p>
