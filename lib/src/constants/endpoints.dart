const String baseUrl = 'http://192.168.0.200:8080/api/v1';

abstract class Endpoints {
  static const String signin = '$baseUrl/auth';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/auth';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String vistoria = '$baseUrl/vistoria';
  static const String getAllVistorias = '$baseUrl/get-vistorias-list';
  // static const String getAllProducts = '$baseUrl/get-product-list';
  // static const String getCartItems = '$baseUrl/get-cart-items';
  // static const String addItemToCart = '$baseUrl/add-item-to-cart';
  // static const String changeItemQuantity = '$baseUrl/modify-item-quantity';
  // static const String checkout = '$baseUrl/checkout';
  // static const String getAllOrders = '$baseUrl/get-orders';
  // static const String getOrderItems = '$baseUrl/get-order-items';
  static const String changePassword = '$baseUrl/change-password';
}
