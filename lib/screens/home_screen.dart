
import 'package:flutter/material.dart';
import '../localization/app_text.dart';
import '../localization/language_controller.dart';
import '../data/places_data.dart';
import 'place_detail_screen.dart';

class HomeScreen extends StatefulWidget{
 const HomeScreen({super.key});
 @override State<HomeScreen> createState()=>_HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
 @override
 Widget build(BuildContext context){
  return Scaffold(
   appBar:AppBar(title:Text(AppText.title())),
   drawer:Drawer(
    child:ListView(children:[
      DrawerHeader(child:Text(AppText.title())),
      ListTile(title:Text(AppText.login())),
      ListTile(title:Text(AppText.profile())),
      ListTile(
        title:Text(AppText.changeLang()),
        onTap:(){
          setState(()=>LanguageController.isKannada=!LanguageController.isKannada);
          Navigator.pop(context);
        },
      ),
    ]),
   ),
   body:ListView.builder(
     itemCount:places.length,
     itemBuilder:(c,i){
       final p=places[i];
       return ListTile(
         title:Text(p.name),
         subtitle:Text(p.description),
         trailing:const Icon(Icons.arrow_forward),
         onTap:(){
           Navigator.push(c,MaterialPageRoute(builder:(_)=>PlaceDetailScreen(place:p)));
         },
       );
     },
   ),
  );
 }
}
