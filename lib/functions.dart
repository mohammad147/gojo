double calculateTotalRate(List<Map<String, dynamic>> raters) {
  double totalRate = 0;
  int numberOfRatings = raters.length;

  if (numberOfRatings == 0) {
    return 0.0; // Return 0 if there are no ratings
  }

  for (Map<String, dynamic> rating in raters) {
    totalRate += double.parse(rating['rate'].toString());
  }

  double averageRate = totalRate / numberOfRatings;
  double ratingOutOfFive = (averageRate / 5) * 5; // Convert to scale out of 5
  return ratingOutOfFive;
}
