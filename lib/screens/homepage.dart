import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/side_drawer.dart';
import '../providers/selected_categories.dart';
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

  @override
  void initState() {
    super.initState();
  }

  void _navBarSelect(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  Widget get _bodyWidget {
    if (_selectedIndex == 0) {
      return ExploreScreen();
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

  Widget get pageTitle {
    return Consumer<SelectedCategoriesProvider>(
      builder: (_, selected, _child) {
        if (_selectedIndex == 0 && selected.categorySelected) {
          return Text(selected.lastCategoryName);
        } else {
          return Text("Hollyday Land");
        }
      },
    );
  }

  Widget get leadingButton {
    return Consumer<SelectedCategoriesProvider>(
      builder: (_, selected, _child) {
        if (_selectedIndex == 0 && selected.categorySelected) {
          return BackButton(
            onPressed: selected.unSelectCategory,
          );
        } else {
          return Container();
        }
      },
    );
  }

  /*import '../providers/selected_categories.dart';*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: pageTitle,
        leading: leadingButton,
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
