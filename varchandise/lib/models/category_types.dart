import 'cart_models.dart';

List<Categ> categoryList = [
  Categ(categTitle: "All", category: Category.none, isSelected: true),
  Categ(categTitle: "Anime", category: Category.anime, isSelected: false),
  Categ(categTitle: "Disney", category: Category.disney, isSelected: false),
  Categ(
      categTitle: "SuperHero", category: Category.superhero, isSelected: false),
];

class Categ {
  Categ(
      {required this.categTitle,
      required this.category,
      required this.isSelected});
  String categTitle;
  Category category;
  bool isSelected;
}
