## 0.0.2

### Added
- **Callback Support**: Added comprehensive callback system to `BegaSupabaseAuth` widget
  - `onSignInSuccess`: Called when email/password sign in succeeds
  - `onSignUpSuccess`: Called when email/password sign up succeeds
  - `onSocialAuthSuccess`: Called when social authentication succeeds
  - `onSignOutSuccess`: Called when user signs out
  - `onAuthError`: Called when general authentication errors occur
  - `onSocialAuthError`: Called when social authentication errors occur
- **Enhanced Examples**: Added `callback_example.dart` demonstrating callback usage
- **Updated Documentation**: README now includes callback usage examples and best practices

### Improved
- Better error handling with provider-specific error callbacks
- Enhanced user experience with custom redirection support
- More flexible integration with existing app architectures

### Fixed
- Fixed null safety issues in callback implementations
- Improved code quality and linting compliance

## 0.0.1

* Initial release with basic Supabase authentication integration
* BLoC state management support
* Environment configuration
* Reusable authentication widgets
