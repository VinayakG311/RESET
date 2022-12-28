
import 'package:cloud_firestore/cloud_firestore.dart';



class Database{
  getUserbyID(String emailid) async{
    return await FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: emailid).get();

  }
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection('Users').add(userMap);
    
  }
}

class UserModel{
  String? image;
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? DateOfBirth;
  String? Gender;
  bool? anonymity;

  UserModel({this.uid,this.firstname,this.email,this.phoneNumber});
  UserModel.fromMap(Map<String,dynamic> map){
    uid = map['uid'];
    firstname =  map['firstname'];
    lastname = map['lastname'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    DateOfBirth = map['DateofBirth'];
    Gender = map['Gender'];
    anonymity=map['anonymity'];
  }
  Map<String,dynamic> toMap(){
    return{
      "uid":uid,
      "firstname":firstname,
      "lastname":lastname,
      "email":email,
      "phoneNumber":phoneNumber,
      "DateofBirth":DateOfBirth,
      "Gender":Gender,
      "anonymity":anonymity
    };

}
}

class ChatRoomModel{
  String? chatRoomId;
  Map<String?,dynamic>? participants;
  String? lastMessage;
  ChatRoomModel({this.chatRoomId,this.participants,this.lastMessage});
  ChatRoomModel.fromMap(Map<String,dynamic> map){
    chatRoomId = map['chatRoomId'];
    participants =  map['participants'];
    lastMessage = map["lastmessage"];
  }
  Map<String,dynamic> toMap(){
    return{
      "chatRoomId":chatRoomId,
      "participants":participants,
      "lastmessage":lastMessage
    };

  }
}
class MessageModel{
  String? messageid;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;
  MessageModel({this.messageid, this.sender, this.text, this.seen, this.createdon});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map["messageid"];
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    createdon = map["createdon"].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "messageid": messageid,
      "sender": sender,
      "text": text,
      "seen": seen,
      "createdon": createdon
    };
  }
}

class ProfessionalModel{
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? DateOfBirth;
  String? Gender;
  String? certificate;
  String? rating;
  ProfessionalModel({this.uid,this.firstname,this.email,this.phoneNumber,this.certificate,this.rating});
  ProfessionalModel.fromMap(Map<String,dynamic> map){
    uid = map['uid'];
    firstname =  map['firstname'];
    lastname = map['lastname'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    DateOfBirth = map['DateofBirth'];
    Gender = map['Gender'];
    certificate= map["certificate"];
    rating = map["rating"];
  }
  Map<String,dynamic> toMap(){
    return{
      "uid":uid,
      "firstname":firstname,
      "lastname":lastname,
      "email":email,
      "phoneNumber":phoneNumber,
      "DateofBirth":DateOfBirth,
      "Gender":Gender,
      "certificate":certificate,
      "rating":rating
    };
  }

}
class JournalModel{
  String? uid;
  String? Useruid;
  String? Date;
  String? Content;
  JournalModel({this.Content,this.Date,this.Useruid,this.uid});
  JournalModel.fromMap(Map<String,dynamic> map){
    uid=map["uid"];
    Useruid=map["Useruid"];
    Date=map["Date"];
    Content=map["Content"];
  }
  Map<String,dynamic> toMap(){
    return {
      "uid":uid,
      "Useruid":Useruid,
      "Date":Date,
      "Content":Content
    };
  }
}