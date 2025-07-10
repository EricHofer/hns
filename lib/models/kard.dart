import 'package:flutter/material.dart';

class Kard {
  // attributes
  final int idKard;
  final String nmKard;
  final String txDesc;
  final String txRule;
  final TyKard tyKard;

  const Kard(this.idKard, this.tyKard, this.nmKard, this.txDesc, this.txRule);
}

enum TyKard { curse, bonus, powerup, notset }

enum TySituation { drawn, inhand }

class CardSchema {
  final TyKard tyKard;
  final int count;
  final String name;
  final String? desc;
  final String? rule;
  final String? extra;

  const CardSchema(this.tyKard, this.count, this.name, [this.desc, this.rule, this.extra]);
}

// Schema (definitions) for the cards to build
final List<CardSchema> cardSchemas = [
  CardSchema(TyKard.bonus, 25, "Red", "2m, 3m, 5m", "every little helps"),
  CardSchema(TyKard.bonus, 15, "Orange", "4m, 6m, 10m", "longer than shorter"),
  CardSchema(TyKard.bonus, 10, "Yellow", "6m, 9m, 15m", "okay dokey"),
  CardSchema(TyKard.bonus, 3, "Green", "8m, 12m, 20m", "something"),
  CardSchema(TyKard.bonus, 2, "Blue", "12m, 18m, 30m", "whatever"),
  CardSchema(TyKard.powerup, 4, "Randomize", "I guess do random things!"),
  CardSchema(TyKard.powerup, 4, "Veto", "Don't do it!"),
  CardSchema(TyKard.powerup, 2, "Duplicate", "That means make a copy."),
  CardSchema(TyKard.powerup, 1, "Move", "Move"),
  CardSchema(TyKard.powerup, 4, "Discard 1, Draw 2", "as it says on the tin!"),
  CardSchema(TyKard.powerup, 4, "Discard 2, Draw 3", "you have to do this for yourself"),
  CardSchema(TyKard.powerup, 2, "Draw 1, Expand 1", "up to you at the moment"),
  CardSchema(
    TyKard.curse,
    1,
    "The Zoologist",
    "A photo of an animal",
    "Take a photo of a wild fish bird mammal reptile or amphibian or bug. The seeker must take a picture of a wild animal in the same tyKard before asking another question",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Unguided Tourist",
    "Seeker must be outside",
    "Send the seekers an unzoomed google Street View image from a street within 500 feet of where they are now. The shot has to be parallel to the horizon and include at least one human-built structure other than a road. Without using the internet for research, they must find what you sent them in real life before they can use transportation or ask another question. They must send a picture the hider for verification",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Endless Tumble",
    "Roll a die. If it's 5 or 6 this card has no effect",
    "Seekers Must roll a die at least 100 feet and have it land on a 5 or a 6 before they can ask another question. The die must roll the full distance, unaided, using only the momentum from the initial throw and gravity to travel the 100 feet. If the seekers accidentally hit someone with a die you are awarded a [S10, M20, L30] minute bonus",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Hidden Hangman",
    "Discard 2 cards",
    "Before asking another question or boarding another form of transportation, seekers must be the hider in game of hamna.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Overflowing Chalice",
    "Discard a card",
    "For the next three questions, you may draw (not keep) an additional card when drawing from the hider deck",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Mediocre Travel Agent",
    "",
    "Choose any publicly-accessible place within [S0.25, M0.25, L0.50] miles of the seekers current location. They cannot currently be on transit. They must go there, and spend at least S5 M5 L10 minutes there, before asking another question. They must send you at least three photos of them enjoying their vacation, and procure an object to bring you as souvenir. If this souvenir is lost before they can get to you, you are awarded an extra [S30, M45, L60] minutes.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Luxury Car",
    "A photo of a car",
    "Take a photo of a car. The seekers must take a photo of a more expensive car before asking another question.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The U-Turn",
    "Seekers must be heading the wrong way.",
    "If their next station is further from you than they are to theirs, Seekers must disembark their current mode of transportation at the next station (as long as that station is served by another form of transit in the next [S0.5, M0.5, L1] Hours)",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Bridge Troll",
    "Seekers Must be at least [S1, M5, L30] miles from you",
    "The seekers must ask their next question from under a bridge",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "Water Weight",
    "Seekers must be within 1,000ft (300 meters) of a body of water",
    "The seekers must acquire and carry at least 2 liters of liquid per seeker for the rest of your run. They cannot ask another question until they have acquired the liquid. The water may be distributed between seekers as they see fit. If the liquid is lost or abandoned at any point the hider is awarded a [S30, M30, L60] minute bonus",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Jammed Door",
    "Discard 2 cards",
    "For the next [S0.5, M1, L3] hours, whenever the seekers want to pass through a doorway into a building, business or train or other vehicle they must first roll 2 dice. If they do not roll a 7 or higher they cannot enter that space (including through other doorways) any given doorway can be reattempted after [S5, M10, L15] minutes",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Cairn",
    "Build a rock tower",
    "You have one attempt to stack as many rocks on top of each other as you can in a freestanding tower. Each rock may only touch one other rock. Once you have added a rock to the tower it may not be removed. Before adding another rock, the tower must stand for at least 5 seconds. If at any point any rock other than the base rock touches the ground, your tower has fallen. Once your tower falls tell the seekers how many rocks high your tower was when it last stood for five seconds. The seekers must then construct a rock tower of the same number of rocks, under the same parameters before asking another question. If their tower falls they must restart. The rocks must be found in nature and both teams must disperse the rocks after building.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Urban Explorer",
    "Discard 2 cards",
    "For the rest of the run seekers cannot ask questions when they are on transit or in a train station",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Impressionable Consumer",
    "The seekers next question is free",
    "Seekers must enter and gain admission (if applicable) to a location or buy a product that they saw an advertisement for before asking another question. This advertisement must be found out in the world and must be at least 100 feet from the product or location itself.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Egg Partner",
    "Discard two cards",
    "The seekers must acquire an egg before asking another question. This egg is now treated as an official team member of the seekers. If any team members are abandoned or killed (defined as crack in the egg's case) before the end of your run you are awarded an extra [S30 M45 L60] minutes. This course cannot be played during the endgame.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Distant Cuisine",
    "You must be at the restaurant",
    "Find a restaurant within your zone that explicitly serves food from a specific foreign country. The seekers must visit a restaurant serving food from a country that is equal or greater distance away before asking another question",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Right Turn",
    "Discard a card",
    "For the next [S20 M40 L6] minutes the seekers can only turn right at any street intersection. If at any point they find themselves in dead end where they cannot continue forward or turn right for another 1,000 feet they must do a full 180. A right turn is defined as a road at any angle that veers to the right of the seekers",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Labyrinth",
    "Draw a maze",
    "Spend up to [S10 M20 L30] minutes drawing a solvable maze and send a photo of it to the seekers. You cannot use the internet to research maze designs. The seekers must solve the maze before asking another question.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Bird Guide",
    "Film a bird",
    "You have one chance to film a bird for as long as possible. Up to [S5 M10 L15] minutes straight., if at any point the bird leaves the game your timer is stopped. The seekers must then film a bird for the same amount of time or longer",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "Spotty Memory",
    "Discard a time bonus card",
    "For the rest of the run, one random tyKard of questions will be disabled at all times. After this curse is played seeker must roll a die to determine the tyKard of questions to be disabled. The tyKard remains disabled until the next question is asked at which point a die is rolled again to choose a new tyKard. The same tyKard can be disabled multiple times in a row",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Lemon Phylactery",
    "Discard a powerup card",
    "Before asking another question the seekers must each find a lemon and affix it to their outermost layer of their clothes or skin. If at any point one of these lemons is no longer touching a seeker you are awarded [S30 M45 L60] minutes. This curse cannot be played during the endgame",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Drained Brain",
    "Discard your hand",
    "Choose three questions in different categories. The seekers cannot ask those questions for the rest of the run",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Ransom Note",
    "Spell out 'Ransom Note' as a ransom note",
    "The next question that the seekers ask must be composed of words and letters cut out of any printed material. The question must be coherent and include at least 5 words.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Gambler's Feet",
    "Roll a die if its even number this curse has no effect",
    "For the next [S20 M40 L60] minutes seekers must roll a die before they take any steps in any direction, they may take that many steps before rolling again",
  ),
];

