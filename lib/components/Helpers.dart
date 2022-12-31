
import 'package:reset/Models/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper{
  static Future<UserModel?> GetUserModelById(String uid ) async{
    UserModel? user;
    DocumentSnapshot docsnap=await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if(docsnap.data()!=null){
      user = UserModel.fromMap(docsnap.data() as Map<String,dynamic>);
    }
    return user;
  }
}
class FirebaseHelperPro{
  static Future<ProfessionalModel?> GetUserModelById(String uid ) async{
    ProfessionalModel? user;
    DocumentSnapshot docsnap=await FirebaseFirestore.instance.collection('Professional').doc(uid).get();
    if(docsnap.data()!=null){
      user = ProfessionalModel.fromMap(docsnap.data() as Map<String,dynamic>);
    }
    return user;
  }
}