
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
      "anonymity":anonymity,
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
  int? rating;
  int? yearsofexp;
  String? image;
  String? Qualification;
  String? Priorexp;
  int? chat;
  int? call;
  int? Earnings;
  ProfessionalModel({this.uid,this.firstname,this.email,this.phoneNumber,this.certificate,this.rating,this.image});
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
    image=map["image"];
    Qualification=map["Qualification"];
    Priorexp=map["Priorexp"];
    chat=map["chat"];
    call=map["call"];
    yearsofexp=map["yearsofexp"];
    Earnings=map["Earnings"];

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
      "rating":rating,
      "image":image,
      "Qualification":Qualification,
      "Priorexp":Priorexp,
      "chat":chat,
      "yearsofexp":yearsofexp,
      "call":call,
      "Earnings":Earnings,
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


class Music{
  String? name;
  String? musicPath;
  String? uid;
  String? MusicImage;
  int? Likes;
  int? BookMarks;
  Music({this.name,this.uid,this.musicPath,this.MusicImage,this.BookMarks,this.Likes});
  Music.fromMap(Map<String,dynamic> map){
    name=map["name"];
    musicPath = map["musicPath"];
    uid=map["uid"];
    MusicImage = map["MusicImage"];
    Likes= map["Likes"];
    BookMarks = map["BookMarks"];
  }
  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "uid":uid,
      "musicPath": musicPath,
      "MusicImage":MusicImage,
      "Likes":Likes,
      "BookMarks":BookMarks
    };

  }

}

class Posts{
  String? uid;
  String? img;
  String? uploadedby;
  String? caption;
  int? likes;
  int? bookmarks;
  Posts({this.img,this.uploadedby,this.likes,this.caption,this.uid,this.bookmarks});
  Posts.fromMap(Map<String,dynamic> map){
    img=map["img"];
    uploadedby=map["uploadedby"];
    caption=map["caption"];
    likes=map["likes"];
    uid=map["uid"];
    bookmarks=map["bookmarks"];

  }
  Map<String,dynamic> toMap(){
    return {
      "img":img,
      "uploadedby":uploadedby,
      "caption":caption,
      "likes":likes,
      "uid":uid,
      "bookmarks":bookmarks
    };
  }
}

class CommentModel{
  String? sender;
  String? timeCommented;
  String? content;
  int? likes;
  String? uid;

  CommentModel({this.likes,this.content,this.sender,this.timeCommented,this.uid});
  CommentModel.fromMap(Map<String,dynamic> map){
    sender=map["sender"];
    timeCommented=map["timeCommented"];
    content=map["content"];
    likes=map["likes"];
    uid=map["uid"];
  }
  Map<String,dynamic> toMap(){
    return {
      "sender":sender,
      "timeCommented":timeCommented,
      "likes":likes,
      "content": content,
      "uid":uid
    };
  }

}

class TaskModel{
  String? uid;
  String? description;
  String? title;
  String? Date;
  int? dura;
  int? durb;
  TaskModel(this.uid, this.description, this.title, this.dura, this.durb,this.Date);

  TaskModel.fromMap(Map<String,dynamic> map){
    uid=map["uid"];
    description=map["description"];
    title=map["title"];
    dura=map["dura"];
    Date=map["Date"];
    durb=map["durb"];
  }
  Map<String,dynamic> toMap(){
    return{
      "uid":uid,
      "description":description,
      "title":title,
      "dura":dura,
      "durb":durb,
      "Date":Date,
    };
  }
}


class Appointment{
  String? type;
  String? uid;
  String? Patient;
  String? Doctor;
  String? Timing;
  String? Day;
  bool? isbooked;
  int? charges;

  Appointment(this.uid, this.Patient, this.Doctor, this.Timing,this.Day,this.type,this.isbooked,this.charges);
  Map<String,dynamic> toMap(){
    return{
      "uid":uid,
      "Patient":Patient,
      "Doctor":Doctor,
      "Timing":Timing,
      "Day":Day,
      "type":type,
      "isbooked":isbooked,
      "charges":charges,
    };
  }
  Appointment.fromMap(Map<String,dynamic> map){
    uid=map["uid"];
    Patient=map["Patient"];
    Doctor=map["Doctor"];
    Timing=map["Timing"];
    Day=map["Day"];
    type=map["type"];
    isbooked=map["isbooked"];
    charges=map["charges"];
  }
}


class Dates{
  String? uid;
  String? Date;
  int? number1;
  int? number2;
  Dates(this.Date, this.number1, this.number2,this.uid);
  Dates.fromMap(Map<String,dynamic> map){
    uid=map["uid"];
    Date=map["Date"];
    number1=map["number1"];
    number2=map["number2"];
  }
  Map<String,dynamic> toMap(){
    return {
      "uid":uid,
      "number1":number1,
      "number2":number2,
      "Date":Date,
    };
  }
}