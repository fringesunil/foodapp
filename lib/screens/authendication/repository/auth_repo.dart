import 'package:firebase_database/firebase_database.dart';

class AuthRepository {
  DatabaseReference ref = FirebaseDatabase.instance.ref('user');
  Future<void> addCustomerDetails(Map data) async {
    await ref.child(data["user_id"]).set(data);
  }
}
