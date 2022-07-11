// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:m_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filter-screen";

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen({required this.saveFilters, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters["gluten"] as bool;
    _lactoseFree = widget.currentFilters["lactose"] as bool;
    _vegetarian = widget.currentFilters["vegetarian"] as bool;
    _vegan = widget.currentFilters["vegan"] as bool;

    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    void Function(bool) updateValue,
  ) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    "gluten": _glutenFree,
                    "lactose": _lactoseFree,
                    "vegetarian": _vegetarian,
                    "vegan": _vegan,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text("Adjust your meal selection",
                  style: Theme.of(context).textTheme.titleMedium)),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  "Gluten-free", "Only include gluten free meals", _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile("Lactose-free",
                  "Only include Lactose free meals", _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  "Vegetarian", "Only include Vegetarian meals", _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTile("Vegan", "Only include Vegan meals", _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              })
            ],
          ))
        ]));
  }
}
