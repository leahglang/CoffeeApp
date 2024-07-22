// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:coffe_app/Services/email_service.dart';
// import 'package:coffe_app/Pages/intro_screen.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool isPhoneSelected = true;
//   final TextEditingController _phoneEmailController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   bool _isCodeSent = false;
//   String verificationId = '';
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[100],
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset("lib/images/latte.png", height: 100),
//               SizedBox(height: 20),
//               Text(
//                 'Welcome!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.brown[800],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Enter your phone number or email to log in.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.brown[800]),
//               ),
//               SizedBox(height: 20),
//               ToggleButtons(
//                 borderColor: Colors.grey,
//                 fillColor: Colors.brown[100],
//                 borderWidth: 2,
//                 selectedBorderColor: Colors.brown,
//                 selectedColor: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text('Phone'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text('Email'),
//                   ),
//                 ],
//                 onPressed: (int index) {
//                   setState(() {
//                     isPhoneSelected = index == 0;
//                     _isCodeSent = false; // Reset code sent status when switching input types
//                   });
//                 },
//                 isSelected: [isPhoneSelected, !isPhoneSelected],
//               ),
//               SizedBox(height: 20),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: TextField(
//                   controller: _phoneEmailController,
//                   keyboardType: isPhoneSelected
//                       ? TextInputType.phone
//                       : TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: isPhoneSelected ? 'Phone number' : 'Email',
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.brown),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _sendVerificationCode,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.brown,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text('Send verification code'),
//               ),
//               if (_isCodeSent) ...[
//                 SizedBox(height: 20),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: _codeController,
//                     decoration: InputDecoration(
//                       labelText: 'Verification code',
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.brown),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _verifyCode,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.brown,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text('Verify code'),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _sendVerificationCode() async {
//     String input = _phoneEmailController.text.trim();

//     if (isPhoneSelected) {
//       // Phone authentication
//       await _auth.verifyPhoneNumber(
//         phoneNumber: input,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           // Handle user signed in
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print('Verification failed: ${e.message}');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           // Save verificationId for later use
//           print('Code sent: $verificationId');
//           setState(() {
//             this.verificationId = verificationId;
//             _isCodeSent = true;
//           });
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } else {
//       // Email authentication
//       String verificationCode = generateVerificationCode();
//       await sendVerificationCode(input, verificationCode);
//       setState(() {
//         this.verificationId = verificationCode;
//         _isCodeSent = true;
//       });
//     }
//   }

//   void _verifyCode() async {
//     String code = _codeController.text.trim();
//     if (isPhoneSelected) {
//       // Phone verification
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: code,
//       );
//       try {
//         await _auth.signInWithCredential(credential);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => IntroScreen()),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Invalid verification code')),
//         );
//       }
//     } else {
//       // Email verification
//       if (code == verificationId) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => IntroScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Invalid verification code')),
//         );
//       }
//     }
//   }

//   String generateVerificationCode() {
//     final random = Random();
//     return List.generate(6, (_) => random.nextInt(10).toString()).join();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffe_app/Pages/intro_screen.dart';
import 'package:coffe_app/Services/email_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPhoneSelected = true;
  final TextEditingController _phoneEmailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isCodeSent = false;
  String verificationId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("lib/images/latte.png", height: 100),
              SizedBox(height: 20),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your phone number or email to log in.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown[800]),
              ),
              SizedBox(height: 20),
              ToggleButtons(
                borderColor: Colors.grey,
                fillColor: Colors.brown[100],
                borderWidth: 2,
                selectedBorderColor: Colors.brown,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Phone'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Email'),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    isPhoneSelected = index == 0;
                    _isCodeSent = false; // Reset code sent status when switching input types
                  });
                },
                isSelected: [isPhoneSelected, !isPhoneSelected],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _phoneEmailController,
                  keyboardType: isPhoneSelected
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: isPhoneSelected ? 'Phone number' : 'Email',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _sendVerificationCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Send verification code'),
              ),
              if (_isCodeSent) ...[
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText: 'Verification code',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Verify code'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _sendVerificationCode() async {
    String input = _phoneEmailController.text.trim();

    if (isPhoneSelected) {
      // Phone authentication
      await _auth.verifyPhoneNumber(
        phoneNumber: input,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          await _createUserInFirestore(); // Add this line to create user in Firestore
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntroScreen()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save verificationId for later use
          print('Code sent: $verificationId');
          setState(() {
            this.verificationId = verificationId;
            _isCodeSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      // Email authentication
      String verificationCode = generateVerificationCode();
      await sendVerificationCode(input, verificationCode);
      setState(() {
        this.verificationId = verificationCode;
        _isCodeSent = true;
      });
    }
  }

  void _verifyCode() async {
    String code = _codeController.text.trim();
    if (isPhoneSelected) {
      // Phone verification
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      try {
        await _auth.signInWithCredential(credential);
        await _createUserInFirestore(); // Add this line to create user in Firestore
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid verification code')),
        );
      }
    } else {
      // Email verification
      if (code == verificationId) {
        await _createUserInFirestore(); // Add this line to create user in Firestore
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid verification code')),
        );
      }
    }
  }

  Future<void> _createUserInFirestore() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('Users').doc(user.uid).set({
          'uid': user.uid,
          'phone': isPhoneSelected ? _phoneEmailController.text.trim() : null,
          'email': isPhoneSelected ? null : _phoneEmailController.text.trim(),
        });
        print("User document created in Firestore.");
      } catch (e) {
        print("Error creating user document: $e");
      }
    }
  }

  String generateVerificationCode() {
    final random = Random();
    return List.generate(6, (_) => random.nextInt(10).toString()).join();
  }
}


