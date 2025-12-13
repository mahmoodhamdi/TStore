import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/core/supabase/supabase_config.dart';

/// Supabase Service - Singleton class for Supabase operations
class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseClient? _client;

  SupabaseService._();

  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  /// Initialize Supabase - Call this in main()
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
    );
    _client = Supabase.instance.client;
  }

  /// Get Supabase Client
  SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call SupabaseService.initialize() first.');
    }
    return _client!;
  }

  /// Get current user
  User? get currentUser => client.auth.currentUser;

  /// Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  /// Get current session
  Session? get currentSession => client.auth.currentSession;

  /// Auth state changes stream
  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  // ============== AUTH METHODS ==============

  /// Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    return await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.tstore://login-callback/',
    );
  }

  /// Sign in with Facebook
  Future<bool> signInWithFacebook() async {
    return await client.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: 'io.supabase.tstore://login-callback/',
    );
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    return await client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'io.supabase.tstore://login-callback/',
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  /// Update password
  Future<UserResponse> updatePassword(String newPassword) async {
    return await client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  /// Update user data
  Future<UserResponse> updateUser({
    String? email,
    String? password,
    Map<String, dynamic>? data,
  }) async {
    return await client.auth.updateUser(
      UserAttributes(
        email: email,
        password: password,
        data: data,
      ),
    );
  }

  /// Resend confirmation email
  Future<ResendResponse> resendConfirmation(String email) async {
    return await client.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

  // ============== DATABASE METHODS ==============

  /// Get data from table
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? select,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    var query = client.from(table).select(select ?? '*');

    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }

    // Chain the transformations
    dynamic result = query;

    if (orderBy != null) {
      result = result.order(orderBy, ascending: ascending);
    }

    if (limit != null) {
      result = result.limit(limit);
    }

    if (offset != null) {
      result = result.range(offset, offset + (limit ?? 10) - 1);
    }

    final response = await result;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get single record by ID
  Future<Map<String, dynamic>?> getById(String table, String id) async {
    final response = await client.from(table).select().eq('id', id).maybeSingle();
    return response;
  }

  /// Insert data
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await client.from(table).insert(data).select().single();
    return response;
  }

  /// Update data
  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await client.from(table).update(data).eq('id', id).select().single();
    return response;
  }

  /// Upsert data (insert or update)
  Future<Map<String, dynamic>> upsert(
    String table,
    Map<String, dynamic> data,
  ) async {
    final response = await client.from(table).upsert(data).select().single();
    return response;
  }

  /// Delete data
  Future<void> delete(String table, String id) async {
    await client.from(table).delete().eq('id', id);
  }

  /// Delete with filter
  Future<void> deleteWhere(
    String table,
    Map<String, dynamic> filters,
  ) async {
    var query = client.from(table).delete();
    filters.forEach((key, value) {
      query = query.eq(key, value);
    });
    await query;
  }

  // ============== STORAGE METHODS ==============

  /// Upload file
  Future<String> uploadFile(
    String bucket,
    String path,
    List<int> fileBytes, {
    String? contentType,
  }) async {
    await client.storage.from(bucket).uploadBinary(
          path,
          fileBytes as dynamic,
          fileOptions: FileOptions(contentType: contentType),
        );
    return client.storage.from(bucket).getPublicUrl(path);
  }

  /// Get public URL
  String getPublicUrl(String bucket, String path) {
    return client.storage.from(bucket).getPublicUrl(path);
  }

  /// Delete file
  Future<void> deleteFile(String bucket, String path) async {
    await client.storage.from(bucket).remove([path]);
  }

  // ============== REALTIME METHODS ==============

  /// Subscribe to table changes
  RealtimeChannel subscribeToTable(
    String table, {
    required void Function(PostgresChangePayload payload) onInsert,
    void Function(PostgresChangePayload payload)? onUpdate,
    void Function(PostgresChangePayload payload)? onDelete,
    Map<String, String>? filter,
  }) {
    final channel = client.channel('public:$table');

    channel.onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: table,
      filter: filter != null ? PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: filter.keys.first,
        value: filter.values.first,
      ) : null,
      callback: onInsert,
    );

    if (onUpdate != null) {
      channel.onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: table,
        callback: onUpdate,
      );
    }

    if (onDelete != null) {
      channel.onPostgresChanges(
        event: PostgresChangeEvent.delete,
        schema: 'public',
        table: table,
        callback: onDelete,
      );
    }

    channel.subscribe();
    return channel;
  }

  /// Unsubscribe from channel
  Future<void> unsubscribe(RealtimeChannel channel) async {
    await client.removeChannel(channel);
  }
}
