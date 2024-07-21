class Coffee {
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  Coffee({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}

class Users {
  String uid; 
  String email; 
  bool hasManager; 

  // בנאי למחלקה
  Users({
    required this.uid,
    required this.email,
    this.hasManager = false, 
  });

  // המרת המשתמש למפת נתונים
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email, 
      'hasManager': hasManager, 
    };
  }

  // המרת מפת נתונים לאובייקט משתמש
  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'], 
      email: map['email'], 
      hasManager: map['hasManager'] ?? false, 
    );
  }
}