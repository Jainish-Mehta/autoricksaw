import 'package:autoricksaw/app_drawer.dart';
import 'package:flutter/material.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  CustomerHomePageState createState() => CustomerHomePageState();
}

class CustomerHomePageState extends State<CustomerHomePage> {
  void _onPopInvoked(bool didPop) async {
    if (!didPop) {
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App?'),
          content: const Text('Do you really want to close the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Exit'),
            ),
          ],
        ),
      );

      if (mounted && (shouldExit ?? false)) {
        Navigator.of(context).maybePop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        drawer: AppDrawer(userType: 'Customer', userName: 'Customer Name'),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.deepPurple),
          title: const Text(
            'Customer Home Page',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        /* bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          unselectedLabelStyle: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),*/
        backgroundColor: const Color.fromARGB(255, 220, 181, 250),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Location',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.deepPurpleAccent]),
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/Map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Destination',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      Colors.deepPurpleAccent,
                      Colors.deepPurple,
                    ], radius: 2),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
