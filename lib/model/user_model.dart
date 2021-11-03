import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  //used to return an object
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // convert data attributes inside this class into a map (key, value pair) or dictionary form
  Map<String, dynamic> toMap() {
    return ({
      'uid': this.uid,
      'email': this.email,
      'password': this.password,
      'firstName': this.firstName,
      'lastName': this.lastName,
    });
  }

  // Future<void> addUserToFirestore() {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return users.add({
  //     'firstName': this.firstName,
  //     'lastName': this.lastName,
  //     'email': this.email,
  //     'password': this.password,
  //   });
  // }
  
}
