import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  static Supabase get instance => Supabase.instance;

  static GoTrueClient get auth => instance.client.auth;
}
