// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, use_key_in_widget_constructors, avoid_print, prefer_const_constructors_in_immutables, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:m_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/categories-meals-screen";
  final List<Meal> availableMeals;
  CategoryMealsScreen({required this.availableMeals});
  @override
  State<CategoryMealsScreen> createState() =>
      _CategoryMealsScreenState(availableMeals: availableMeals);
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  final List<Meal> availableMeals;
  _CategoryMealsScreenState({required this.availableMeals});
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedinitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedinitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs["id"] as String;
      categoryTitle = routeArgs["title"] as String;
      displayedMeals = availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedinitData = false;
    }
    super.didChangeDependencies();
  }

  // void _removeItem(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: displayedMeals.isEmpty
          ? Center(child: Text("No meals for this category"))
          : Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MealItem(
                    id: displayedMeals[index].id,
                    title: displayedMeals[index].title,
                    affordability: displayedMeals[index].affordability,
                    complexity: displayedMeals[index].complexity,
                    duration: displayedMeals[index].duration,
                    imageUrl: displayedMeals[index].imageUrl,
                  );
                },
                itemCount: displayedMeals.length,
              ),
            ),
    );
  }
}
