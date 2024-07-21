import 'package:coffe_app/Components/my_button.dart';
import 'package:coffe_app/Model/coffee.dart';
import 'package:coffe_app/Model/coffee_shope.dart';
import 'package:coffe_app/Pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../const.dart';

class CartPage extends StatefulWidget {
  // final Coffee coffee;
  // CartPage({required this.coffee});

  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<CoffeeShope>(
        builder: (context, coffeeShope, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: coffeeShope.userCart.length,
                  itemBuilder: (context, index) {
                    var coffee = coffeeShope.userCart[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListTile(
                        leading: Image.asset(coffee.imagePath,
                            width: 50, height: 50),
                        title: Text(
                          coffee.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'Quantity: ${coffee.quantity}\nTotal: \$${(coffee.price * coffee.quantity).toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.brown,
                          ),
                          onPressed: () {
                            coffeeShope.removeItemFromCart(coffee);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row(
                        //       children: [
                        //         IconButton(
                        //           icon: Icon(Icons.remove, color: Colors.brown),
                        //           onPressed: () {
                        //             coffeeShope.decreaseQuantity(widget.coffee);
                        //           },
                        //         ),
                        //         Text('Quantity: ${widget.coffee.quantity}'),
                        //         IconButton(
                        //           icon: Icon(Icons.add, color: Colors.brown),
                        //           onPressed: () {
                        //             coffeeShope.increaseQuantity(widget.coffee);
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        Text(
                          'Total Quantity:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${coffeeShope.userCart.fold<int>(0, (previousValue, coffee) => previousValue + coffee.quantity)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${coffeeShope.userCart.fold<double>(0.0, (previousValue, coffee) => previousValue + (coffee.price * coffee.quantity)).toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MyButton(
                      onTap: coffeeShope.userCart.isNotEmpty
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentPage()),
                          );
                        } : null,
                      text: 'Pay now',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
