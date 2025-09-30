/// Bega Supabase Auth Package
///
/// A comprehensive Flutter package that provides Supabase authentication
/// with BLoC state management, environment configuration, and reusable widgets.

// Export configuration
export 'src/config/bega_supabase_config.dart';
export 'src/config/env_config.dart';

// Export data layer
export 'src/data/auth_repository.dart';
export 'src/data/social_auth_repository.dart';

// Export domain layer
export 'src/domain/auth_user.dart';
export 'src/domain/auth_result.dart';
export 'src/domain/use_cases/auth_use_cases.dart';

// Export presentation layer
export 'src/presentation/bloc/auth_bloc.dart';
export 'src/presentation/bloc/auth_event.dart';
export 'src/presentation/bloc/auth_state.dart';