List<Kard> populateKardDeck() {
  final List<Kard> lsTemp = [];
  int ct = 0;
  for (final CardSchema vSchema in cardSchemas) {
    for (int i = 0; i < vSchema.count; i++) {
      lsTemp.add(Kard(ct++, vSchema.tyKard, vSchema.name, vSchema.desc ?? "", vSchema.rule ?? ""));
    }
  }
  return lsTemp;
}

final List<Kard> lsKard = populateKardDeck();

Kard castKardFromidKard(int idKard) {
  return Kard(lsKard[idKard].idKard, lsKard[idKard].tyKard, lsKard[idKard].nmKard, lsKard[idKard].txDesc, lsKard[idKard].txRule);
}

String getNmKard(int idKard) {
  return lsKard[idKard].nmKard;
}

TyKard getTyKard(int idKard) {
  return lsKard[idKard].tyKard;
}

String getDesc(int idKard) {
  return lsKard[idKard].txDesc;
}

String getRule(int idKard) {
  return lsKard[idKard].txRule;
}

String getKardImage(int idKard) {
  switch (lsKard[idKard].tyKard) {
    case TyKard.bonus:
      return "assets/img/bonus.png";
    case TyKard.curse:
      return "assets/img/curse.png";
    case TyKard.powerup:
      return "assets/img/powerup.png";
    default:
      return "assets/img/notset.jpg";
  }
}

