enum Difficulty { easy, medium, hard }

Difficulty difficultyFromString(String value) {
  if (value == "E") {
    return Difficulty.easy;
  } else if (value == "M") {
    return Difficulty.medium;
  } else if (value == "H") {
    return Difficulty.hard;
  } else {
    throw Exception("Difficulty $value is not recognized");
  }
}

String difficultyToString(Difficulty difficulty) {
  if (difficulty == Difficulty.hard) {
    return "H";
  } else if (difficulty == Difficulty.medium) {
    return "M";
  } else if (difficulty == Difficulty.easy) {
    return "E";
  } else {
    throw Exception("Difficulty $difficulty is not recognized");
  }
}
