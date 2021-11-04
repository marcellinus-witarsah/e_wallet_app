import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? phoneNumber;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  //used to return an object
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // convert data attributes inside this class into a map (key, value pair) or dictionary form
  Map<String, dynamic> toMap() {
    return ({
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
      'phoneNumber': this.phoneNumber,
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
