double calculateTotalRate(List<Map<String, dynamic>> raters) {
  double totalRate = 0;
  int numberOfRatings = raters.length;

  if (numberOfRatings == 0) {
    return 0.0;
  }

  for (Map<String, dynamic> rating in raters) {
    totalRate += double.parse(rating['rate'].toString());
  }

  double averageRate = totalRate / numberOfRatings;
  double ratingOutOfFive = (averageRate / 5) * 5;
  return ratingOutOfFive;
}
