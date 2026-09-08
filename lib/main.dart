import 'package:flutter/material.dart';

void main() {
  runApp(const YemenExpressApp());
}

class YemenExpressApp extends StatelessWidget {
  const YemenExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'بوابة يمن إكسبرس الموحدة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Arial',
        useMaterial3: false,
      ),
      home: const LoginScreen(),
    );
  }
}

// =============================================================
// 1. إدارة البيانات العامة (Global State)
// =============================================================
class Product {
  String id;
  String name;
  double price;
  String icon;

  Product({required this.id, required this.name, required this.price, required this.icon});
}

// قائمة المنتجات العشرة المجهزة مسبقاً بالريال اليمني
List<Product> globalProductsList = [
  Product(id: '1', name: 'لابتوب ديل إتش بي متطور', price: 450000, icon: '💻'),
  Product(id: '2', name: 'هاتف سامسونج جالاكسي', price: 280000, icon: '📱'),
  Product(id: '3', name: 'ساعة يد ذكية', price: 35000, icon: '⌚'),
  Product(id: '4', name: 'سماعات أذن لاسلكية', price: 18000, icon: '🎧'),
  Product(id: '5', name: 'شاشة تلفزيون 55 بوصة 4K', price: 320000, icon: '📺'),
  Product(id: '6', name: 'كاميرا تصوير احترافية', price: 520000, icon: '📷'),
  Product(id: '7', name: 'جهاز راوتر إنترنت فضائي', price: 65000, icon: '📡'),
  Product(id: '8', name: 'منظومة طاقة شمسية 200W', price: 185000, icon: '☀️'),
  Product(id: '9', name: 'لوحة مفاتيح وماوس جيمنج', price: 22000, icon: '⌨️'),
  Product(id: '10', name: 'بن يمني خولاني فاخر (1 كجم)', price: 12000, icon: '☕'),
];

// =============================================================
// 2. شاشة تسجيل الدخول (Login Screen)
// =============================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userType = 'CUSTOMER';
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_userType == 'ADMIN') {
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
      backgroundColor: Colors.teal.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_balance_wallet, size: 60, color: Colors.teal),
                    const SizedBox(height: 10),
                    Text(
                      _isLogin ? 'يمن إكسبرس للدفع الموحد' : 'إنشاء حساب جديد',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text('عميل'),
                          selected: _userType == 'CUSTOMER',
                          onSelected: (val) => setState(() => _userType = 'CUSTOMER'),
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text('مدير النظام'),
                          selected: _userType == 'ADMIN',
                          selectedColor: Colors.orange.shade300,
                          onSelected: (val) => setState(() => _userType = 'ADMIN'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'اسم المستخدم',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'يرجى إدخال اسم المستخدم' : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'يرجى إدخال كلمة المرور' : null,
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _userType == 'ADMIN' ? Colors.orange.shade800 : Colors.teal,
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          _isLogin ? 'تسجيل الدخول' : 'إنشاء الحساب والتسجيل',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: Text(
                        _isLogin ? 'ليس لديك حساب؟ إنشاء حساب جديد' : 'لديك حساب بالفعل؟ تسجيل الدخول',
                        style: const TextStyle(color: Colors.teal),
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
}

// =============================================================
// 3. لوحة تحكم مدير النظام (إضافة / تعديل / حذف منتجات)
// =============================================================
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  void _openProductDialog({Product? product, int? index}) {
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(text: product != null ? product.price.toStringAsFixed(0) : '');
    final iconController = TextEditingController(text: product?.icon ?? '📦');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product == null ? 'إضافة منتج جديد' : 'تعديل المنتج'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم المنتج'),
                validator: (v) => (v == null || v.isEmpty) ? 'أدخل اسم المنتج' : null,
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'السعر (بالريال اليمني)'),
                validator: (v) => (v == null || v.isEmpty) ? 'أدخل السعر' : null,
              ),
              TextFormField(
                controller: iconController,
                decoration: const InputDecoration(labelText: 'الرمز التعبيري / الإيموجي'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  if (product == null) {
                    globalProductsList.add(
                      Product(
                        id: DateTime.now().toString(),
                        name: nameController.text,
                        price: double.parse(priceController.text),
                        icon: iconController.text.isEmpty ? '📦' : iconController.text,
                      ),
                    );
                  } else {
                    globalProductsList[index!] = Product(
                      id: product.id,
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      icon: iconController.text,
                    );
                  }
                });
                Navigator.pop(ctx);
              }
            },
            child: Text(product == null ? 'إضافة' : 'حفظ التعديل'),
          ),
        ],
      ),
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      globalProductsList.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف المنتج بنجاح')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الأدمن - إدارة المنتجات'),
        backgroundColor: Colors.orange.shade800,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade800,
        onPressed: () => _openProductDialog(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: globalProductsList.length,
        itemBuilder: (ctx, index) {
          final p = globalProductsList[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Text(p.icon, style: const TextStyle(fontSize: 28)),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${p.price.toStringAsFixed(0)} ر.ي'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _openProductDialog(product: p, index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =============================================================
// 4. متجر العملاء والسلة (Store Screen)
// =============================================================
class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<Product> _cart = [];

  double get totalAmount => _cart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر يمن إكسبرس الرقمي'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: globalProductsList.length,
        itemBuilder: (ctx, i) {
          final p = globalProductsList[i];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: Text(p.icon, style: const TextStyle(fontSize: 30)),
              title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${p.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  setState(() => _cart.add(p));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم إضافة ${p.name} للسلة'), duration: const Duration(milliseconds: 700)),
                  );
                },
                child: const Text('إضافة للسلة'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              color: Colors.teal.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجمالي: ${totalAmount.toStringAsFixed(0)} ر.ي',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplitPaymentScreen(totalInvoiceAmount: totalAmount),
                        ),
                      );
                    },
                    child: const Text('الانتقال للبوابة والدفع المقسّم'),
                  )
                ],
              ),
            ),
    );
  }
}

