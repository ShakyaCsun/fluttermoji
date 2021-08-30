import 'package:flutter/foundation.dart';

/// Maps attribute keys to the attribute value list
final Map<String, FluttermojiPropertyItem> fluttermojiProperties = {
  "style": FluttermojiPropertyItem(title: "Style", property: fluttermojiStyle),
  "topType": FluttermojiPropertyItem(title: "Hair", property: topType),
  "accessoriesType":
      FluttermojiPropertyItem(title: "Accessory", property: accessoriesType),
  "hairColor":
      FluttermojiPropertyItem(title: "Hair\nColor", property: hairColor),
  "facialHairType":
      FluttermojiPropertyItem(title: "Facial\nHair", property: facialHairType),
  "facialHairColor": FluttermojiPropertyItem(
    title: "F-Hair\nColor",
    property: facialHairColor,
  ),
  "clotheType": FluttermojiPropertyItem(title: "Outfit", property: clotheType),
  "clotheColor":
      FluttermojiPropertyItem(title: "Outfit\nColor", property: clotheColor),
  "eyeType": FluttermojiPropertyItem(title: "Eye", property: eyeType),
  "eyebrowType":
      FluttermojiPropertyItem(title: "Eyebrow", property: eyebrowType),
  "mouthType": FluttermojiPropertyItem(title: "Mouth", property: mouthType),
  "skinColor": FluttermojiPropertyItem(title: "Skin", property: skinColor),
};

class ExpandedFluttermojiCardItem {
  String title;
  String? key;
  String? iconAsset;
  double iconsize;
  ExpandedFluttermojiCardItem({
    this.iconsize = 0,
    this.title = "Unnamed",
    this.key,
    this.iconAsset,
  });
}

class FluttermojiPropertyItem extends ChangeNotifier {
  String title;
  int choice;
  List<String>? property;
  FluttermojiPropertyItem({
    this.title = "Unnamed",
    this.choice = 0,
    this.property,
  });
}

const String emptySVGIcon = '''
<svg xmlns="http://www.w3.org/2000/svg"  viewBox="-20 -20 80 80" width="80px" height="80px"><path fill="#dff0fe" stroke="#4788c7" stroke-miterlimit="10" d="M20,1C9.507,1,1,9.507,1,20s8.507,19,19,19s19-8.507,19-19 S30.493,1,20,1z M6,20c0-7.732,6.268-14,14-14c2.963,0,5.706,0.926,7.968,2.496L8.496,27.968C6.926,25.706,6,22.963,6,20z M20,34 c-2.963,0-5.706-0.926-7.968-2.496l19.472-19.472C33.074,14.294,34,17.037,34,20C34,27.732,27.732,34,20,34z"/></svg>
''';

const Map<String, int> defaultFluttermojiOptions = {
  'topType': 24,
  'accessoriesType': 0,
  'hairColor': 1,
  'facialHairType': 0,
  'facialHairColor': 1,
  'clotheType': 4,
  'eyeType': 6,
  'eyebrowType': 10,
  'mouthType': 8,
  'skinColor': 3,
  'clotheColor': 8,
  'style': 0,
  'graphicType': 0
};

const List<String> fluttermojiStyle = [
  'Transparent',
  'Circle',
];

const List<String> topType = [
  'Bald',
  'Eyepatch',
  'Hijab',
  'Turban',
  'Hat',
  "I'm not bald",
  'Flat',
  'from School',
  'Short n waved',
  'Short n curly',
  'The caesar',
  'Another caeser',
  'Short w/ dreads',
  'Short w/ lots of dreads',
  'Bob cut',
  'Bun',
  'Fro',
  'Its not short',
  'Long (Female)',
  'Curvy',
  'Shaggy',
  'Short w/ frizzle',
  'LongHairStraight',
  'LongHairStraight2',
  'LongHairStraightStrand',
  'Curly (Female)',
  'Long w/ dreads',
  'Frida',
  'Fro w/ band',
  'Long w/ shaved sides',
  'Mia Wallace',
  'WinterHat1',
  'WinterHat2',
  'Santa Hat',
  'Santa Hat w/ ears',
];

const List<String> accessoriesType = [
  'Nothing',
  'PrescriptionGlasses',
  'Another pair of prescriptions',
  'Round',
  'Sunglasses',
  'Wayfarers',
  'Kurt',
];

const List<String> hairColor = [
  'Auburn',
  'Black',
  'Brown',
  'Blonde',
  'BlondeGolden',
  'BrownDark',
  'PastelPink',
  'Platinum',
  'Red',
  'SilverGray',
];

//This is the property I skipped on purpose
const List<String> hatColor = [
  'Black',
  'Blue01',
  'Blue02',
  'Blue03',
  'Gray01',
  'Gray02',
  'Heather',
  'PastelBlue',
  'PastelGreen',
  'PastelOrange',
  'PastelRed',
  'PastelYellow',
  'Pink',
  'Red',
  'White',
];

const List<String> facialHairType = [
  'Nothing',
  'Full Beard',
  'Beard, Light',
  'Moustache, Fancy',
  "That 80's moustache",
];

const List<String> facialHairColor = [
  'Auburn',
  'Black',
  'Blonde',
  'BlondeGolden',
  'Brown',
  'BrownDark',
  'Platinum',
  'Red',
];

const List<String> clotheType = [
  'Crew Neck Tee',
  'GraphicShirt',
  'Scoop-neck Tee',
  'ShirtVNeck',
  'Hoodie',
  'CollarSweater',
  'Overall',
  'Blazer + T-Shirt',
  'BlazerSweater',
];

const List<String> clotheColor = [
  'Blue01',
  'Blue02',
  'PastelYellow',
  'PastelGreen',
  'Gray02',
  'Black',
  'Blue03',
  'Gray01',
  'Heather',
  'PastelBlue',
  'PastelOrange',
  'PastelRed',
  'Pink',
  'Red',
  'White',
];

//Not implemented
const List<String> graphicType = [
  'Cumbia',
  'Hola',
  'Bat',
  'Deer',
  'Diamond',
  'Pizza',
  'Resist',
  'Selena',
  'Bear',
  'SkullOutline',
  'Skull',
];

const List<String> eyeType = [
  'Default',
  'Happy',
  'Squint',
  'Close',
  'Cry',
  'Dizzy',
  'EyeRoll',
  'Hearts',
  'Side',
  'Surprised',
  'Wink',
  'WinkWacky',
];

const List<String> eyebrowType = [
  'Default',
  'FlatNatural',
  'Angry',
  'AngryNatural',
  'DefaultNatural',
  'RaisedExcited',
  'RaisedExcitedNatural',
  'SadConcerned',
  'SadConcernedNatural',
  'UnibrowNatural',
  'UpDown',
  'UpDownNatural',
];

const List<String> mouthType = [
  'Concerned',
  'Default',
  'Sad',
  'Disbelief',
  'Eating',
  'Grimace',
  'ScreamOpen',
  'Serious',
  'Smile',
  'Tongue',
  'Twinkle',
  'Vomit',
];

const List<String> skinColor = [
  'White',
  'Peach',
  'Black',
  'Brown',
  'DarkBrown',
  'Yellow',
  'Tanned',
];
