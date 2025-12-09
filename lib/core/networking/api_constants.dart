class ApiConstants {
  // الرابط الأساسي للسيرفر
  static const String baseUrl = "https://fci-se-project.vercel.app/";

  // 1. Auth Endpoints
  static const String login = "users/login";
  static const String register = "users/add-user";

  // 2. Products Endpoints
  static const String products = "meals/get-all-meals"; // أو "products" حسب الـ API بتاعك
  static const String categories = "meals/get-meal-by-category?category=1";

  // 3. Cart Endpoints
  static const String cart = "carts";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}