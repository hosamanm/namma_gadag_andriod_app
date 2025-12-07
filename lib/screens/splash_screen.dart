
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget{
 const SplashScreen({super.key});
 @override State<SplashScreen> createState()=>_SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
 late AnimationController _controller;
 final player = AudioPlayer();

 @override
 void initState(){
  super.initState();
  _controller=AnimationController(vsync:this,duration:const Duration(seconds:2))..forward();
  player.play(AssetSource("audio/splash_music.mp3"));
  Timer(const Duration(seconds:4),(){
    Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const HomeScreen()));
  });
 }

 @override
 Widget build(BuildContext context){
  return Scaffold(
   body:Stack(
    fit:StackFit.expand,
    children:[
      Image.asset("assets/images/splash_gadag.jpg",fit:BoxFit.cover),
      Container(color:Colors.black45),
      FadeTransition(
       opacity:_controller,
       child:const Center(
        child:Text(
          "Discover Gadag Tourist Places",
          style:TextStyle(color:Colors.white,fontSize:28,fontWeight:FontWeight.bold),
          textAlign:TextAlign.center,
        ),
       ),
      ),
    ],
   ),
  );
 }
}
