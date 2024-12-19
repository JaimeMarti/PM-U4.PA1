class WandModel {
  final String? wood;
  final String? core;
  final double? length;

  WandModel({required this.wood, required this.core, required this.length});

  factory WandModel.fromJson(Map<String, dynamic> json) {
    return WandModel(
      wood: json["wood"] == "" ? null : json["wood"],
      core: json["core"] == "" ? null : json["core"],
      length: json["length"]?.toDouble()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wood': wood,
      'core': core,
      'length': length
    };
  }
}