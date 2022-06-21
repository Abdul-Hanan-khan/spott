import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDatabase {
  String usersCollection = 'users';

  void changeState(String userId, int userState) {
    print("Firefun called => ${userState}");
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(userId)
          .set({
        'userState': userState,
        'isNewMessage': value.get('isNewMessage') ?? 0
      }).whenComplete((){
        print("Updated");
      });
    });
  }

  Future<void> setNotificationBubble(String receiverId, int isNewMessage)async {
    print("New message set   ${isNewMessage}");
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(receiverId)
        .update({'userState': 0, 'isNewMessage': isNewMessage});
  }
}
