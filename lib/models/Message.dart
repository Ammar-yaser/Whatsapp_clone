import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String message;
  String sentby;
  Timestamp time;
  Message({
    this.message,
    this.sentby,
    this.time,
  });

  factory Message.fromJson(Map<String, dynamic> data) {
    return Message(
      message: data['message'],
      sentby: data['sentby'],
      time: data['time']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message' : message,
      'sentby' : sentby,
      'time' : time
    };
  }

}