// =============================================================
// 5. بوابة يمن إكسبرس الموحدة والدفع المقسّم
// =============================================================
class Wallet {
  final String id;
  final String name;
  final String icon;
  final Color color;

  Wallet({required this.id, required this.name, required this.icon, required this.color});
}

class CompletedPart {
  final String walletName;
  final double amount;
  final String phone;

  CompletedPart({required this.walletName, required this.amount, required this.phone});
}

class SplitPaymentScreen extends StatefulWidget {
  final double totalInvoiceAmount;
  const SplitPaymentScreen({super.key, required this.totalInvoiceAmount});

  @override
  State<SplitPaymentScreen> createState() => _SplitPaymentScreenState();
}

class _SplitPaymentScreenState extends State<SplitPaymentScreen> {
  final List<Wallet> _wallets = [
    Wallet(id: 'kuraimi', name: 'كريمي إكسبرس (حاسب)', icon: '🏦', color: Colors.blue.shade800),
    Wallet(id: 'jawali', name: 'محفظة جوالي', icon: '📱', color: Colors.purple),
    Wallet(id: 'cash', name: 'محفظة كاش', icon: '💵', color: Colors.green),
    Wallet(id: 'floosak', name: 'محفظة فلوسك', icon: '💳', color: Colors.orange.shade800),
  ];

  final List<CompletedPart> _paidParts = [];

  double get totalPaid => _paidParts.fold(0, (sum, i) => sum + i.amount);
  double get remainingAmount => widget.totalInvoiceAmount - totalPaid;

  void _openPaymentModal(Wallet wallet) {
    if (remainingAmount <= 0) return;

    final amountController = TextEditingController(text: remainingAmount.toStringAsFixed(0));
    final phoneController = TextEditingController();
    final pinController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تأكيد الخصم عبر ${wallet.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                const SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'المبلغ المراد خصمه (ر.ي)',
                    helperText: 'المتبقي من الفاتورة: ${remainingAmount.toStringAsFixed(0)} ر.ي',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'أدخل المبلغ';
                    double? parsed = double.tryParse(v);
                    if (parsed == null || parsed <= 0) return 'مبلغ غير صحيح';
                    if (parsed > remainingAmount) return 'يتجاوز المتبقي';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'رقم المحفظة / الموبايل', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.length < 9) ? 'أدخل رقم هاتف صحيح' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'رمز التأكيد OTP / PIN', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'أدخل الرمز' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: wallet.color),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          _paidParts.add(
                            CompletedPart(
                              walletName: wallet.name,
                              amount: double.parse(amountController.text),
                              phone: phoneController.text,
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                        if (remainingAmount <= 0) {
                          _showSuccessDialog();
                        }
                      }
                    },
                    child: const Text('تأكيد خصم الدفعة', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 10),
            Text('تم السداد بنجاح!'),
          ],
        ),
        content: Text('تم استيفاء كامل الفاتورة (${widget.totalInvoiceAmount.toStringAsFixed(0)} ر.ي) بنجاح عبر يمن إكسبرس.'),
        actions: [
          TextButton(
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
    double progress = totalPaid / widget.totalInvoiceAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('بوابة يمن إكسبرس - الدفع المقسّم'),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('إجمالي الفاتورة:'),
                        Text('${widget.totalInvoiceAmount.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المدفوع:', style: TextStyle(color: Colors.green)),
                        Text('${totalPaid.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المتبقي:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        Text('${remainingAmount.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: progress > 1 ? 1 : progress, minHeight: 8, color: Colors.teal),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            if (_paidParts.isNotEmpty) ...[
              const Text('العمليات المكتملة لهذه الفاتورة:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _paidParts.length,
                  itemBuilder: (c, i) => Card(
                    color: Colors.green.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('${_paidParts[i].walletName}: ${_paidParts[i].amount.toStringAsFixed(0)} ر.ي'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],

            const Text('اختر المحفظة المراد الدفع منها وتحديد المبلغ:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: _wallets.length,
                itemBuilder: (ctx, i) {
                  final w = _wallets[i];
                  return Card(
                    child: ListTile(
                      leading: Text(w.icon, style: const TextStyle(fontSize: 24)),
                      title: Text(w.name),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: w.color),
                        onPressed: remainingAmount <= 0 ? null : () => _openPaymentModal(w),
                        child: const Text('تخصيص مبلغ والدفع', style: TextStyle(color: Colors.white)),
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
