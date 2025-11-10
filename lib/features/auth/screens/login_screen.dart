import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authNotifierProvider.notifier).signInWithEmail(
            _emailController.text,
            _passwordController.text,
          );

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.forest,
                        size: 32,
                        color: isDark ? Colors.green.shade400 : AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Campbnb Québec',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.neutral : AppColors.textPrimary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.neutral : AppColors.textPrimary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Heureux de vous revoir!',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? AppColors.neutral : AppColors.textPrimary,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: isDark ? AppColors.neutral : AppColors.textPrimary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Entrez votre email',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                                filled: true,
                                fillColor: isDark ? Colors.grey.shade800 : Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.secondary,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email requis';
                                }
                                if (!value.contains('@')) {
                                  return 'Email invalide';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Mot de passe',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? AppColors.neutral : AppColors.textPrimary,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                color: isDark ? AppColors.neutral : AppColors.textPrimary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                              decoration: InputDecoration(
                                hintText: 'Entrez votre mot de passe',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                                filled: true,
                                fillColor: isDark ? Colors.grey.shade800 : Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.secondary,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey.shade500,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mot de passe requis';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Connexion',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Forgot Password
                  TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password
                    },
                    child: const Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OU',
                          style: TextStyle(
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                            fontSize: 14,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Social Login Buttons
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement Google sign in
                      },
                      icon: Image.network(
                        'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text(
                        'Continuer avec Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark ? AppColors.neutral : AppColors.textPrimary,
                        side: BorderSide(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                        ),
                        backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement Facebook sign in
                      },
                      icon: const Icon(Icons.facebook, size: 24),
                      label: const Text(
                        'Continuer avec Facebook',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark ? AppColors.neutral : AppColors.textPrimary,
                        side: BorderSide(
                          color: isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                        ),
                        backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
