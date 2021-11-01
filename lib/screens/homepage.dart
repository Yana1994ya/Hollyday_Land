import 'package:flutter/material.dart';
import 'package:hollyday_land/widgets/background.dart';

import '../models/category.dart';
import '../widgets/side_drawer.dart';
import 'category.dart';
import 'explore.dart';
import 'favorites.dart';
import 'history.dart';
import 'map.dart';
import 'profile.dart';

/// This is the stateless widget that the main application instantiates.
class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int _selectedIndex = 0;
  Category? category;

  @override
  void initState() {
    super.initState();
  }

  void _navBarSelect(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  void _selectCategory(Category category) {
    setState(() {
      this.category = category;
      this._selectedIndex = 0;
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
        return ExploreScreen(
          selectCategory: _selectCategory,
        );
      } else {
        return CategoryScreen(
          category: category!,
          unselectCategory: _unselectCategory,
        );
      }
    } else if (_selectedIndex == 1) {
      return const FavoritesScreen();
    } else if (_selectedIndex == 2) {
      return MapScreen();
    } else if (_selectedIndex == 3) {
      return const HistoryScreen();
    } else if (_selectedIndex == 4) {
      return const ProfileScreen();
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(
        selectCategory: _selectCategory,
      ),
      appBar: AppBar(
        title: const Text(
          'Hollyday Land',
        ),
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
        unselectedItemColor: Theme.of(context).colorScheme.primary,
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
