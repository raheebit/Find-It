abstract final class DateFormatter {
  static String relative(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) return 'الان';
    if (difference.inMinutes < 60) return '${difference.inMinutes} قبل دقيقة';
    if (difference.inHours < 24) return '${difference.inHours} قبل ساعة';
    if (difference.inDays < 7) return '${difference.inDays} قبل يوم';

    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
