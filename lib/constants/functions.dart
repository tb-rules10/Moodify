//

String formatDuration(int seconds) {
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = remainingSeconds.toString().padLeft(2, '0');
  return '$minutesStr:$secondsStr';
}


String trimTitle(String str) {
  int index = str.indexOf(RegExp(r'[\(|\|]'));
  return index == -1 ? str : str.substring(0, index);
}
