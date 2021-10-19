import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hollyday_land/category_page.dart';
import 'package:hollyday_land/models/category.dart';
import './explore.dart';
import './profile.dart';
import './map.dart';
import './favorites.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>['email'],
);

/// This is the stateless widget that the main application instantiates.
class MyHomepageWidget extends StatefulWidget {
  const MyHomepageWidget({Key? key}) : super(key: key);

  @override
  _MyHomepageWidgetState createState() => _MyHomepageWidgetState();
}

class _MyHomepageWidgetState extends State<MyHomepageWidget> {
  int _selectedIndex = 0;
  GoogleSignInAccount? _currentUser;
  late Future<List<RootCategory>> rootCategories;
  Category? category;

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });

    rootCategories = Category.fetchRootCategories();

    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void _navBarSelect(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  void _selectCategory(Category category) {
    setState(() {
      this.category = category;
    });
  }

  void _unselectCategory() {
    setState(() {
      this.category = null;
    });
  }

  Widget get _bodyWidget {
    if (_selectedIndex == 0) {
      if (category == null) {
        return Explore(
          rootCategories: rootCategories,
          selectCategory: _selectCategory,
        );
      } else {
        return CategoryPage(
          category: category!,
          unselectCategory: _unselectCategory,
        );
      }
    } else if (_selectedIndex == 1) {
      return FavoritesWidget(
        currentUser: _currentUser,
        loginFunction: _handleSignIn,
      );
    } else if (_selectedIndex == 2) {
      return MapWidget();
    } else if (_selectedIndex == 3) {
      return const Center(
        child: Text(
          'Some other page',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else if (_selectedIndex == 4) {
      return ProfilePage(
        currentUser: _currentUser,
        loginFunction: _handleSignIn,
        logoutFunction: _handleSignOut,
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Regions'),
              ),
              ListTile(
                title: const Text('North'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Center'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Jerusalem Area'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('South'),
                onTap: () {},
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: const Text('Attractions'),
              ),
              ListTile(
                title: const Text('Offroad Trip'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Self-picking Harvest'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Zoo'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Water Sports'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Cycling'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Trails'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Wineries'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Museumes'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Hollyday Land'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
      ),
      body: _bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _navBarSelect,
      ),
    );
  }
}
