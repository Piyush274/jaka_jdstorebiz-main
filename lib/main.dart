import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.notification?.title}");
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  final List<Map<String, String>> links = [
    {"title": "Rewards", "url": "https://www.jakaparts.com/pages/rewards-program"},
    {"title": "Gift Cards", "url": "https://www.jakaparts.com/products/gift-cards"},
    {"title": "My Account", "url": "https://www.jakaparts.com/account/login"},
    {"title": "Environment Care", "url": "https://dashboard.thegoodapi.com/HgIaJV7aIGcE1Ia1BmfK?source=shp"},
    {"title": "Countries We Deliver", "url": "https://www.jakaparts.com/pages/countries-we-deliver"},
    {"title": "Shipping & Return Policy", "url": "https://jdst.biz/jakashippingandreturnpolicy"},
    {"title": "Track Your Order", "url": "https://www.jakaparts.com/apps/trackingmore"},
    {"title": "About Us", "url": "https://www.jakaparts.com/pages/about-us"},
    {"title": "FAQs", "url": "https://www.jakaparts.com/pages/faqs"},
    {"title": "Contact Us", "url": "https://www.jakaparts.com/pages/contact-us"},
  ];

  // Bottom navigation URLs
  final List<String> bottomNavUrls = [
    "https://www.jakaparts.com",
    "https://www.jakaparts.com/pages/partners-program", 
    "https://www.jakaparts.com/apps/trackingmore",
    "https://www.jakaparts.com/pages/contact-us",
  ];

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _launchUrl(bottomNavUrls[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65), // Increase height
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: Color(0xFFE81524), size: 40),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            title: Image.asset('assets/logo.png', height: 175),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFE81524),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              ...links.map((link) => Column(
                children: [
                  ListTile(
                    title: Text(
                      link["title"]!,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onTap: () => _launchUrl(link["url"]!),
                  ),
                  Divider(color: Color(0xFFFF8788), thickness: 1), // Added divider
                ],
              ))
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Image.asset('assets/banner.png'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text("INDIVIDUALS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ElevatedButton(
                    onPressed: () {_launchUrl("https://jdst.biz/jakaorder");},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE81524),
                      fixedSize: Size(180, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Order Here", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Divider(thickness: 2, color: Colors.grey),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text("CORPORATE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ElevatedButton(
                    onPressed: () {_launchUrl("https://jdst.biz/jakacorporate");},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE81524),
                      fixedSize: Size(180, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Order Here", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Divider(thickness: 2, color: Colors.grey),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text("PARTNERS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {_launchUrl("https://jdst.biz/partnersregistration");},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE81524),
                          fixedSize: Size(180, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Registration"!, style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed:() {_launchUrl("https://jdst.biz/jakapartner");},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE81524),
                          fixedSize: Size(180, 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Order Here"!, style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Divider(thickness: 2, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "© 2025 JAKA. All Rights Reserved.\nA brand of JDStore Group",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
      // Add bottom navigation bar only for iOS
      bottomNavigationBar: defaultTargetPlatform == TargetPlatform.iOS 
        ? BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onBottomNavTap,
            selectedItemColor: Color(0xFFE81524),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 8,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.handshake),
                label: 'Partners',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Track Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_support),
                label: 'Contact Us',
              ),
            ],
          )
        : null,
    );
  }
}