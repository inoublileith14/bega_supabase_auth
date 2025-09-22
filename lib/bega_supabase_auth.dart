/// Bega Supabase Auth Package
/// 
/// A Flutter package that integrates supabase_auth_ui with BLoC state management,
/// supporting email/password authentication and social provider authentication.
library bega_supabase_auth;

// Export configuration
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
