import 'package:coffe_app/Components/coffee_tile.dart';
import 'package:coffe_app/Model/coffee.dart';
import 'package:coffe_app/Model/coffee_shope.dart';
import 'package:coffe_app/Pages/coffee_order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  void goToCoffeePage(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeOrderPage(coffee: coffee),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Consumer<CoffeeShope>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'How do you like your coffee?',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: value.coffeeShope.length,
              itemBuilder: (context, index) {
                Coffee eachCoffee = value.coffeeShope[index];
                return CoffeeTile(
                  coffee: eachCoffee,
                  onPressed: () => goToCoffeePage(eachCoffee),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
