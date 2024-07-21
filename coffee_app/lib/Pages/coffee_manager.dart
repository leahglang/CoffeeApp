// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'dart:io';

// class CoffeeManager extends StatefulWidget {
//   @override
//   _CoffeeManagerState createState() => _CoffeeManagerState();
// }

// class _CoffeeManagerState extends State<CoffeeManager> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   File? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _addCoffee() async {
//     if (_nameController.text.isEmpty || _priceController.text.isEmpty || _image == null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
//       return;
//     }

//     final name = _nameController.text;
//     final price = double.tryParse(_priceController.text) ?? 0.0;

//     // Upload image to Firebase Storage and get the URL
//     // TODO: Add image upload logic here

//     // Update Firestore
//     await FirebaseFirestore.instance.collection('Coffees').add({
//       'name': name,
//       'price': price,
//       'imagePath': 'your_image_url', // Replace with the actual image URL
//     });

//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coffee added successfully')));
//     setState(() {
//       _nameController.clear();
//       _priceController.clear();
//       _image = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Coffee Manager')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Coffee Name'),
//             ),
//             TextField(
//               controller: _priceController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Price'),
//             ),
//             SizedBox(height: 10),
//             _image == null
//                 ? Text('No image selected.')
//                 : Image.file(_image!, height: 150),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addCoffee,
//               child: Text('Add Coffee'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
