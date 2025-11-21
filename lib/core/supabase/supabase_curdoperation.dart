import 'package:supabase_flutter/supabase_flutter.dart';

/// A class for performing CRUD operations on Supabase tables
class SupabaseCRUD {
  static final Supabase _supabase = Supabase.instance;

  /// Get the Supabase client
  static SupabaseClient get client => _supabase.client;

  // ==================== CREATE OPERATIONS ====================

  /// Insert a single record into a table
  ///
  /// Example:
  /// ```dart
  /// final data = {'name': 'Product', 'price': 100};
  /// final result = await SupabaseCRUD.insert('products', data);
  /// ```
  static Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await client.from(table).insert(data).select().single();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Insert multiple records into a table
  ///
  /// Example:
  /// ```dart
  /// final data = [
  ///   {'name': 'Product 1', 'price': 100},
  ///   {'name': 'Product 2', 'price': 200},
  /// ];
  /// final result = await SupabaseCRUD.insertMany('products', data);
  /// ```
  static Future<List<Map<String, dynamic>>> insertMany(
    String table,
    List<Map<String, dynamic>> data,
  ) async {
    try {
      final response = await client.from(table).insert(data).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  // ==================== READ OPERATIONS ====================

  /// Fetch all records from a table
  ///
  /// Example:
  /// ```dart
  /// final products = await SupabaseCRUD.selectAll('products');
  /// ```
  static Future<List<Map<String, dynamic>>> selectAll(String table) async {
    try {
      final response = await client.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch a single record by ID
  ///
  /// Example:
  /// ```dart
  /// final product = await SupabaseCRUD.selectById('products', '123');
  /// ```
  static Future<Map<String, dynamic>?> selectById(
    String table,
    String column,
    String id,
  ) async {
    try {
      final response = await client
          .from(table)
          .select()
          .eq(column, id)
          .maybeSingle();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch records with custom query builder
  ///
  /// Example:
  /// ```dart
  /// final products = await SupabaseCRUD.select(
  ///   'products',
  ///   queryBuilder: (query) => query
  ///     .eq('category', 'electronics')
  ///     .order('price', ascending: false)
  ///     .limit(10),
  /// );
  /// ```
  static Future<List<Map<String, dynamic>>> select(
    String table, {
    required dynamic Function(dynamic) queryBuilder,
  }) async {
    try {
      final query = client.from(table).select();
      final response = await queryBuilder(query);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch records with filtering
  ///
  /// Example:
  /// ```dart
  /// final products = await SupabaseCRUD.selectWhere(
  ///   'products',
  ///   column: 'category',
  ///   value: 'electronics',
  /// );
  /// ```
  static Future<List<Map<String, dynamic>>> selectWhere(
    String table, {
    required String column,
    required dynamic value,
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async {
    try {
      dynamic query = client.from(table).select().eq(column, value);

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch a single record with filtering
  ///
  /// Example:
  /// ```dart
  /// final product = await SupabaseCRUD.selectSingleWhere(
  ///   'products',
  ///   column: 'slug',
  ///   value: 'my-product',
  /// );
  /// ```
  static Future<Map<String, dynamic>?> selectSingleWhere(
    String table, {
    required String column,
    required dynamic value,
  }) async {
    try {
      final response = await client
          .from(table)
          .select()
          .eq(column, value)
          .maybeSingle();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Count records in a table
  ///
  /// Example:
  /// ```dart
  /// final count = await SupabaseCRUD.count('products');
  /// ```
  static Future<int> count(String table, {String? column}) async {
    try {
      final response = await client.from(table).select(column ?? '*');
      return (response as List).length;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Update a record by ID
  ///
  /// Example:
  /// ```dart
  /// final data = {'price': 150, 'name': 'Updated Product'};
  /// final result = await SupabaseCRUD.updateById('products', '123', data);
  /// ```
  static Future<Map<String, dynamic>?> updateById(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await client
          .from(table)
          .update(data)
          .eq('id', id)
          .select()
          .maybeSingle();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Update multiple records with custom query builder
  ///
  /// Example:
  /// ```dart
  /// final data = {'status': 'active'};
  /// final result = await SupabaseCRUD.update(
  ///   'products',
  ///   data,
  ///   queryBuilder: (query) => query.eq('category', 'electronics'),
  /// );
  /// ```
  static Future<List<Map<String, dynamic>>> update(
    String table,
    Map<String, dynamic> data, {
    required dynamic Function(dynamic) queryBuilder,
  }) async {
    try {
      final query = client.from(table).update(data);
      final response = await queryBuilder(query).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  /// Update records with filtering
  ///
  /// Example:
  /// ```dart
  /// final data = {'status': 'inactive'};
  /// final result = await SupabaseCRUD.updateWhere(
  ///   'products',
  ///   data,
  ///   column: 'category',
  ///   value: 'old-category',
  /// );
  /// ```
  static Future<List<Map<String, dynamic>>> updateWhere(
    String table,
    Map<String, dynamic> data, {
    required String column,
    required dynamic value,
  }) async {
    try {
      final response = await client
          .from(table)
          .update(data)
          .eq(column, value)
          .select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Delete a record by ID
  ///
  /// Example:
  /// ```dart
  /// await SupabaseCRUD.deleteById('products', '123');
  /// ```
  static Future<bool> deleteById(String table, String id) async {
    try {
      await client.from(table).delete().eq('id', id);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete records with custom query builder
  ///
  /// Example:
  /// ```dart
  /// await SupabaseCRUD.delete(
  ///   'products',
  ///   queryBuilder: (query) => query.eq('status', 'inactive'),
  /// );
  /// ```
  static Future<bool> delete(
    String table, {
    required dynamic Function(dynamic) queryBuilder,
  }) async {
    try {
      final query = client.from(table).delete();
      await queryBuilder(query);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete records with filtering
  ///
  /// Example:
  /// ```dart
  /// await SupabaseCRUD.deleteWhere(
  ///   'products',
  ///   column: 'category',
  ///   value: 'old-category',
  /// );
  /// ```
  static Future<bool> deleteWhere(
    String table, {
    required String column,
    required dynamic value,
  }) async {
    try {
      await client.from(table).delete().eq(column, value);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== UTILITY METHODS ====================

  /// Execute a raw query (use with caution)
  ///
  /// Example:
  /// ```dart
  /// final result = await SupabaseCRUD.rawQuery('SELECT * FROM products WHERE price > 100');
  /// ```
  static Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    try {
      // Note: Supabase doesn't support raw SQL queries directly
      // This is a placeholder for future implementation if needed
      throw UnimplementedError(
        'Raw SQL queries are not directly supported by Supabase. '
        'Use the query builder methods instead.',
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Check if a record exists
  ///
  /// Example:
  /// ```dart
  /// final exists = await SupabaseCRUD.exists('products', 'id', '123');
  /// ```
  static Future<bool> exists(String table, String column, dynamic value) async {
    try {
      final response = await client
          .from(table)
          .select(column)
          .eq(column, value)
          .maybeSingle();
      return response != null;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a stream of real-time updates for a table
  ///
  /// Example:
  /// ```dart
  /// final stream = SupabaseCRUD.stream('products');
  /// stream.listen((data) {
  ///   print('Products updated: $data');
  /// });
  /// ```
  static Stream<List<Map<String, dynamic>>> stream(String table) {
    return client
        .from(table)
        .stream(primaryKey: ['id'])
        .map((data) => List<Map<String, dynamic>>.from(data));
  }
}
