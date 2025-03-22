import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerticallyScrollableBar extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final ValueChanged<int> onSelect;
  final int selectedIndex;

  // Customizable parameters for dynamic customization
  final Color? menuBackgroundColor;
  final Color? selectedItemBackgroundColor;
  final Color? unselectedItemBackgroundColor;
  final Color? selectedItemTextColor;
  final Color? unselectedItemTextColor;
  final Color? selectedItemIconColor;
  final Color? unselectedItemIconColor;
  final Color? circularProgressIndicatorColor;
  final double itemHeight;
  final double itemWidth;
  final double navbarHeight;

  final String imageType;

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
    this.navbarHeight = 45.0,
    required this.imageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top + navbarHeight;
    double availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Container(
      width: itemWidth,
      height: availableHeight,
      color: menuBackgroundColor ?? Colors.grey[100],
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: options.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(
            options[index]['label'],
            options[index]['image'],
            index,
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(String label, dynamic image, int index) {
    bool isSelected = index == selectedIndex;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
      child: GestureDetector(
        onTap: () {
          onSelect(index);
        },
        child: Container(
          width: itemWidth,
          height: itemHeight,
          decoration: BoxDecoration(
            color: isSelected
                ? selectedItemBackgroundColor
                : unselectedItemBackgroundColor,
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
              _getImageWidget(image, isSelected),
              const SizedBox(height: 8),
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
      return _getFallbackImage(isSelected);
    }
  }

  Widget _getFallbackImage(bool isSelected) {
    return Icon(
      Icons.error_outline,
      color: isSelected ? selectedItemIconColor : unselectedItemIconColor,
      size: 24,
    );
  }
}
