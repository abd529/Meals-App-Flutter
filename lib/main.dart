// ignore_for_file: prefer_const_constructors, unused_import, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:m_app/dummy_data.dart';
import 'package:m_app/screens/categories_screen.dart';
import 'package:m_app/screens/filters_screen.dart';
import 'package:m_app/screens/meal_detail_screen.dart';
import 'package:m_app/screens/tabs_screen.dart';

import 'models/meal.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

List<Meal> _availableMeals = DUMMY_MEALS;
List<Meal> _favoriteMeals = [];

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegetarian"] == true && !meal.isVegetarian) {
          return false;
        }
        if (_filters["vegan"] == true && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daily Meals",
      theme: ThemeData(
        primaryColor: Colors.pink,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.pink, secondary: Colors.amber),
        fontFamily: "Raleway",
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "RobotoCondensed",
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontFamily: "Raleway",
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(saveFilters: _setFilters, currentFilters: _filters),
      },
    );
  }
}
