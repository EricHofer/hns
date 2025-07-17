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

  const CardSchema(this.tyKard, this.count, this.name, [this.desc, this.rule, this.extra]); // desc==cost, rule
}

// Schema (definitions) for the cards to build
final List<CardSchema> cardSchemas = [
  CardSchema(TyKard.bonus, 25, "Red", "2m, 3m, 5m", "every little helps"),
  CardSchema(TyKard.bonus, 15, "Orange", "4m, 6m, 10m", "longer than shorter"),
  CardSchema(TyKard.bonus, 10, "Yellow", "6m, 9m, 15m", "getting better (all the time)"),
  CardSchema(TyKard.bonus, 3, "Green", "8m, 12m, 20m", "I'll take it"),
  CardSchema(TyKard.bonus, 2, "Blue", "12m, 18m, 30m", "Score!"),
  CardSchema(
    TyKard.powerup,
    4,
    "Randomize",
    "Randomly select a different question",
    "When played, instead of responding to the question posed, the seeker randomly selects a different question (in the category) to answer.",
  ),
  CardSchema(TyKard.powerup, 4, "Veto", "Don't do it!", "Avoid answering a question; you may still draw your reward."),
  CardSchema(
    TyKard.powerup,
    2,
    "Duplicate",
    "That means make a copy.",
    "Choose any card in your hand and consider you now have 2 of such. (Note, this card, having been played CANNOT be duplicated).",
  ),
  CardSchema(
    TyKard.powerup,
    1,
    "Move",
    "Change location (cannot use in the endgame)",
    "Discard all cards in hand, transmit hiders the location of your transit station. Apply the pre-agreed lead time to move to a new location while the seekers wait.",
  ),
  CardSchema(TyKard.powerup, 4, "Discard 1, Draw 2", "", "as it says on the tin!"),
  CardSchema(TyKard.powerup, 4, "Discard 2, Draw 3", "", "you have to do this for yourself."),
  CardSchema(TyKard.powerup, 2, "Draw 1, Expand 1", "", "your hand can hold 1 extra card going forward."),
  CardSchema(
    TyKard.curse,
    1,
    "The Zoologist",
    "A photo of an animal",
    "Take a photo of a wild fish, bird, mammal, reptile, amphibian or bug. The seeker must take a picture of a wild animal of the same type before asking another question.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Unguided Tourist",
    "Seeker must be outside",
    "Send the seekers an unzoomed, Google 'Street View' image from a street within 300 meters of where you are now. The shot has to be parallel to the horizon and include at least one man-made structure other than a road. Without using the internet for research, seekers must find what you sent them in real life before they can use transit or ask another question, and so that hider(s) can verify.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Endless Tumble",
    "Roll a die. If it's 5 or 6 this card has no effect",
    "Seekers must cast the die at least 30 meters and have it land on a 5 or a 6 before they can ask another question. The die must roll the full distance, unaided, using only the momentum from the initial throw (and gravity) to travel the required distance. If the seekers accidentally hit someone with a die you are awarded a [S10, M20, L30] minute bonus.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Hidden Hangman",
    "Discard 2 cards",
    "Before asking another question or boarding another form of transport, seekers must be the hider in a game of hangman. THe word must be 5 letters long. Wrong guesses are limited to 7. The Hider must respond within 30 seconds to each guess. In the maximum, 3 round game, failure to guess correctly incurs 3S 7M 10L minute wait.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Overflowing Chalice",
    "Discard a card",
    "For the next three questions, you may draw (but not keep) an additional card when drawing from the hider deck",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Mediocre Travel Agent",
    "Their 'vacation destination' must be further from you than their current location",
    "Choose any publicly-accessible place within [S400, M400, L800] meters of the current location of the seeker(s), provided it is NOT on a form of transportation. Seekers must then go there, take 3 verification photos, collect a 'souvenir' of the 'vacation spot', and wait at least [S5 M5 L10] minutes before asking another question. They must send you at least three photos of them enjoying their 'vacation', and procure an object to bring you as souvenir. Should the souvenir get lost, hiders get an extra [S15, M30, L45] minutes.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Luxury Car",
    "A photo of a car",
    "Photograph a car. The seekers must take a photo of a more expensive car before asking another question.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The U-Turn",
    "Seekers must reverse course.",
    "If their next station is further from you than they are to theirs, Seekers must disembark their current mode of transportation at the next station (as long as that station is served by another form of transit in the next [S0.5, M0.5, L1] hours).",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Bridge Troll",
    "Seekers must be at least [S1.5, M8, L45] km from you",
    "The seekers must ask their next question from under a bridge.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "Water Weight",
    "Seekers must be within 300 meters of a body of water",
    "The seekers must acquire and carry at least 2 liters of liquid per seeker for the rest of your run. They cannot ask another question until they have acquired the liquid. The seekers can distribute the water among themselves how ever they wish. If the liquid is lost or abandoned at any point the hider is awarded a [S30, M30, L60] minute bonus.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Jammed Door",
    "Discard 2 cards",
    "For the next [S0.5, M1, L3] hours, whenever the seekers want to pass through a doorway into a building, business or train or other vehicle they must first roll 2 dice. If they do not roll a 7 or higher they cannot enter that space (including through another doorway). One must wait [S5, M10, L15] minutes before reattempting.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Cairn",
    "Build a rock tower",
    "In 1 attempt, stack stones one atop the other to raise a 'free standing tower.' Use as many stones as you can find locally. However, except for the 1st, stones can only touch their neighbors. Once stacked, a stone cannot be removed. Between each placement, one must wait 5 seconds proving the tower is stable. Continue until the tower falls. The seekers must then construct their tower following the same rules, using the same number of stones (not counting the final one) before asking the next question. Should their tower fall, restart. After completion, scatter the rocks as they were before.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Urban Explorer",
    "Discard 2 cards",
    "For the rest of the run, seekers cannot ask questions when they are on transit or in a train station.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Impressionable Consumer",
    "The seekers' next question is free",
    "Seekers must enter and gain admission (if applicable) to a location, or buy a product that they saw advertized, before asking another question. This advertisement must be found out in the world and must be at least 30 meters from the location (or product) itself.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Egg Partner",
    "Discard two cards (not playable in endgame)",
    "The seekers must acquire an egg before asking another question. From here on, this egg is considered an official team member of the seekers. If any team members are abandoned or killed (in the egg's case, this is defined as developing a crack) before the end of the run, you are awarded an extra [S15 M30 L45] minutes. This card cannot be played during the endgame.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Distant Cuisine",
    "You must be at the restaurant",
    "Find a restaurant within your zone that explicitly serves food from a specific foreign country. The seekers must visit a restaurant serving food from a country that is equal or greater distance away before asking another question.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Right Turn",
    "Discard a card",
    "For the next [S20 M40 L60] minutes the seekers can only turn right at any street intersection. If at any point they find themselves in a cul-de-sac (aka dead end) where they cannot continue forward or turn right for another 300 meters they must do a U-Turn. A right turn is defined as a road at any angle that veers to the right of the seekers.",
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
    "With only 1 attempt, and for as long as possible (but up to [S5 M10 L15] minutes), film  a bird, keeping it 'in frame.' Seekers must then replicate such, for the same duration.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "Spotty Memory",
    "Discard a time bonus card",
    "For the remainder of the run, one randomly selected category (based on the Seeker's die roll) of questions is no longer available. The category remains unavailable until the next question is asked at which point a die is rolled again to choose a new category. The same category can be disabled multiple times in a row.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Lemon Phylactery",
    "Discard a powerup card (not available in the endgame)",
    "Before asking another question the seekers must each find a lemon and affix it to their outermost layer of clothing or skin. If at any point one of these lemons is no longer touching a seeker you are awarded [S30 M45 L60] minutes. This curse cannot be played during the endgame.",
  ),
  CardSchema(
    TyKard.curse,
    1,
    "The Drained Brain",
    "Discard your hand",
    "Choose three questions in different categories. The seekers cannot ask those questions for the rest of the run.",
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
    "Roll a die. If its an even number, this curse has no effect",
    "For the next [S20 M40 L60] minutes seekers must roll a die before they take a step in any direction. They are then limited to that number of steps until the next die roll.",
  ),
];

List<Kard> populateKardDeck() {
  final List<Kard> lsTemp = [];
  int ct = 0;
  for (final CardSchema vSchema in cardSchemas) {
    for (int i = 0; i < vSchema.count; i++) {
      //      if ((testLength(vSchema.rule) > 50) | (testLength(vSchema.desc) > 500)) {
      lsTemp.add(Kard(ct++, vSchema.tyKard, vSchema.name, vSchema.desc ?? "", vSchema.rule ?? ""));
      //    }
    }
  }
  return lsTemp;
}

/*int testLength(String? tx) {
  tx = tx ?? "";
  return tx.length;
}*/

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
  return ((lsKard[idKard].tyKard == TyKard.curse) ? "Cost: " : "") + lsKard[idKard].txDesc;
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
