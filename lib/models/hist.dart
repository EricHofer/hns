enum TyHistAct { drawn, moved, deletedFromDraw, deletedFromHand }

class Hist {
  // attributes
  final int idKard;
  final TyHistAct tyHistAct;

  const Hist(this.idKard, this.tyHistAct);

  // Convert History to Map for JSON encoding
  Map<String, dynamic> toJson() => {
    'idKard': idKard,
    'tyHistAct': tyHistAct.name, // Store enum as String
  };

  // Create History from Map (after JSON decoding)
  factory Hist.fromJson(Map<String, dynamic> json) => Hist(json['idKard'] as int, TyHistAct.values.byName(json['tyHistAct'] as String));
}
