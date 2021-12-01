import 'package:flutter/material.dart';
import 'package:sebiomo/another.dart';
import 'package:sebiomo/home.dart';
import 'package:sebiomo/test.dart';
import 'package:sebiomo/add_card.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: Home(),
    routes:{
      '/':(BuildContext context)=> Home(),
      '/add_card' :(BuildContext context)=> addCard(),
      },
  ),
);

