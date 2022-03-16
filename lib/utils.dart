extension StringExtension on String {
  String capitalize() {
    /// This function isused to convert a string in to a sentence case. Making first letter capital and all lower caps.
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
