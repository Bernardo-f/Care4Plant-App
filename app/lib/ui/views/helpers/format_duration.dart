String formatDuration(Duration duration) {
  String formattedString = '';

  if (duration.inMinutes > 0) {
    formattedString += '${duration.inMinutes} min${duration.inMinutes > 1 ? 's' : ''} ';
  }

  if (duration.inSeconds % 60 > 0) {
    formattedString += '${duration.inSeconds % 60} s';
  }

  return formattedString.trim();
}
