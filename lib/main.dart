import 'package:flutter/material.dart';

void main() {
  runApp(const CyberYemenExpressApp());
}

class CyberYemenExpressApp extends StatelessWidget {
  const CyberYemenExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemen Express - Cyberpunk Edition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0F16),
        primaryColor: const Color(0xFF00F2FE),
        cardColor: const Color(0xFF161B26),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00F2FE),
          secondary: Color(0xFF4FACFE),
          surface: Color(0xFF161B26),
          tertiary: Color(0xFFFF007F),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// =============================================================
// 1. نماذج البيانات وبنك البيانات التفاعلي (Global State)
// =============================================================
class Product {
  String id;
  String name;
  double price;
  String icon;
  String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
    required this.category,
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

// الأقسام المتاحة في المتجر
List<String> categories = ['الكل', 'إلكترونيات', 'هواتف', 'طاقة شمسية', 'منتجات يمنية'];

// المنتجات المستقبلية المجهزة مسبقاً
List<Product> globalProducts = [
  Product(id: '1', name: 'لابتوب ديل نيون AI Pro', price: 450000, icon: '💻', category: 'إلكترونيات'),
  Product(id: '2', name: 'هاتف جالاكسي سايبر 5G', price: 280000, icon: '📱', category: 'هواتف'),
  Product(id: '3', name: 'ساعة كمومية ذكية', price: 35000, icon: '⌚', category: 'إلكترونيات'),
  Product(id: '4', name: 'سماعات أثيرية لاسلكية', price: 18000, icon: '🎧', category: 'إلكترونيات'),
  Product(id: '5', name: 'شاشة هولوجرام 55 بوصة', price: 320000, icon: '📺', category: 'إلكترونيات'),
  Product(id: '6', name: 'كاميرا رؤية ليلية سايبر', price: 520000, icon: '📷', category: 'إلكترونيات'),
  Product(id: '7', name: 'راوتر إنترنت فضائي طائر', price: 65000, icon: '📡', category: 'إلكترونيات'),
  Product(id: '8', name: 'منظومة طاقة شمسية ذكية', price: 185000, icon: '☀️', category: 'طاقة شمسية'),
  Product(id: '9', name: 'لوحة مفاتيح ميكانيكية نيون', price: 22000, icon: '⌨️', category: 'إلكترونيات'),
  Product(id: '10', name: 'بن خولاني فاخر معزز', price: 12000, icon: '☕', category: 'منتجات يمنية'),
];

// السلة وسجل المبيعات العام
List<CartItem> globalCart = [];
List<TransactionRecord> globalTransactions = [
  TransactionRecord(
    transactionId: 'TX-9021',
    date: '2026-09-07 18:20',
    totalAmount: 315000,
    usedWallets: ['كريمي إكسبرس (150,000 ر.ي)', 'جوالي (165,000 ر.ي)'],
  ),
  TransactionRecord(
    transactionId: 'TX-8843',
    date: '2026-09-07 20:10',
    totalAmount: 185000,
    usedWallets: ['محفظة كاش (185,000 ر.ي)'],
  ),
];

// =============================================================
// 2. شاشة تسجيل الدخول المستقبلي (Futuristic Login)
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0F16), Color(0xFF1B1E2E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF161B26),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF00F2FE).withOpacity(0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF00F2FE).withOpacity(0.2), blurRadius: 20, spreadRadius: 2),
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
                        color: const Color(0xFF00F2FE).withOpacity(0.1),
                        border: Border.all(color: const Color(0xFF00F2FE)),
                      ),
                      child: const Icon(Icons.bolt, size: 50, color: Color(0xFF00F2FE)),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'YEMEN EXPRESS CYBER',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Color(0xFF00F2FE),
                      ),
                    ),
                    const Text('بوابة الدفع الموحدة المتطورة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildRoleChip('عميل', 'CUSTOMER', Colors.cyan),
                        const SizedBox(width: 12),
                        _buildRoleChip('مدير النظام', 'ADMIN', Colors.purpleAccent),
                      ],
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'اسم المستخدم',
                        prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF00F2FE)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00F2FE))),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال اسم المستخدم' : null,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF00F2FE)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00F2FE))),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال كلمة المرور' : null,
                    ),
                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00F2FE),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 10,
                        ),
                        onPressed: _login,
                        child: const Text('تسجيل الدخول للنظام', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleChip(String label, String role, Color color) {
    bool selected = _userRole == role;
    return GestureDetector(
      onTap: () => setState(() => _userRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? color : Colors.grey.shade700, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(color: selected ? color : Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// =============================================================
// 3. متجر العملاء المستقبلي الشبكي (Futuristic Grid Store)
// =============================================================
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _selectedCategory = 'الكل';

  List<Product> get filteredProducts {
    if (_selectedCategory == 'الكل') return globalProducts;
    return globalProducts.where((p) => p.category == _selectedCategory).toList();
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
        content: Text('تم إضافة ${product.name} إلى السلة 🚀'),
        backgroundColor: const Color(0xFF00F2FE),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  void _openCartModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B26),
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
                    const Text('سلة التسوق الذكية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00F2FE))),
                    IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => Navigator.pop(ctx)),
                  ],
                ),
                const Divider(color: Colors.white24),

                if (globalCart.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_shopping_cart, size: 60, color: Colors.grey),
                          SizedBox(height: 10),
                          Text('السلة فارغة حالياً', style: TextStyle(color: Colors.grey)),
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
                          color: const Color(0xFF0D0F16),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: Text(item.product.icon, style: const TextStyle(fontSize: 28)),
                            title: Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${(item.product.price * item.quantity).toStringAsFixed(0)} ر.ي', style: const TextStyle(color: Color(0xFF00F2FE))),
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
                                Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                                // زر إلغاء المنتج كاملاً من السلة
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
                  const Divider(color: Colors.white24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('الإجمالي الفعلي:', style: TextStyle(fontSize: 16)),
                      Text('${total.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00F2FE))),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F2FE), foregroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SplitPaymentScreen(totalInvoiceAmount: total)),
                        );
                      },
                      child: const Text('الانتقال للبوابة والدفع المقسّم 💳', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B26),
        title: const Text('متجر يمن إكسبرس المستقبلي', style: TextStyle(color: Color(0xFF00F2FE), fontSize: 18)),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF00F2FE), size: 28),
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
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen())),
          )
        ],
      ),
      body: Column(
        children: [
          // شريط الأقسام المبتكر
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (ctx, i) {
                final cat = categories[i];
                bool isSelected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF00F2FE).withOpacity(0.2) : const Color(0xFF161B26),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? const Color(0xFF00F2FE) : Colors.white10),
                    ),
                    child: Text(cat, style: TextStyle(color: isSelected ? const Color(0xFF00F2FE) : Colors.grey, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ),

          // عرض المنتجات بشكل شبكي (Grid Layout - 2 Columns)
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
                    color: const Color(0xFF161B26),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, spreadRadius: 1),
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
                              color: const Color(0xFF0D0F16),
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
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product.price.toStringAsFixed(0)} ر.ي',
                          style: const TextStyle(color: Color(0xFF00F2FE), fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00F2FE).withOpacity(0.15),
                              foregroundColor: const Color(0xFF00F2FE),
                              side: const BorderSide(color: Color(0xFF00F2FE)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => _addToCart(product),
                            child: const Text('إضافة للسلة', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
// 4. لوحة تحكم مدير النظام المتطورة (Admin Analytics & Audit)
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
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(text: product != null ? product.price.toStringAsFixed(0) : '');
    final iconController = TextEditingController(text: product?.icon ?? '📦');
    String selectedCat = product?.category ?? categories[1];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161B26),
        title: Text(product == null ? 'إضافة منتج سايبر جديد' : 'تعديل المنتج', style: const TextStyle(color: Color(0xFF00F2FE))),
        content: StatefulBuilder(
          builder: (context, setDlgState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'اسم المنتج')),
              TextField(controller: priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'السعر (ر.ي)')),
              TextField(controller: iconController, decoration: const InputDecoration(labelText: 'الرمز التعبيري الإيموجي')),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCat,
                isExpanded: true,
                dropdownColor: const Color(0xFF161B26),
                items: categories.where((c) => c != 'الكل').map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setDlgState(() => selectedCat = val!),
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F2FE), foregroundColor: Colors.black),
            onPressed: () {
              if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                setState(() {
                  if (product == null) {
                    globalProducts.add(Product(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      icon: iconController.text.isEmpty ? '📦' : iconController.text,
                      category: selectedCat,
                    ));
                  } else {
                    globalProducts[index!] = Product(
                      id: product.id,
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      icon: iconController.text,
                      category: selectedCat,
                    );
                  }
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('حفظ'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalRevenue = globalTransactions.fold(0, (sum, t) => sum + t.totalAmount);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B26),
        title: const Text('لوحة تحكم الأدمن - التحكم الشامل', style: TextStyle(color: Colors.purpleAccent, fontSize: 16)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.purpleAccent,
          tabs: const [
            Tab(icon: Icon(Icons.inventory_2_outlined), text: 'إدارة المنتجات'),
            Tab(icon: Icon(Icons.receipt_long_outlined), text: 'عمليات البيع والدفع'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen())),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. إدارة المنتجات
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purpleAccent,
              onPressed: () => _openProductDialog(),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: globalProducts.length,
              itemBuilder: (ctx, index) {
                final p = globalProducts[index];
                return Card(
                  color: const Color(0xFF161B26),
                  child: ListTile(
                    leading: Text(p.icon, style: const TextStyle(fontSize: 28)),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${p.price.toStringAsFixed(0)} ر.ي | القسم: ${p.category}', style: const TextStyle(color: Colors.purpleAccent)),
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

          // 2. سجل المبيعات والعمليات المالية
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Card(
                  color: const Color(0xFF161B26),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('إجمالي المبيعات المحصلة:', style: TextStyle(fontSize: 15)),
                        Text('${totalRevenue.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
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
                        color: const Color(0xFF161B26),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ExpansionTile(
                          leading: const Icon(Icons.verified_outlined, color: Colors.greenAccent),
                          title: Text('عملية رقم: ${tx.transactionId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('المبلغ: ${tx.totalAmount.toStringAsFixed(0)} ر.ي | التاريخ: ${tx.date}'),
                          children: tx.usedWallets.map((w) => ListTile(
                            dense: true,
                            leading: const Icon(Icons.subdirectory_arrow_right, color: Color(0xFF00F2FE)),
                            title: Text('محفظة الخصم: $w', style: const TextStyle(color: Colors.white70)),
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
// 5. واجهة الدفع المقسّم بأسلوب السايبر (Split Payment Gateway)
// =============================================================
class SplitPaymentScreen extends StatefulWidget {
  final double totalInvoiceAmount;
  const SplitPaymentScreen({super.key, required this.totalInvoiceAmount});

  @override
  State<SplitPaymentScreen> createState() => _SplitPaymentScreenState();
}

class _SplitPaymentScreenState extends State<SplitPaymentScreen> {
  final List<Map<String, dynamic>> _wallets = [
    {'id': 'kuraimi', 'name': 'كريمي إكسبرس (حاسب)', 'icon': '🏦', 'color': Colors.blue},
    {'id': 'jawali', 'name': 'محفظة جوالي', 'icon': '📱', 'color': Colors.purple},
    {'id': 'cash', 'name': 'محفظة كاش', 'icon': '💵', 'color': Colors.green},
    {'id': 'floosak', 'name': 'محفظة فلوسك', 'icon': '💳', 'color': Colors.orange},
  ];

  final List<Map<String, dynamic>> _completedPayments = [];

  double get paidAmount => _completedPayments.fold(0, (sum, item) => sum + (item['amount'] as double));
  double get remainingAmount => widget.totalInvoiceAmount - paidAmount;

  void _payWithWallet(Map<String, dynamic> wallet) {
    if (remainingAmount <= 0) return;

    final amountController = TextEditingController(text: remainingAmount.toStringAsFixed(0));
    final phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B26),
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom + 20, top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('خصم عبر ${wallet['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00F2FE))),
            const SizedBox(height: 15),
            TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المبلغ المراد خصمه (ر.ي)')),
            TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'رقم الهاتف / المحفظة')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F2FE), foregroundColor: Colors.black),
                onPressed: () {
                  double val = double.tryParse(amountController.text) ?? 0;
                  if (val > 0 && val <= remainingAmount) {
                    setState(() {
                      _completedPayments.add({
                        'wallet': wallet['name'],
                        'amount': val,
                      });
                    });
                    Navigator.pop(ctx);
                    if (remainingAmount <= 0) _finishTransaction();
                  }
                },
                child: const Text('تأكيد العملية وتسجيل الخصم'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _finishTransaction() {
    // إضافتها إلى المبيعات العامة لمدير النظام
    globalTransactions.insert(0, TransactionRecord(
      transactionId: 'TX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      date: DateTime.now().toString().substring(0, 16),
      totalAmount: widget.totalInvoiceAmount,
      usedWallets: _completedPayments.map((e) => "${e['wallet']} (${(e['amount'] as double).toStringAsFixed(0)} ر.ي)").toList(),
    ));

    globalCart.clear(); // تفريغ السلة

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161B26),
        title: const Column(
          children: [
            Icon(Icons.check_circle_outline, color: Color(0xFF00F2FE), size: 60),
            SizedBox(height: 10),
            Text('اكتملت عملية السداد!', style: TextStyle(color: Color(0xFF00F2FE))),
          ],
        ),
        content: const Text('تم استيفاء كامل المبلغ بنجاح عبر بوابة يمن إكسبرس الموحدة وتسجيل العملية.'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F2FE), foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('العودة للمتجر الرئيسي'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF161B26), title: const Text('بوابة الدفع المقسّم الذكية')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161B26),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF00F2FE).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الفاتورة الكلية:'), Text('${widget.totalInvoiceAmount.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
                  const SizedBox(height: 5),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('المسدد:'), Text('${paidAmount.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: Colors.greenAccent))]),
                  const Divider(color: Colors.white24),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('المتبقي للسداد:'), Text('${remainingAmount.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold))]),
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
                    color: const Color(0xFF161B26),
                    child: ListTile(
                      leading: Text(w['icon'], style: const TextStyle(fontSize: 26)),
                      title: Text(w['name']),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F2FE), foregroundColor: Colors.black),
                        onPressed: remainingAmount <= 0 ? null : () => _payWithWallet(w),
                        child: const Text('خصم دفعة'),
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
