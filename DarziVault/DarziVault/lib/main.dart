import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/services/hive_service.dart';
import 'core/services/notification_service.dart';
import 'app/theme/app_theme.dart';
import 'app/router/app_router.dart';
import 'app/router/route_names.dart';
import 'core/constants/app_constants.dart';
import 'core/utils/app_localizations.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final hiveService = HiveService();
  await hiveService.initialize();

  // Initialize Notification Service
  final notificationService = NotificationService();
  await notificationService.initialize();

  // Check for overdue orders and pending payments on app start
  await notificationService.checkOverdueOrders();
  await notificationService.checkPendingPayments();

  runApp(
    const ProviderScope(
      child: DarziVaultApp(),
    ),
  );
}

class DarziVaultApp extends ConsumerWidget {
  const DarziVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isUrdu = ref.watch(isUrduProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(isUrdu),
      darkTheme: AppTheme.darkTheme(isUrdu),
      themeMode: themeMode,
      locale: isUrdu ? const Locale('ur', 'PK') : const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
