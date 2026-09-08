import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ اختر العنوان المناسب لجهاز الاختبار لديك:
  // - لمحاكي الأندرويد (Android Emulator): http://10.0.2.2:8000
  // - لتطبيقات Chrome / Windows: http://127.0.0.1:8000
  // - لهاتف حقيقي عبر Wi-Fi: اكتب IP حاسوبك المحلي (مثل http://192.168.1.100:8000)
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // 1. تسجيل الدخول
  static Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("خطأ في الاتصال: $e");
    }
    return null;
  }

  // 2. جلب المنتجات من Django
  static Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/'));
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print("خطأ في جلب المنتجات: $e");
    }
    return [];
  }

  // 3. إنشاء فاتورة جديدة
  static Future<int?> createInvoice(double totalAmount) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/invoices/create/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'total_amount': totalAmount}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['id'];
      }
    } catch (e) {
      print("خطأ في إنشاء الفاتورة: $e");
    }
    return null;
  }

  // 4. إرسال عملية الخصم الجزئي من المحفظة
  static Future<Map<String, dynamic>?> processSplitPayment({
    required int invoiceId,
    required String walletName,
    required String phone,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/invoices/$invoiceId/pay/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'wallet_name': walletName,
          'phone_number': phone,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      print("خطأ في معالجة الدفع: $e");
    }
    return null;
  }
}