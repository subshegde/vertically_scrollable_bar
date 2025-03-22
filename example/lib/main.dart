import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vertically_scrollable_bar/vertically_scrollable_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: VehicleMainPage(),
    );
  }
}

class VehicleMainPage extends StatefulWidget {
  const VehicleMainPage({super.key});

  @override
  State<VehicleMainPage> createState() => _VehicleMainPageState();
}

class _VehicleMainPageState extends State<VehicleMainPage> {
  int selectedPage = 0;
  List<IconData> icons = [
    Iconsax.home1,
    Iconsax.search_normal,
    Icons.confirmation_number_outlined,
    Icons.bookmark_outline,
    Icons.person_outline,
  ];

  @override  
  void initState(){
    super.initState();
    addOptions();
  }

  List<Map<String, dynamic>> options = [];

  int _selectedIndex = 0;

void addOptions() {
  options = [
    {'label': 'All', 'image': Icons.home},
    {'label': 'Two Wheeler (Bike)', 'image': Icons.directions_bike},
    {'label': 'Two Wheeler (Scooty)', 'image': Icons.motorcycle},
    {'label': 'Electric', 'image': Icons.bolt},
    {'label': 'Four Wheeler (Car)', 'image': Icons.directions_car},
    {'label': 'Four Wheeler (Open Jeep)', 'image': Icons.directions_car},
    {'label': 'Four Wheeler (Jeep)', 'image': Icons.directions_car},
    {'label': 'Man cycle', 'image': Icons.directions_bike},
    {'label': 'Ladybird', 'image': Icons.directions_bike},
  ];
  setState(() {});
}
  Map<int, String> typeMap = {
    0: '',
    1: 'two-wheeler-bike',
    2: 'two-wheeler-scooty',
    3: 'electric',
    4: 'car',
    5: 'openjeep',
    6: 'jeep',
    7: 'mancycle',
    8: 'ladybird',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            // Left Sidebar with vertical scroll
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: VerticallyScrollableBar(
                options: options,
                selectedIndex: _selectedIndex,
                onSelect: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                menuBackgroundColor: Colors.grey[100],
                selectedItemBackgroundColor: Colors.grey[700],
                unselectedItemBackgroundColor: Colors.white,
                selectedItemTextColor: Colors.white,
                unselectedItemTextColor: Colors.black,
                selectedItemIconColor: Colors.white,
                unselectedItemIconColor: Colors.grey,
                itemHeight: 80,
                itemWidth: 100,
                navbarHeight: 35,
                imageType: 'icon',
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Selected Index: $_selectedIndex',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
