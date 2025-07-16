//TODO DEFINE ROUTE AND WIDGET HERE => USE NAVIGATOR.PUSHNAMED

abstract class AppRoutes {
  // Authentication Screen
  static const login = '/login';

  static const register = '/register';

  // Main screen - Core Feature
  static const home = '/home';

  static const myTicket = '/my-ticket';

  static const buyTicket = '/buy-ticket';

  static const cart = '/cart';
  
  static const momoReturn = '/payment-result';

  // Secondary Screens - Auxiliary Screens
  static const profile = '/profile';

  static const settings = '/settings';

  // Student Verification Form Screen
  static const studentVerificationForm = '/student-verification-form';

  // Feedback Screen
  static const feedback = '/feedback';
  static const newFeedback = '/new-feedback';
}
