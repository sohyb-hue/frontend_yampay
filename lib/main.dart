import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ملاحظة: عند تشغيل flutter run سيتم إنشاؤه تلقائياً بواسطة Flutter
// ignore: unused_import
import 'l10n/app_localizations.dart';

// متغيران عامان للتحكم بحالة الثيم واللغة الرسمية
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('ar'));

void main() {
  runApp(const CyberYemenExpressApp());
}

class CyberYemenExpressApp extends StatelessWidget {
  const CyberYemenExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (_, Locale currentLocale, __) {
            return MaterialApp(
              title: 'Yemen Express - Cyberpunk Edition',
              debugShowCheckedModeBanner: false,
              themeMode: currentMode,
              
              // =========================================================
              // ضبط إعدادات التوطين الرسمية الأكاديمية (Localizations & Locales)
              // =========================================================
              locale: currentLocale,
              supportedLocales: const [
                Locale('ar', ''), // العربية
                Locale('en', ''), // الإنجليزية
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate, // المترجم المولّد للمشروع
                GlobalMaterialLocalizations.delegate, // توطين عناصر Flutter Material
                GlobalWidgetsLocalizations.delegate, // توطين اتجاهات الواجهات (RTL/LTR)
                GlobalCupertinoLocalizations.delegate, // توطين عناصر iOS
              ],

              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: const Color(0xFFF4F6F9),
                primaryColor: const Color(0xFF0056D2),
                cardColor: Colors.white,
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF0056D2),
                  secondary: Color(0xFF03A9F4),
                  surface: Colors.white,
                  tertiary: Color(0xFFFF007F),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF0056D2),
                  elevation: 1,
                ),
                dividerColor: Colors.black12,
              ),
              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: const Color(0xFF0D0F16),
                primaryColor: const Color(0xFF00F2FE),
                cardColor: const Color(0xFF161B26),
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF00F2FE),
                  secondary: Color(0xFF4FACFE),
                  surface: Color(0xFF161B26),
                  tertiary: Color(0xFFFF007F),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF161B26),
                  foregroundColor: Color(0xFF00F2FE),
                  elevation: 0,
                ),
                dividerColor: Colors.white24,
              ),
              home: const LoginScreen(),
            );
          },
        );
      },
    );
  }
}

