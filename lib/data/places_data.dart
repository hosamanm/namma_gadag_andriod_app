
class TouristPlace{
 final String name;
 final String description;
 final List<String> images;

 TouristPlace({required this.name,required this.description,required this.images});
}

List<TouristPlace> places = List.generate(13,(i){
 return TouristPlace(
   name: "Place ${i+1}",
   description: "Description for place ${i+1}",
   images: List.generate(5,(j)=>"assets/images/places/place${i+1}/photo${j+1}.jpg")
 );
});
