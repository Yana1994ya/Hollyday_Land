import "package:decimal/decimal.dart";

mixin WithRating {
  Decimal get avgRating;

  int get ratingCount;
}
