// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:m_app/models/meal.dart';
import 'package:m_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  MealItem({
    required this.id,
    required this.title,
    required this.affordability,
    required this.complexity,
    required this.duration,
    required this.imageUrl,
  });

  String get complexityText {
    if (complexity == Complexity.Simple) {
      return "Simple";
    }
    if (complexity == Complexity.Challenging) {
      return "Challenging";
    }
    if (complexity == Complexity.Hard) {
      return "Hard";
    }
    return "unknown";
  }

  String get affordabilityText {
    if (affordability == Affordability.Affordable) {
      return "Affordable";
    }
    if (affordability == Affordability.Pricey) {
      return "Pricey";
    }
    if (affordability == Affordability.Luxurious) {
      return "Expensive";
    }
    return "unknown";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MealDetailScreen.routeName, arguments: id)
            .then((value) {
          if (value != null) {
            // removeItem(value);
          }
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(imageUrl,
                    height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(children: [
                    Icon(Icons.schedule),
                    SizedBox(width: 6),
                    Text(duration.toString() + "min")
                  ]),
                  Row(children: [
                    Icon(Icons.work),
                    SizedBox(width: 6),
                    Text(complexityText)
                  ]),
                  Row(children: [
                    Icon(Icons.attach_money),
                    SizedBox(width: 5),
                    Text(affordabilityText)
                  ]),
                ]),
          )
        ]),
      ),
    );
  }
}
