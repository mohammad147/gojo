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

List<String> sortplaces(Map<String, dynamic> _prediction, List<String> allplaces) {
  allplaces.sort((a, b) => _prediction[b]!.compareTo(_prediction[a]!));
  print(allplaces);
  return allplaces;
}

