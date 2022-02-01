
class Food_Category {
  final String _category;
  const Food_Category(
    this._category,
  );
  // const Food_Category._internal(this._category);

  factory Food_Category.fromString(String category){
    return Food_Category(category);
  }


  @override
  String toString() {
    return _category;
  }
  static const Burger = const Food_Category('Burger');
  static const Pizza = const Food_Category('Pizza');
  static const Fries = const Food_Category('Fries');
  static const Pasta = const Food_Category('Pasta');
  static const Vegan = const Food_Category('Vegan');

}
