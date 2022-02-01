import 'package:food_order_app/features/foods/domain/enitity/ingridient.dart';




class IngridientModel extends Ingridient {
  final String name ;
  final String size;
  late String imagePath;

  
  

  IngridientModel({
    required this.name,
    required this.size,
    required this.imagePath
  }
  ) : super(name: name,size: size,imagePath: imagePath);
  


  factory IngridientModel.fromMap(Map<String,dynamic> dataMap){
    final image = setImagePath(dataMap['name']);
    return IngridientModel(name: dataMap['name'], size: dataMap['size'], imagePath: image);
  }

  

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'size' : size,
    };
  }

  

}

const  CHEESE_IMAGE_PATH = 'CHEESE';

String setImagePath(String name) {
  var image = '';
    switch(name){
      case 'Cheese':
      image = CHEESE_IMAGE_PATH;
      break;
      default:
      image = 'Not Found';
      
    }
    return image;
  }
