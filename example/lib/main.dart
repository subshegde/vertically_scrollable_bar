import 'package:flutter/material.dart';
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
      title: 'Vertically Scrollable Bar Demo',
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
  List<Map<String, dynamic>> options = [];
  int _selectedIndex = 0;
  int _selectedIndexBottomNav = 0;

  @override
  void initState() {
    super.initState();
    addOptions();
  }

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
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndexBottomNav = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('VerticallyScrollableBar'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndexBottomNav,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: 
              // VerticallyScrollableBar(
              //   options: options,
              //   selectedIndex: _selectedIndex,
              //   onSelect: (index) {
              //     setState(() {
              //       _selectedIndex = index;
              //     });
              //   },
              //   menuBackgroundColor: Colors.white,
              //   selectedItemBackgroundColor: Colors.teal[400],
              //   unselectedItemBackgroundColor: Colors.white,
              //   selectedItemTextColor: Colors.white,
              //   unselectedItemTextColor: Colors.blueGrey[700],
              //   selectedItemIconColor: Colors.white,
              //   unselectedItemIconColor: Colors.teal[400],
              //   itemHeight: 80,
              //   itemWidth: 100,
              //   imageType: 'icon',
              // ),
              // LinearGradient example

              VerticallyScrollableBar(
                options: options,
                selectedIndex: _selectedIndex,
                onSelect: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                menuBackgroundColor: LinearGradient(
                  colors: [Colors.black, Colors.grey[800]!, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                selectedItemBackgroundColor: LinearGradient(
                  colors: [Colors.grey[600]!, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                unselectedItemBackgroundColor: LinearGradient(
                  colors: [Colors.grey[300]!, Colors.grey[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                selectedItemTextColor: Colors.white,
                unselectedItemTextColor: Colors.black54,
                selectedItemIconColor: Colors.white,
                unselectedItemIconColor: Colors.black45,
                itemHeight: 80,
                itemWidth: 100,
                imageType: 'icon',
              )
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
