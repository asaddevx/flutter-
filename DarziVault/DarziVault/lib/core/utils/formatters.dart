import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class Formatters {
  Formatters._();
  
  static String formatPhoneNumber(String phone) {
    if (phone.length != 11) return phone;
    return '${phone.substring(0, 4)}-${phone.substring(4)}';
  }
  
  static String formatCNIC(String cnic) {
    if (cnic.length != 13) return cnic;
    return '${cnic.substring(0, 5)}-${cnic.substring(5, 12)}-${cnic.substring(12)}';
  }
  
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_PK',
      symbol: 'Rs. ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
  
  static String formatDate(DateTime date, {String? locale}) {
    return DateFormat.yMMMd(locale ?? 'en_US').format(date);
  }
  
  static String formatDateTime(DateTime dateTime, {String? locale}) {
    return DateFormat.yMMMd(locale ?? 'en_US').add_jm().format(dateTime);
  }
  
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
  
  static String generateOrderId(int number) {
    return '${AppConstants.orderIdPrefix}${number.toString().padLeft(AppConstants.orderIdLength, '0')}';
  }
}
