import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category{
  final int id;
  final String name;
  final dynamic icon;
  const Category(this.id, this.name, {this.icon});

}

final List<Category> categories = [
  const Category(9,"General Knowledge", icon: FontAwesomeIcons.earthAsia),
  const Category(10,"Books", icon: FontAwesomeIcons.bookOpen),
  const Category(11,"Film", icon: FontAwesomeIcons.video),
  const Category(12,"Music", icon: FontAwesomeIcons.music),
  const Category(13,"Musicals & Theatres", icon: FontAwesomeIcons.masksTheater),
  const Category(14,"Television", icon: FontAwesomeIcons.tv),
  const Category(15,"Video Games", icon: FontAwesomeIcons.gamepad),
  const Category(16,"Board Games", icon: FontAwesomeIcons.chessBoard),
  const Category(17,"Science & Nature", icon: FontAwesomeIcons.microscope),
  const Category(18,"Computer", icon: FontAwesomeIcons.laptopCode),
  const Category(19,"Maths", icon: FontAwesomeIcons.arrowDown19),
  const Category(20,"Mythology", icon: FontAwesomeIcons.anchor),
  const Category(21,"Sports", icon: FontAwesomeIcons.football),
  const Category(22,"Geography", icon: FontAwesomeIcons.mountain),
  const Category(23,"History", icon: FontAwesomeIcons.monument),
  const Category(24,"Politics", icon: FontAwesomeIcons.solidChessKing),
  const Category(25,"Art", icon: FontAwesomeIcons.paintbrush),
  const Category(26,"Celebrities", icon: FontAwesomeIcons.personDress),
  const Category(27,"Animals", icon: FontAwesomeIcons.dog),
  const Category(28,"Vehicles", icon: FontAwesomeIcons.carRear),
  const Category(29,"Comics", icon: FontAwesomeIcons.book),
  const Category(30,"Gadgets", icon: FontAwesomeIcons.mobileScreenButton),
  const Category(31,"Japanese Anime & Manga", icon: FontAwesomeIcons.bookOpenReader),
  const Category(32,"Cartoon & Animation", icon: FontAwesomeIcons.gun),
];