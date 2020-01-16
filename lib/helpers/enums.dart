class Enums {
  static String parse(enumType) {
    if (enumType == null) return null;

    return enumType.toString().split('.')[1];
  }

  static T fromString<T>(List<T> enumValues, String value) {
    if (value == null || enumValues == null) return null;

    return enumValues.singleWhere(
        (enumItem) =>
            Enums.parse(enumItem)?.toLowerCase() == value?.toLowerCase(),
        orElse: () => null);
  }
}
