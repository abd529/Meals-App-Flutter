// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:m_app/models/meal.dart';

import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favorites;
  TabsScreen(this.favorites);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<dynamic, dynamic>> _pages;

  @override
  initState() {
    [
      _pages = [
        {"page": CategoriesScreen(), "title": "Categories"},
        {"page": FavoritesScreen(widget.favorites), "title": "Your Favorites"}
      ]
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        _pages[_selectedPageIndex]["title"],
      )),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: "Favorites",
          )
        ],
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
