import 'package:coffe_app/Model/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeShope extends ChangeNotifier{
  final List<Coffee> _shope = [
    Coffee(
      name: 'Long black',
      price: 4.00,
      imagePath: "lib/images/black.png",
    ),
    Coffee(
      name: 'Latte',
      price: 4.00,
      imagePath: "lib/images/latte.png",
    ),
    Coffee(
      name: 'Espresso',
      price: 4.40,
      imagePath: "lib/images/espresso.png",
    ),
    Coffee(
      name: 'Iced coffee',
      price: 4.00,
      imagePath: "lib/images/iced_coffee.png",
    )
  ];

  List<Coffee> get coffeeShope => _shope;

  List<Coffee> _userCart = [];

  List<Coffee> get userCart => _userCart;

  void addItemToCart(Coffee coffee, int quantity) {
    var existingCoffee = _userCart.firstWhere(
      (item) => item.name == coffee.name,
      orElse: () => Coffee(name: '', price: 0, imagePath: ''),
    );

    if (existingCoffee.name != '') {
      existingCoffee.quantity += quantity;
    } else {
      coffee.quantity = quantity;
      _userCart.add(coffee);
    }
    notifyListeners();
  }

  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }

  void clearCart() {
    _userCart.clear();
    notifyListeners();
  }

  // void increaseQuantity(Coffee coffee) {
  //   coffee.quantity++;
  //   notifyListeners();
  // }

  // void decreaseQuantity(Coffee coffee) {
  //   if (coffee.quantity > 1) {
  //     coffee.quantity--;
  //   } else {
  //     removeItemFromCart(coffee);
  //   }
  //   notifyListeners();
  // }
}