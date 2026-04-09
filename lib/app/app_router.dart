import 'package:flutter/material.dart';

import '../features/checkout/domain/models/order_summary.dart';
import '../features/checkout/presentation/screens/customize_order_screen.dart';
import '../features/checkout/presentation/screens/payment_screen.dart';
import '../features/checkout/presentation/screens/success_screen.dart';
import '../features/home/data/food_items.dart';
import '../features/home/domain/models/food_item.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/product/presentation/screens/product_details_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/support/presentation/screens/support_chat_screen.dart';
import '../features/design/presentation/screens/design_handoff_screen.dart';

class AppRouter {
  const AppRouter._();

  static const splash = '/';
  static const home = '/home';
  static const product = '/product';
  static const customize = '/customize';
  static const payment = '/payment';
  static const success = '/success';
  static const profile = '/profile';
  static const chat = '/chat';
  static const designHandoff = '/design-handoff';

  static final sampleOrderSummary = OrderSummary(
    item: foodItems.first,
    quantity: 2,
    spicyLevel: 0.6,
    subtotal: 16.48,
    toppings: const ['Tomato', 'Onions'],
    sides: const ['Fries', 'Coleslaw'],
  );

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case product:
        final item = settings.arguments;
        if (item is! FoodItem) {
          return MaterialPageRoute<void>(
            builder: (_) => const SplashScreen(),
            settings: settings,
          );
        }
        return MaterialPageRoute<void>(
          builder: (_) => ProductDetailsScreen(item: item),
          settings: settings,
        );
      case customize:
        final item = settings.arguments;
        if (item is! FoodItem) {
          return MaterialPageRoute<void>(
            builder: (_) => const HomeScreen(),
            settings: settings,
          );
        }
        return MaterialPageRoute<void>(
          builder: (_) => CustomizeOrderScreen(item: item),
          settings: settings,
        );
      case payment:
        final summary = settings.arguments;
        final payload =
            summary is OrderSummary ? summary : AppRouter.sampleOrderSummary;
        return MaterialPageRoute<void>(
          builder: (_) => PaymentScreen(summary: payload),
          settings: settings,
        );
      case success:
        return MaterialPageRoute<void>(
          builder: (_) => const SuccessScreen(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute<void>(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      case chat:
        return MaterialPageRoute<void>(
          builder: (_) => const SupportChatScreen(),
          settings: settings,
        );
      case designHandoff:
        return MaterialPageRoute<void>(
          builder: (_) => const DesignHandoffScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
