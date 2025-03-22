# Vertically Scrollable Bar

![vsb1](https://github.com/user-attachments/assets/90c42538-1d3d-4725-af11-a0fe623df517)

![verticallyScrollableBar2](https://github.com/user-attachments/assets/35e0d973-f9e2-4aea-bbc4-594147089044)

https://github.com/user-attachments/assets/9df477b4-f3c6-49bd-a7ac-a07a1a5f4122

**Overview**: 
  - The `VerticallyScrollableBar` is a customizable widget in Flutter designed to provide a vertical scrollable navigation bar or menu. It can be used for side menus or navigation bars in applications where users can select from a list of options. This widget allows customization of colors, gradients, item backgrounds, text, icons, and more, making it suitable for various UI themes. The widget supports dynamic selection of menu items with user interaction, making it ideal for apps that require a highly customizable vertical navigation component.

**Key Features :**

*Customizable Appearance :*
-  Supports both solid colors and gradients for the background of the menu and items.
- Allows customization of item text color, icon color, and background color for both selected and unselected items.

*Flexible Image Handling :*
- Supports different image types for menu items, such as icons, asset images, network images, file images, memory images, and SVG assets.
- Provides a fallback image (icon) when the provided image is unavailable or invalid.

*Vertical Scrollable Menu :*
- The widget is placed in a `SingleChildScrollView`, making it scrollable vertically if there are many items in the menu.
- It dynamically adjusts to the height and screen size of the device, ensuring that the layout remains responsive.

*User Interaction :*
- The widget highlights the selected item through visual feedback (change in background color, text color, and icon color).
- Allows users to tap on an item, triggering the `onSelect` callback to update the selected index.

*Customizable Item Dimensions :*
- Allows specification of item height and width for fine-tuning the layout and visual consistency across various screen sizes.

*Gradient and Solid Color Support :*
- Provides support for gradients for both the menu background and item backgrounds, allowing users to create visually rich designs.
- Also supports solid colors for simplicity.

*Efficient Error Handling :*
- When images are not available (e.g., from assets or network), the widget falls back to a default icon, ensuring smooth user experience even if the images are missing.

*Text Styling :*
- Each item in the menu has customizable text styles such as font size, font weight, and color, allowing complete control over the visual appearance of item labels.

*Progress Indicators :*
- For network images, a circular progress indicator is shown while the image is loading, keeping users informed of the load status.

## About The Project

This project is a Flutter-based component created to provide a vertical navigation bar or menu with high customization. It allows developers to quickly add a scrollable side menu in their apps with options like gradient backgrounds, customizable icons, text, and colors.

The component is designed with flexibility in mind, offering different ways to represent menu items (e.g., icons, asset images, and network images). The widget is particularly useful in apps that need sidebars or menus with custom themes, responsive design, and smooth user interactions. It allows users to define gradients or colors for various states (selected and unselected) and ensures a seamless user experience by handling errors gracefully (e.g., missing images).

The widget’s ease of use, combined with its customization capabilities, makes it a perfect fit for modern mobile apps, including social media, e-commerce, and productivity applications.

## Getting Started

To use the `vertically_scrollable_bar` package in your Flutter project, follow these steps:

### Prerequisites
Ensure you have the following installed on your system:
* [Flutter](https://flutter.dev/docs/get-started/install)
* [Dart](https://dart.dev/get-dart)

### Installation
1. Add the package dependency in your `pubspec.yaml` file:
    ```yaml
    dependencies:
      vertically_scrollable_bar:
    ```

2. Install the dependencies by running the following command:
    ```bash
    flutter pub get
    ```

3. Import the package into your Dart file:
    ```dart
    import 'package:vertically_scrollable_bar/vertically_scrollable_bar.dart';
    ```

## Usage

Here’s how to integrate the `VerticallyScrollableBar` widget into your Flutter app:

## Demo Video
[![YouTube](https://img.shields.io/badge/-YouTube-black.svg?style=for-the-badge&logo=youtube&colorB=555)](https://youtu.be/zq360cc8-iw?si=eqDI1ETAqtO07qer)


```dart
VerticallyScrollableBar(
                  options: options,
                  selectedIndex: _selectedIndex,
                  onSelect: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  menuBackgroundColor: Colors.blue[50],
                  selectedItemBackgroundColor: Colors.teal[400],
                  unselectedItemBackgroundColor: Colors.white,
                  selectedItemTextColor: Colors.white,
                  unselectedItemTextColor: Colors.blueGrey[700],
                  selectedItemIconColor: Colors.white,
                  unselectedItemIconColor: Colors.teal[400],
                  itemHeight: 80,
                  itemWidth: 100,
                  imageType: 'icon',
                ),
```
## 🚀 About Me
I'm Subrahmanya S. Hegde, a mobile app developer with expertise in Flutter and React Native, passionate about building high-performance, cross-platform applications. With skills in Kotlin, Node.js, Firebase, and Supabase, I create end-to-end solutions that deliver seamless user experiences.

I hold an MCA degree from MIT Manipal and have a strong passion for exploring new technologies. I am also a strong advocate of using Git and GitHub for version control and collaboration.

Let’s build something great together! 
#### Happy Coding!


## Authors

- [@subshegde](https://www.github.com/subshegde)


## Feedback

If you have any feedback, please reach out to us at subrahmanya460@gmail.com

#### My Github
[![GitHub](https://img.shields.io/badge/-GitHub-black.svg?style=for-the-badge&logo=github&colorB=000000&colorA=333333)](https://github.com/subshegde)
