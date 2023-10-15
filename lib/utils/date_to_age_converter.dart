class DateToAgeConverter {
  static int calculateAgeFromDateTime(DateTime dateTime) {
    final birthDate = dateTime;
    final currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static int calculateAgeFromStringDate(String stringDate) {
    final birthDate = DateTime.parse(stringDate);
    final age = calculateAgeFromDateTime(birthDate);

    return age;
  }
}