Color getColorKardBkg(int idKard) {
  switch (lsKard[idKard].tyKard) {
    case TyKard.bonus:
      switch (lsKard[idKard].nmKard.substring(0, 1)) {
        case "R":
          return Colors.red;
        case "O":
          return Colors.orange;
        case "Y":
          return Colors.yellow;
        case "G":
          return Colors.green;
        case "B":
          return const Color.fromARGB(255, 82, 57, 226);
        default:
          return Colors.grey;
      }
    case TyKard.curse:
      return Colors.black;
    //    case TyKard.powerup:
    default:
      return Colors.purple;
  }
}

Color getColorKardText(int idKard) {
  switch (lsKard[idKard].tyKard) {
    case TyKard.bonus:
      switch (lsKard[idKard].nmKard.substring(0, 1)) {
        case "R":
          return Colors.yellow;
        case "O":
          return Colors.black;
        case "Y":
          return Colors.black;
        case "G":
          return Colors.purple;
        case "B":
          return Colors.white;
        default:
          return Colors.black;
      }
    case TyKard.curse:
      return Colors.white;
    //    case TyKard.powerup:
    default:
      return Colors.yellow;
  }
}

class StyledKardHeading extends StatelessWidget {
  final int idKard;
  const StyledKardHeading(this.idKard, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      getNmKard(idKard),
      style: TextStyle(color: getColorKardText(idKard), fontWeight: FontWeight.bold, fontSize: 16.0),

      //style: Theme.of(context).textTheme.headlineMedium,
    );
  }
} //getTyKard(idKard) == TyKard.notset ? "Not set" : getNmKard(
//getDesc(

class StyledKardText extends StatelessWidget {
  final int idKard;
  const StyledKardText(this.idKard, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      getDesc(idKard),
      style: TextStyle(color: getColorKardText(idKard), fontStyle: FontStyle.italic, fontSize: 14.0),

      //style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

//IconButton(onPressed: fnMove, icon: Icon(Icons.download))

Widget styledKardIconButton(int idKard, {required Widget icon, required VoidCallback onPressed}) {
  return IconButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      //#15 use the name of the widget to get styles
      backgroundColor: getColorKardBkg(idKard), //  Colors.blue[900],
      foregroundColor: getColorKardText(idKard), //Colors.white,
    ),
    icon: icon,
  );
}
