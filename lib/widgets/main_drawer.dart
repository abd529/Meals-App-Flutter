// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:m_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
      BuildContext context, String title, IconData icon, String root) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(root);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          color: Theme.of(context).colorScheme.secondary,
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            "Cooking Up!",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 20),
        buildListTile(context, "Meals", Icons.restaurant, "/"),
        buildListTile(
            context, "Filters", Icons.settings, FiltersScreen.routeName),
      ]),
    );
  }
}
