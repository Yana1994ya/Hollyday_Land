enum Difficulty { easy, medium, hard }

Difficulty difficultyFromString(String value) {
  if (value == "E") {
    return Difficulty.easy;
  } else if (value == "N") {
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
    return "N";
  } else if (difficulty == Difficulty.easy) {
    return "E";
  } else {
    throw Exception("Difficulty $difficulty is not recognized");
  }
}

String difficultyToDescription(Difficulty difficulty) {
  if (difficulty == Difficulty.hard) {
    return "Hard";
  } else if (difficulty == Difficulty.medium) {
    return "Moderate";
  } else if (difficulty == Difficulty.easy) {
    return "Easy";
  } else {
    throw Exception("Difficulty $difficulty is not recognized");
  }
}
