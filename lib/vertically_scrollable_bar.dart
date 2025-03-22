import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A customizable vertically scrollable navigation bar or menu widget.
/// Allows selection from a list of items with customizable icons, text, colors, and gradients.
///
/// [VerticallyScrollableBar] provides a vertical scrollable bar for navigation with a
/// variety of customization options such as gradient backgrounds, icons, and text styles.
/// It can display menu items with different types of images: icon, asset, network, file, memory, or SVG.
class VerticallyScrollableBar extends StatelessWidget {
  /// List of menu options represented as [Map] containing labels and images.
  ///
  /// The list should contain maps where each map has a 'label' (string) for the item
  /// and an 'image' (dynamic) which can be an icon, asset, network URL, file path, etc.
  final List<Map<String, dynamic>> options;

  /// Callback triggered when an item is selected.
  ///
  /// This is called with the index of the selected item.
  final ValueChanged<int> onSelect;

  /// The index of the currently selected menu item.
  ///
  /// Used to highlight the currently active menu item.
  final int selectedIndex;

  /// Background color or gradient for the menu.
  ///
  /// Can be a [Color] or a [LinearGradient].
  final dynamic menuBackgroundColor;

  /// Background color for the selected menu item.
  ///
  /// Can be a [Color] or [LinearGradient].
  final dynamic selectedItemBackgroundColor;

  /// Background color for unselected menu items.
  ///
  /// Can be a [Color] or [LinearGradient].
  final dynamic unselectedItemBackgroundColor;

  /// Text color for the selected item.
  final Color? selectedItemTextColor;

  /// Text color for the unselected item.
  final Color? unselectedItemTextColor;

  /// Icon color for the selected item.
  final Color? selectedItemIconColor;

  /// Icon color for the unselected item.
  final Color? unselectedItemIconColor;

  /// Color for the circular progress indicator while loading network images.
  final Color? circularProgressIndicatorColor;

  /// Height of each menu item.
  final double itemHeight;

  /// Width of each menu item.
  final double itemWidth;

  /// The type of image to display (icon, asset, network, etc.).
  ///
  /// Specifies the source of the image (e.g., 'icon', 'asset', 'network', 'file', 'memory', 'svg').
  final String imageType;

  /// Creates a [VerticallyScrollableBar] widget.
  const VerticallyScrollableBar({
    Key? key,
    required this.options,
    required this.onSelect,
    required this.selectedIndex,
    this.menuBackgroundColor = Colors.grey,
    this.selectedItemBackgroundColor = Colors.blue,
    this.unselectedItemBackgroundColor = Colors.white,
    this.selectedItemTextColor = Colors.white,
    this.unselectedItemTextColor = Colors.black,
    this.selectedItemIconColor = Colors.white,
    this.unselectedItemIconColor = Colors.grey,
    this.circularProgressIndicatorColor = Colors.grey,
    this.itemHeight = 80.0,
    this.itemWidth = 70.0,
    required this.imageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen height to calculate available space for the scrollable bar
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double availableHeight = screenHeight - statusBarHeight;

    return SingleChildScrollView(
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          gradient: _getGradient(menuBackgroundColor), // Apply gradient if available
          color: _getColor(menuBackgroundColor), // Apply color if available
        ),
        child: Column(
          children: List.generate(options.length, (index) {
            return _buildMenuItem(
              options[index]['label'],
              options[index]['image'],
              index,
            );
          }),
        ),
      ),
    );
  }

  /// Builds a single menu item in the scrollable bar.
  ///
  /// The menu item includes an image and label, and changes its appearance when selected.
  /// It calls the [onSelect] callback when tapped.
  Widget _buildMenuItem(String label, dynamic image, int index) {
    bool isSelected = index == selectedIndex; // Check if this item is selected

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          onSelect(index); // Notify the parent widget that an item was selected
        },
        child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: BoxDecoration(
            gradient: _getGradient(isSelected ? selectedItemBackgroundColor : unselectedItemBackgroundColor), // Apply gradient if available
            color: _getColor(isSelected ? selectedItemBackgroundColor : unselectedItemBackgroundColor), // Solid color if available
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getImageWidget(image, isSelected), // Display the image/icon for this item
              const SizedBox(height: 8), // Spacer between the image and label
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? selectedItemTextColor
                      : unselectedItemTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Retrieves the appropriate image widget for the menu item based on the [imageType].
  ///
  /// This method handles different image sources like 'icon', 'asset', 'network', etc.
  /// It also handles loading and error cases for images.
  Widget _getImageWidget(dynamic image, bool isSelected) {
    try {
      switch (imageType) {
        case 'icon':
          return Icon(
            image,
            color: isSelected
                ? selectedItemIconColor
                : unselectedItemIconColor,
            size: 20,
          );
        case 'asset':
          return image == null || image.isEmpty
              ? _getFallbackImage(isSelected)
              : Image.asset(
                  image,
                  width: 24,
                  height: 24,
                  color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
                );
        case 'network':
          return image == null || image.isEmpty
              ? _getFallbackImage(isSelected)
              : Image.network(
                  image,
                  width: 24,
                  height: 24,
                  color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return CircularProgressIndicator(color: circularProgressIndicatorColor,);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _getFallbackImage(isSelected);
                  },
                );
        case 'file':
          return image == null || !File(image).existsSync()
              ? _getFallbackImage(isSelected)
              : Image.file(
                  File(image),
                  width: 24,
                  height: 24,
                  color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
                );
        case 'memory':
          return image == null || (image is Uint8List && image.isEmpty)
              ? _getFallbackImage(isSelected)
              : Image.memory(
                  image,
                  width: 24,
                  height: 24,
                  color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
                );
        case 'svg':
          return image == null || image.isEmpty
              ? _getFallbackImage(isSelected)
              : SvgPicture.asset(
                  image,
                  width: 24,
                  height: 24,
                  color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
                );
        default:
          return _getFallbackImage(isSelected);
      }
    } catch (e) {
      return _getFallbackImage(isSelected); // If error, show fallback icon
    }
  }

  /// Provides a fallback image when the provided image is not valid or is missing.
  ///
  /// This icon is used when the provided image cannot be loaded or is empty.
  Widget _getFallbackImage(bool isSelected) {
    return Icon(
      Icons.error_outline,
      color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
      size: 24,
    );
  }

  /// Retrieves the gradient if the input is a valid gradient.
  ///
  /// Returns a [LinearGradient] if the input is a valid gradient; otherwise, returns null.
  LinearGradient? _getGradient(dynamic input) {
    if (input is LinearGradient) {
      return input;
    }
    return null; // Return null if input is not a gradient
  }

  /// Retrieves the color if the input is a valid color.
  ///
  /// Returns a [Color] if the input is a valid color; otherwise, returns null.
  Color? _getColor(dynamic input) {
    if (input is Color) {
      return input;
    }
    return null; // Return null if input is not a color
  }
}
