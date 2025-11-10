import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/onboarding/screens/onboarding_screen_1.dart';
import '../../features/onboarding/screens/onboarding_screen_2.dart';
import '../../features/onboarding/screens/onboarding_screen_3.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/search/screens/search_screen.dart';
import '../../features/listing/screens/listing_detail_screen.dart';
import '../../features/listing/screens/add_listing_screen.dart';
import '../../features/listing/screens/add_listing_step_1_screen.dart';
import '../../features/listing/screens/add_listing_step_2_screen.dart';
import '../../features/listing/screens/add_listing_step_3_screen.dart';
import '../../features/listing/screens/edit_listing_management_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/main_settings_screen.dart';
import '../../features/profile/screens/notification_settings_screen.dart';
import '../../features/profile/screens/security_account_settings_screen.dart';
import '../../features/profile/screens/help_support_screen.dart';
import '../../features/booking/screens/booking_screen.dart';
import '../../features/booking/screens/reservation_process_screen.dart';
import '../../features/messaging/screens/messaging_inbox_screen.dart';
import '../../features/messaging/screens/chat_conversation_screen.dart';
import '../../features/host/screens/host_dashboard_screen.dart';
import '../../features/ai/screens/ai_chat_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/onboarding/1',
        builder: (context, state) => const OnboardingScreen1(),
      ),
      GoRoute(
        path: '/onboarding/2',
        builder: (context, state) => const OnboardingScreen2(),
      ),
      GoRoute(
        path: '/onboarding/3',
        builder: (context, state) => const OnboardingScreen3(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/listing/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ListingDetailScreen(listingId: id);
        },
      ),
      GoRoute(
        path: '/listing/add',
        builder: (context, state) => const AddListingScreen(),
      ),
      GoRoute(
        path: '/listing/add/step1',
        builder: (context, state) => const AddListingStep1Screen(),
      ),
      GoRoute(
        path: '/listing/add/step2',
        builder: (context, state) => const AddListingStep2Screen(),
      ),
      GoRoute(
        path: '/listing/add/step3',
        builder: (context, state) => const AddListingStep3Screen(),
      ),
      GoRoute(
        path: '/listing/edit/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EditListingManagementScreen(listingId: id);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const MainSettingsScreen(),
      ),
      GoRoute(
        path: '/settings/notifications',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/settings/security',
        builder: (context, state) => const SecurityAccountSettingsScreen(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/booking/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BookingScreen(listingId: id);
        },
      ),
      GoRoute(
        path: '/reservation/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ReservationProcessScreen(listingId: id);
        },
      ),
      GoRoute(
        path: '/messages',
        builder: (context, state) => const MessagingInboxScreen(),
      ),
      GoRoute(
        path: '/chat/:userId',
        builder: (context, state) {
          final userId = state.pathParameters['userId']!;
          return ChatConversationScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/host/dashboard',
        builder: (context, state) => const HostDashboardScreen(),
      ),
      GoRoute(
        path: '/ai-chat',
        builder: (context, state) => const AiChatScreen(),
      ),
    ],
  );
}

