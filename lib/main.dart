import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:cached_storage/cached_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nexacloth/core/route/app_router.dart';
import 'package:nexacloth/core/theme/app_theme.dart';
import 'package:nexacloth/core/supabase/supabase_client.dart';
import 'package:nexacloth/core/supabase/supabase_auth.dart';
import 'package:nexacloth/core/user_info_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  await SupabaseService.initialize(
    supabaseUrl: dotenv.env['SUPABASE_URL'] ?? '',
    supabaseAnonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  CachedQuery.instance.configFlutter(
    config: GlobalQueryConfig(
      refetchDuration: const Duration(seconds: 2),
      cacheDuration: const Duration(seconds: 10),
      refetchOnConnection: true,
      refetchOnResume: true,
    ),
    storage: await CachedStorage.ensureInitialized(),
  );

  // Listen to auth state changes and refresh router
  SupabaseAuth.authStateChanges.listen((authState) {
    AppRouter.refresh();
  });
  await UserInfoService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NexaCloth',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
