class AttractionsCount {
  final int museums;
  final int wineries;
  final int zoos;
  final int offRoadTrips;
  final int trails;
  final int rockClimbing;
  final int waterSports;
  final int extremeSports;
  final int hotAirAttractions;
  final int tours;

  const AttractionsCount({
    required this.museums,
    required this.wineries,
    required this.zoos,
    required this.offRoadTrips,
    required this.trails,
    required this.rockClimbing,
    required this.waterSports,
    required this.extremeSports,
    required this.hotAirAttractions,
    required this.tours,
  });

  bool get isEmpty {
    return museums +
            wineries +
            zoos +
            offRoadTrips +
            trails +
            rockClimbing +
            waterSports +
            extremeSports +
            hotAirAttractions +
            tours ==
        0;
  }

  factory AttractionsCount.fromJson(Map<String, dynamic> json) {
    return AttractionsCount(
      museums: json["museums"],
      wineries: json["wineries"],
      zoos: json["zoos"],
      offRoadTrips: json["offroad"],
      trails: json["trails"],
      rockClimbing: json["rock_climbing"],
      waterSports: json["water_sports"],
      extremeSports: json["extreme_sports"],
      hotAirAttractions: json["hot_air"],
      tours: json["tours"],
    );
  }

  factory AttractionsCount.empty() {
    return AttractionsCount(
      museums: 0,
      wineries: 0,
      zoos: 0,
      offRoadTrips: 0,
      trails: 0,
      rockClimbing: 0,
      waterSports: 0,
      extremeSports: 0,
      hotAirAttractions: 0,
      tours: 0,
    );
  }
}
