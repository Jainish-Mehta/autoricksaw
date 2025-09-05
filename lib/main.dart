import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp()); //const is used bcoz we don't need to recreate widget or constructor every time 
}

/* Statelesswidget data inside them are immutable.
   Statefullwidget data inside them are mutable.
   InheritedWidget
   */
  
class MyApp extends StatelessWidget{
  const MyApp(
    {
      super.key
    }
  );
  @override
  Widget build(BuildContext context) {
    return const Text(
    'Hello world',textDirection: TextDirection.ltr,
    );
  }
}