// =============================================================
// نماذج البيانات
// =============================================================
class Product {
  String id;
  String name;
  double price;
  String icon;
  String categoryCode;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
    required this.categoryCode,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class TransactionRecord {
  final String transactionId;
  final String date;
  final double totalAmount;
  final List<String> usedWallets;

  TransactionRecord({
    required this.transactionId,
    required this.date,
    required this.totalAmount,
    required this.usedWallets,
  });
}

List<String> categoryCodes = ['all', 'electronics', 'phones', 'solar', 'yemeni'];

List<Product> globalProducts = [
  Product(id: '1', name: 'لابتوب ديل نيون AI Pro', price: 450000, icon: '💻', categoryCode: 'electronics'),
  Product(id: '2', name: 'هاتف جالاكسي سايبر 5G', price: 280000, icon: '📱', categoryCode: 'phones'),
  Product(id: '3', name: 'ساعة كمومية ذكية', price: 35000, icon: '⌚', categoryCode: 'electronics'),
  Product(id: '4', name: 'سماعات أثيرية لاسلكية', price: 18000, icon: '🎧', categoryCode: 'electronics'),
  Product(id: '5', name: 'شاشة هولوجرام 55 بوصة', price: 320000, icon: '📺', categoryCode: 'electronics'),
  Product(id: '6', name: 'كاميرا رؤية ليلية سايبر', price: 520000, icon: '📷', categoryCode: 'electronics'),
  Product(id: '7', name: 'راوتر إنترنت فضائي طائر', price: 65000, icon: '📡', categoryCode: 'electronics'),
  Product(id: '8', name: 'منظومة طاقة شمسية ذكية', price: 185000, icon: '☀️', categoryCode: 'solar'),
  Product(id: '9', name: 'لوحة مفاتيح ميكانيكية نيون', price: 22000, icon: '⌨️', categoryCode: 'electronics'),
  Product(id: '10', name: 'بن خولاني فاخر معزز', price: 12000, icon: '☕', categoryCode: 'yemeni'),
];

List<CartItem> globalCart = [];
List<TransactionRecord> globalTransactions = [
  TransactionRecord(
    transactionId: 'TX-9021',
    date: '2026-09-07 18:20',
    totalAmount: 315000,
    usedWallets: ['كريمي إكسبرس (150,000 YR)', 'جوالي (165,000 YR)'],
  ),
];

// أزرار التحكم باللغة والثيم
Widget buildThemeToggle(BuildContext context) {
  bool isDark = themeNotifier.value == ThemeMode.dark;
  return IconButton(
    icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
    color: Theme.of(context).colorScheme.primary,
    onPressed: () {
      themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
    },
  );
}

Widget buildLanguageToggle(BuildContext context) {
  bool isArabic = localeNotifier.value.languageCode == 'ar';
  return TextButton(
    onPressed: () {
      localeNotifier.value = isArabic ? const Locale('en') : const Locale('ar');
    },
    child: Text(
      isArabic ? 'EN' : 'عربي',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

// دالة مساعدة للحصول على مترجم النصوص الأكاديمي
AppLocalizations loc(BuildContext context) => AppLocalizations.of(context)!;

// =============================================================
// 1. شاشة تسجيل الدخول
// =============================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userRole = 'CUSTOMER';
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_userRole == 'ADMIN') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StoreScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = Theme.of(context).cardColor;
    final textColor = isDark ? Colors.white : Colors.black87;
    final l10n = loc(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark 
                ? [const Color(0xFF0D0F16), const Color(0xFF1B1E2E)]
                : [const Color(0xFFF4F6F9), const Color(0xFFE0E5EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildLanguageToggle(context),
                      buildThemeToggle(context),
                    ],
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: primaryColor.withOpacity(0.5), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: primaryColor.withOpacity(0.2), blurRadius: 20, spreadRadius: 2),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withOpacity(0.1),
                              border: Border.all(color: primaryColor),
                            ),
                            child: Icon(Icons.bolt, size: 50, color: primaryColor),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            l10n.loginTitle,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: primaryColor),
                          ),
                          Text(l10n.loginSubtitle, style: TextStyle(color: isDark ? Colors.grey : Colors.black54, fontSize: 12)),
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildRoleChip(l10n.customer, 'CUSTOMER', primaryColor),
                              const SizedBox(width: 12),
                              _buildRoleChip(l10n.admin, 'ADMIN', Colors.purpleAccent),
                            ],
                          ),
                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _usernameController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: l10n.username,
                              labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                              prefixIcon: Icon(Icons.person_outline, color: primaryColor),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: textColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primaryColor)),
                            ),
                            validator: (v) => v!.isEmpty ? l10n.usernameRequired : null,
                          ),
                          const SizedBox(height: 15),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: l10n.password,
                              labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                              prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: textColor.withOpacity(0.2))),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primaryColor)),
                            ),
                            validator: (v) => v!.isEmpty ? l10n.passwordRequired : null,
                          ),
                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: isDark ? Colors.black : Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 10,
                              ),
                              onPressed: _login,
                              child: Text(l10n.loginBtn, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleChip(String label, String role, Color color) {
    bool selected = _userRole == role;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => setState(() => _userRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? color : (isDark ? Colors.grey.shade700 : Colors.grey.shade300), width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(color: selected ? color : (isDark ? Colors.grey : Colors.black54), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// =============================================================
// 2. شاشة متجر العملاء
// =============================================================
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _selectedCategoryCode = 'all';

  List<Product> get filteredProducts {
    if (_selectedCategoryCode == 'all') return globalProducts;
    return globalProducts.where((p) => p.categoryCode == _selectedCategoryCode).toList();
  }

  String _getCategoryTranslation(String code, AppLocalizations l10n) {
    switch (code) {
      case 'electronics': return l10n.categoryElectronics;
      case 'phones': return l10n.categoryPhones;
      case 'solar': return l10n.categorySolar;
      case 'yemeni': return l10n.categoryYemeni;
      default: return l10n.categoryAll;
    }
  }

  void _addToCart(Product product) {
    setState(() {
      int index = globalCart.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        globalCart[index].quantity++;
      } else {
        globalCart.add(CartItem(product: product));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ${loc(context).addedToCart}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  void _openCartModal() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = Theme.of(context).cardColor;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black87;
    final l10n = loc(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          double total = globalCart.fold(0, (sum, i) => sum + (i.product.price * i.quantity));

          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l10n.smartCart, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
                    IconButton(icon: Icon(Icons.close, color: isDark ? Colors.grey : Colors.black54), onPressed: () => Navigator.pop(ctx)),
                  ],
                ),
                Divider(color: Theme.of(context).dividerColor),

                if (globalCart.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_shopping_cart, size: 60, color: isDark ? Colors.grey : Colors.black38),
                          const SizedBox(height: 10),
                          Text(l10n.emptyCart, style: TextStyle(color: isDark ? Colors.grey : Colors.black54)),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: globalCart.length,
                      itemBuilder: (c, index) {
                        final item = globalCart[index];
                        return Card(
                          color: scaffoldColor,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Text(item.product.icon, style: const TextStyle(fontSize: 28)),
                            title: Text(item.product.name, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                            subtitle: Text('${(item.product.price * item.quantity).toStringAsFixed(0)} YR', style: TextStyle(color: primaryColor)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.orange),
                                  onPressed: () {
                                    setModalState(() {
                                      setState(() {
                                        if (item.quantity > 1) {
                                          item.quantity--;
                                        } else {
                                          globalCart.removeAt(index);
                                        }
                                      });
                                    });
                                  },
                                ),
                                Text('${item.quantity}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                  onPressed: () {
                                    setModalState(() {
                                      setState(() {
                                        item.quantity++;
                                      });
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                                  onPressed: () {
                                    setModalState(() {
                                      setState(() {
                                        globalCart.removeAt(index);
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                if (globalCart.isNotEmpty) ...[
                  Divider(color: Theme.of(context).dividerColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.actualTotal, style: TextStyle(fontSize: 16, color: textColor)),
                      Text('${total.toStringAsFixed(0)} YR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, 
                        foregroundColor: isDark ? Colors.black : Colors.white
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SplitPaymentScreen(totalInvoiceAmount: total)),
                        );
                      },
                      child: Text(l10n.proceedToCheckout, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  )
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalItemsInCart = globalCart.fold(0, (sum, i) => sum + i.quantity);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = Theme.of(context).cardColor;
    final textColor = isDark ? Colors.white : Colors.black87;
    final l10n = loc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.storeTitle, style: const TextStyle(fontSize: 16)),
        actions: [
          buildLanguageToggle(context),
          buildThemeToggle(context),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag_outlined, color: primaryColor, size: 28),
                onPressed: _openCartModal,
              ),
              if (totalItemsInCart > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.redAccent,
                    child: Text('$totalItemsInCart', style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout, color: isDark ? Colors.grey : Colors.black54),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen())),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryCodes.length,
              itemBuilder: (ctx, i) {
                final catCode = categoryCodes[i];
                bool isSelected = catCode == _selectedCategoryCode;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryCode = catCode),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withOpacity(0.2) : cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? primaryColor : Theme.of(context).dividerColor),
                    ),
                    child: Text(
                      _getCategoryTranslation(catCode, l10n), 
                      style: TextStyle(color: isSelected ? primaryColor : (isDark ? Colors.grey : Colors.black54), fontWeight: FontWeight.bold)
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (ctx, index) {
                final product = filteredProducts[index];
                return Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isDark ? Colors.white.withOpacity(0.08) : Colors.black12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 8, spreadRadius: 1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(child: Text(product.icon, style: const TextStyle(fontSize: 55))),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product.price.toStringAsFixed(0)} YR',
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor.withOpacity(0.15),
                              foregroundColor: primaryColor,
                              side: BorderSide(color: primaryColor),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            onPressed: () => _addToCart(product),
                            child: Text(l10n.addToCart, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// =============================================================
// 3. لوحة تحكم مدير النظام
// =============================================================
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _openProductDialog({Product? product, int? index}) {
    final l10n = loc(context);
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(text: product != null ? product.price.toStringAsFixed(0) : '');
    final iconController = TextEditingController(text: product?.icon ?? '📦');
    String selectedCatCode = product?.categoryCode ?? categoryCodes[1];
    
    final cardColor = Theme.of(context).cardColor;
    final primaryColor = Theme.of(context).colorScheme.primary;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: cardColor,
        title: Text(product == null ? l10n.addProduct : l10n.editProduct, style: TextStyle(color: primaryColor)),
        content: StatefulBuilder(
          builder: (context, setDlgState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: l10n.productName)),
              TextField(controller: priceController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l10n.productPrice)),
              TextField(controller: iconController, decoration: InputDecoration(labelText: l10n.productEmoji)),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCatCode,
                isExpanded: true,
                dropdownColor: cardColor,
                items: categoryCodes.where((c) => c != 'all').map((c) => DropdownMenuItem(value: c, child: Text(c, style: TextStyle(color: isDark ? Colors.white : Colors.black)))).toList(),
                onChanged: (val) => setDlgState(() => selectedCatCode = val!),
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: isDark ? Colors.black : Colors.white),
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                setState(() {
                  if (product == null) {
                    globalProducts.add(Product(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      icon: iconController.text.isEmpty ? '📦' : iconController.text,
                      categoryCode: selectedCatCode,
                    ));
                  } else {
                    globalProducts[index!] = Product(
                      id: product.id,
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      icon: iconController.text,
                      categoryCode: selectedCatCode,
                    );
                  }
                });
                Navigator.pop(ctx);
              }
            },
            child: Text(l10n.save),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalRevenue = globalTransactions.fold(0, (sum, t) => sum + t.totalAmount);
    final cardColor = Theme.of(context).cardColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final l10n = loc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminTitle, style: TextStyle(color: isDark ? Colors.purpleAccent : primaryColor, fontSize: 15)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: isDark ? Colors.purpleAccent : primaryColor,
          labelColor: isDark ? Colors.purpleAccent : primaryColor,
          unselectedLabelColor: isDark ? Colors.white54 : Colors.black54,
          tabs: [
            Tab(icon: const Icon(Icons.inventory_2_outlined), text: l10n.manageProducts),
            Tab(icon: const Icon(Icons.receipt_long_outlined), text: l10n.salesAndPayments),
          ],
        ),
        actions: [
          buildLanguageToggle(context),
          buildThemeToggle(context),
          IconButton(
            icon: Icon(Icons.logout, color: isDark ? Colors.grey : Colors.black54),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen())),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              backgroundColor: isDark ? Colors.purpleAccent : primaryColor,
              onPressed: () => _openProductDialog(),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: globalProducts.length,
              itemBuilder: (ctx, index) {
                final p = globalProducts[index];
                return Card(
                  color: cardColor,
                  child: ListTile(
                    leading: Text(p.icon, style: const TextStyle(fontSize: 28)),
                    title: Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                    subtitle: Text('${p.price.toStringAsFixed(0)} YR | ${p.categoryCode}', style: TextStyle(color: isDark ? Colors.purpleAccent : primaryColor)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.cyan), onPressed: () => _openProductDialog(product: p, index: index)),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            setState(() => globalProducts.removeAt(index));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Card(
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.totalSales, style: TextStyle(fontSize: 15, color: textColor)),
                        Text('${totalRevenue.toStringAsFixed(0)} YR', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.greenAccent : Colors.green)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: globalTransactions.length,
                    itemBuilder: (ctx, i) {
                      final tx = globalTransactions[i];
                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ExpansionTile(
                          leading: Icon(Icons.verified_outlined, color: isDark ? Colors.greenAccent : Colors.green),
                          title: Text('${l10n.txNo} ${tx.transactionId}', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                          subtitle: Text('${l10n.amount} ${tx.totalAmount.toStringAsFixed(0)} YR | ${l10n.date} ${tx.date}', style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                          children: tx.usedWallets.map((w) => ListTile(
                            dense: true,
                            leading: Icon(Icons.subdirectory_arrow_right, color: primaryColor),
                            title: Text('${l10n.deductionWallet} $w', style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
                          )).toList(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// =============================================================
// 4. واجهة الدفع المقسّم
// =============================================================
class SplitPaymentScreen extends StatefulWidget {
  final double totalInvoiceAmount;
  const SplitPaymentScreen({super.key, required this.totalInvoiceAmount});

  @override
  State<SplitPaymentScreen> createState() => _SplitPaymentScreenState();
}

class _SplitPaymentScreenState extends State<SplitPaymentScreen> {
  final List<Map<String, dynamic>> _wallets = [
    {'id': 'kuraimi', 'icon': '🏦'},
    {'id': 'jawali', 'icon': '📱'},
    {'id': 'cash', 'icon': '💵'},
    {'id': 'floosak', 'icon': '💳'},
  ];

  final List<Map<String, dynamic>> _completedPayments = [];

  double get paidAmount => _completedPayments.fold(0, (sum, item) => sum + (item['amount'] as double));
  double get remainingAmount => widget.totalInvoiceAmount - paidAmount;

  String _getWalletTitle(String id, AppLocalizations l10n) {
    switch (id) {
      case 'kuraimi': return l10n.kuraimi;
      case 'jawali': return l10n.jawali;
      case 'cash': return l10n.cash;
      case 'floosak': return l10n.floosak;
      default: return id;
    }
  }

  void _payWithWallet(Map<String, dynamic> wallet) {
    if (remainingAmount <= 0) return;

    final l10n = loc(context);
    final amountController = TextEditingController(text: remainingAmount.toStringAsFixed(0));
    final phoneController = TextEditingController();
    
    final cardColor = Theme.of(context).cardColor;
    final primaryColor = Theme.of(context).colorScheme.primary;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String walletTitle = _getWalletTitle(wallet['id'], l10n);

    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom + 20, top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${l10n.deductVia} $walletTitle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 15),
            TextField(controller: amountController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l10n.amountToDeduct)),
            TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: l10n.phoneWalletNo)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: isDark ? Colors.black : Colors.white),
                onPressed: () {
                  double val = double.tryParse(amountController.text) ?? 0;
                  if (val > 0 && val <= remainingAmount) {
                    setState(() {
                      _completedPayments.add({
                        'wallet': walletTitle,
                        'amount': val,
                      });
                    });
                    Navigator.pop(ctx);
                    if (remainingAmount <= 0) _finishTransaction();
                  }
                },
                child: Text(l10n.confirmDeduction),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _finishTransaction() {
    final l10n = loc(context);
    globalTransactions.insert(0, TransactionRecord(
      transactionId: 'TX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      date: DateTime.now().toString().substring(0, 16),
      totalAmount: widget.totalInvoiceAmount,
      usedWallets: _completedPayments.map((e) => "${e['wallet']} (${(e['amount'] as double).toStringAsFixed(0)} YR)").toList(),
    ));

    globalCart.clear();

    final cardColor = Theme.of(context).cardColor;
    final primaryColor = Theme.of(context).colorScheme.primary;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: cardColor,
        title: Column(
          children: [
            Icon(Icons.check_circle_outline, color: primaryColor, size: 60),
            const SizedBox(height: 10),
            Text(l10n.paymentCompletedTitle, style: TextStyle(color: primaryColor)),
          ],
        ),
        content: Text(l10n.paymentCompletedMsg, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: isDark ? Colors.black : Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text(l10n.backToStore),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = isDark ? Colors.white : Colors.black87;
    final l10n = loc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.splitGatewayTitle),
        actions: [
          buildLanguageToggle(context),
          buildThemeToggle(context),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l10n.totalInvoice, style: TextStyle(color: textColor)), Text('${widget.totalInvoiceAmount.toStringAsFixed(0)} YR', style: TextStyle(fontWeight: FontWeight.bold, color: textColor))]),
                  const SizedBox(height: 5),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l10n.paidAmount, style: TextStyle(color: textColor)), Text('${paidAmount.toStringAsFixed(0)} YR', style: TextStyle(color: isDark ? Colors.greenAccent : Colors.green))]),
                  Divider(color: Theme.of(context).dividerColor),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l10n.remainingAmount, style: TextStyle(color: textColor)), Text('${remainingAmount.toStringAsFixed(0)} YR', style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold))]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _wallets.length,
                itemBuilder: (c, i) {
                  final w = _wallets[i];
                  return Card(
                    color: cardColor,
                    child: ListTile(
                      leading: Text(w['icon'], style: const TextStyle(fontSize: 26)),
                      title: Text(_getWalletTitle(w['id'], l10n), style: TextStyle(color: textColor)),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: isDark ? Colors.black : Colors.white),
                        onPressed: remainingAmount <= 0 ? null : () => _payWithWallet(w),
                        child: Text(l10n.deductPayment),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}