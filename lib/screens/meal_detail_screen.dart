// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:m_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail-screen";

  final Function toggleFunction;
  final Function isMealFavorite;
  MealDetailScreen(this.toggleFunction, this.isMealFavorite);

  Widget BuildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget BuildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 200,
        width: 350,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        selectedMeal.title,
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl),
            ),
            BuildSectionTitle(context, "Ingredients"),
            BuildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  )),
              itemCount: selectedMeal.ingredients.length,
            )),
            BuildSectionTitle(context, "Steps"),
            BuildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text((index + 1).toString(),
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      selectedMeal.steps[index],
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFunction(mealId),
        child: Icon(isMealFavorite(mealId) ? Icons.star : Icons.star_border,
            color: Colors.black),
      ),
    );
  }
}
