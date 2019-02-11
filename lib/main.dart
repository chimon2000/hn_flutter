import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hn_flutter/pages/stories.dart';

void main() {
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(title: 'Top Stories'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<Widget> _children = [
    Stories(storyType: 'new'),
    Stories(storyType: 'newest'),
    Stories(storyType: 'show'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
      ),
      body: Stories(storyType: 'new'), // new

//      bottomNavigationBar: new BottomNav(
//        onChange: (int selectedIndex) {
//          setState(() {
//            _currentPageIndex = selectedIndex;
//          });
//        },
//      ),
    );
  }
}

class BottomNav extends StatefulWidget {
  final void Function(int selectedIndex) onChange;

  const BottomNav({
    Key key,
    this.onChange,
  }) : super(key: key);

  @override
  BottomNavState createState() {
    return new BottomNavState();
  }
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Top')),
        BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('New')),
        BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('Show')),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onChange != null) {
      widget.onChange(index);
    }
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
