import 'package:equatable/equatable.dart';

class Ingridient extends Equatable{
  final String name;
  final String size;
  final String imagePath;
  Ingridient({
    required this.name,
    required this.size,
    required this.imagePath,
  });

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }

  // Map<String,dynamic> toMap(){
  //   return {
  //     'name' : name,
  //     'size' : size
  //   };
  // }

  @override
  // TODO: implement props
  List<Object?> get props => [name,size];
}
