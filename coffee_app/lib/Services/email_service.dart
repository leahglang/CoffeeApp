import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/Model/coffee.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

final smtpServer = gmail("michal84446@gmail.com", "rshs hwmj obfo ystv");

Future<void> sendEmail(String email, String subject, String body) async {
  final message = Message()
    ..from = Address('michal84446@gmail.com', 'CoffeeApp')
    ..recipients.add(email)
    ..subject = subject
    ..text = body;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n' + e.toString());
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }catch (e) {
    print('Unexpected error: $e');
  }
}

Future<void> sendVerificationCode(String email, String code) async {
  await sendEmail(email, 'Verification Code', 'Your verification code is: $code');
}

Future<void> sendOrderDetails(String email, String orderDetails, String total) async {
  await sendEmail(email, 'Your Order Details', 'Order Details:\n$orderDetails\n\nTotal: \$$total');
}

class MailService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(Users user) async {
    try {
      await _firestore.collection('Users').doc(user.uid).set(user.toMap());
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}
