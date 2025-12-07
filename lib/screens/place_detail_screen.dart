
import 'package:flutter/material.dart';
import '../data/places_data.dart';

class PlaceDetailScreen extends StatelessWidget{
 final TouristPlace place;
 const PlaceDetailScreen({super.key, required this.place});

 @override
 Widget build(BuildContext context){
  return Scaffold(
   appBar:AppBar(title:Text(place.name)),
   body:SingleChildScrollView(
    child:Column(children:[
      Padding(
        padding:const EdgeInsets.all(12),
        child:Text(place.description),
      ),
      GridView.builder(
        shrinkWrap:true,
        physics:const NeverScrollableScrollPhysics(),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          mainAxisSpacing:8,
          crossAxisSpacing:8,
        ),
        itemCount:place.images.length,
        itemBuilder:(c,i){
          return Image.asset(place.images[i],fit:BoxFit.cover);
        },
      ),
    ]),
   ),
  );
 }
}
