import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/logger_helper.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static Future<bool> showLocationServiceDialog(BuildContext context) async {
    return await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Location Services',
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              )),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                title: const Row(
                  children: [
                    Icon(Icons.location_off, color: secondaryOrange, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'خدمة الموقع معطلة',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: secondaryOrange,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'يرجى تفعيل خدمة الموقع في إعدادات جهازك للمتابعة',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: secondaryOrange,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_suggest,
                        size: 48,
                        color: secondaryOrange,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(
                              color: accentRedText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.settings,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'فتح الإعدادات',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            await Geolocator.openLocationSettings();
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              ),
            );
          },
        ) ??
        false;
  }

  static Future<bool> showPermissionDialog(BuildContext context) async {
    return await showGeneralDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Location Permission',
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                title: const Row(
                  children: [
                    Icon(Icons.location_on, color: primaryBlue, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'يحتاج التطبيق إلى إذن الموقع',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'يحتاج التطبيق إلى الوصول إلى موقعك لتوفير خدمة أفضل وتحديد عنوان التسليم الخاص بك',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryPurple,
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'لا',
                            style: TextStyle(
                              color: accentRedText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'نعم',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ),
                    ],
                  ),
                ],
                actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              ),
            );
          },
        ) ??
        false;
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(milliseconds: 900),
  }) {
    Color getColor() {
      switch (type) {
        case SnackBarType.success:
          return success;
        case SnackBarType.error:
          return error;
        case SnackBarType.warning:
          return warning;
        case SnackBarType.info:
        default:
          return info;
      }
    }

    IconData getIcon() {
      switch (type) {
        case SnackBarType.success:
          return Icons.check_circle_outline;
        case SnackBarType.error:
          return Icons.error_outline;
        case SnackBarType.warning:
          return Icons.warning_amber_rounded;
        case SnackBarType.info:
        default:
          return Icons.info_outline;
      }
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(getIcon(), color: darkText),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: getColor(),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: duration,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? primaryAction,
    VoidCallback? secondaryAction,
  }) {
    LoggerHelper.info(
        "Showing AlertDialog: Title - $title, Message - $message"); // Log Alert action

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            if (secondaryButtonText != null)
              TextButton(
                onPressed: secondaryAction ??
                    () {
                      LoggerHelper.info(
                          "Alert secondary button pressed: $secondaryButtonText");
                      Navigator.of(context).pop();
                    },
                child: Text(
                  secondaryButtonText,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ElevatedButton(
              onPressed: primaryAction ??
                  () {
                    LoggerHelper.info(
                        "Alert primary button pressed: ${primaryButtonText ?? 'OK'}");
                    Navigator.of(context).pop();
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                primaryButtonText ?? 'OK',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    LoggerHelper.info("Navigating to screen: ${screen.runtimeType}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void popScreen(BuildContext context) {
    LoggerHelper.info("Popping current screen.");
    Navigator.pop(context);
  }

  static void navigateReplacementToScreen(BuildContext context, Widget screen) {
    LoggerHelper.info(
        "Navigating with replacement to screen: ${screen.runtimeType}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    LoggerHelper.debug("Truncating text to max length $maxLength.");
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    LoggerHelper.info("Is dark mode: $isDark");
    return isDark;
  }

  static Size screenSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoggerHelper.debug("Screen size: ${size.width}x${size.height}");
    return size;
  }

  static double screenHeight(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    LoggerHelper.debug("Screen height: $height");
    return height;
  }

  static double screenWidth(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    LoggerHelper.debug("Screen width: $width");
    return width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    String formattedDate = DateFormat(format).format(date);
    LoggerHelper.info("Formatted date: $formattedDate");
    return formattedDate;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    LoggerHelper.debug("Removing duplicates from list.");
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    LoggerHelper.debug("Wrapping widgets into rows of size $rowSize.");
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static void hideKeyboard() {
    LoggerHelper.info("Hiding keyboard");
    FocusManager.instance.primaryFocus?.unfocus();
      }
}
