extension StringExtension on String {
  /// This function used to convert a string in to a sentence case. Making first letter capital and the rest lower caps.
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
