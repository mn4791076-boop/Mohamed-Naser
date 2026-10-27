import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Cyber System',
    localizationsDelegates: [
      DefaultMaterialLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('ar', 'AE'), 
    ],
    locale: Locale('ar', 'AE'),
    home: ActivationScreen(),
  ));
}

// 🔐 كود التفعيل التجاري الخاص بك
const String masterActivationCode = 'Mohamed 200901281371307';

// شاشة التفعيل والتحقق من الرخصة التجارية قبل تشغيل التطبيق
class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final _codeController = TextEditingController();

  void _verifyActivationCode() {
    if (_codeController.text.trim() == masterActivationCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تفعيل النسخة التجارية بنجاح!'), backgroundColor: Colors.green),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كود التفعيل غير صحيح! يرجى التواصل مع المطور.'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 80, color: Colors.amber),
                  const SizedBox(height: 16),
                  const Text(
                    'تفعيل النسخة التجارية',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'برجاء إدخال كود التفعيل الممنوح لك من المطور لتشغيل نظام السايبر.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: 'كود التفعيل الخاص بك',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.amber[700],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _verifyActivationCode,
                    child: const Text('تفعيل التطبيق الآن', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

// نموذج بيانات الجهاز
class DeviceModel {
  String name;
  String type; // بلايستيشن أو بي سي
  bool isAvailable;
  String? currentCustomer;

  DeviceModel({
    required this.name,
    required this.type,
    this.isAvailable = true,
    this.currentCustomer,
  });
}

// نموذج حساب صاحب السايبر
class ShopAccount {
  String phone;
  String password;
  String shopName;
  String instapay;
  String vodafoneCash;
  List<DeviceModel> devices;
  List<BookingNotification> notifications;

  ShopAccount({
    required this.phone,
    required this.password,
    required this.shopName,
    required this.instapay,
    required this.vodafoneCash,
    required this.devices,
    required this.notifications,
  });
}

// نموذج الإشعارات والحجوزات
class BookingNotification {
  String id;
  String customerName;
  String customerSenderInfo; // رقم التليفون أو حساب إنستا باي للزبون
  String deviceName;
  String paymentMethod; // نقدي (كاش) , فودافون كاش , إنستا باي
  double amount;
  bool isPaid;

  BookingNotification({
    required this.id,
    required this.customerName,
    required this.customerSenderInfo,
    required this.deviceName,
    required this.paymentMethod,
    required this.amount,
    this.isPaid = false,
  });
}

class AppData {
  static List<ShopAccount> registeredShops = [
    ShopAccount(
      phone: '01000000000',
      password: '123',
      shopName: 'سايبر الألعاب المركزي',
      instapay: 'cyber.central@instapay',
      vodafoneCash: '01000000000',
      devices: [
        DeviceModel(name: 'PlayStation 5 - 1', type: 'بلايستيشن', isAvailable: true),
        DeviceModel(name: 'PC Gaming 1', type: 'بي سي', isAvailable: true),
        DeviceModel(name: 'PlayStation 5 - 2', type: 'بلايستيشن', isAvailable: false, currentCustomer: 'أحمد'),
      ],
      notifications: [],
    )
  ];
  static ShopAccount? currentOwnerShop;
}

// 1. شاشة اختيار تحديد الهوية (صاحب سايبر أم زبون)
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام السايبر الذكي', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sports_esports, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const OwnerLoginScreen()));
                },
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('الدخول كصاحب سايبر', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CustomerBookingScreen(shop: AppData.registeredShops.first),
                    ),
                  );
                },
                icon: const Icon(Icons.person),
                label: const Text('الدخول كزبون (حجز جهاز)', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. شاشة تسجيل دخول صاحب السايبر
class OwnerLoginScreen extends StatefulWidget {
  const OwnerLoginScreen({super.key});

  @override
  State<OwnerLoginScreen> createState() => _OwnerLoginScreenState();
}

class _OwnerLoginScreenState extends State<OwnerLoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final shop = AppData.registeredShops.firstWhere(
      (element) => element.phone == _phoneController.text && element.password == _passwordController.text,
      orElse: () => ShopAccount(phone: '', password: '', shopName: '', instapay: '', vodafoneCash: '', devices: [], notifications: []),
    );

    if (shop.phone.isNotEmpty) {
      AppData.currentOwnerShop = shop;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OwnerDashboardScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('بيانات الدخول غير صحيحة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دخول الإدارة'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'رقم الهاتف', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'كلمة المرور', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: _login,
              child: const Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. لوحة تحكم صاحب السايبر (الأجهزة والإشعارات)
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final shop = AppData.currentOwnerShop!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(shop.shopName),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddDeviceDialog(context);
              },
              tooltip: 'إضافة جهاز جديد',
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.devices), text: 'الأجهزة'),
              Tab(icon: Icon(Icons.notifications), text: 'طلبات الحجز'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: shop.devices.length,
              itemBuilder: (context, index) {
                final device = shop.devices[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(device.type == 'بي سي' ? Icons.computer : Icons.gamepad, color: Colors.deepPurple),
                    title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(device.isAvailable ? 'متاح حالياً' : 'مشغول مع: ${device.currentCustomer}'),
                    trailing: Switch(
                      value: device.isAvailable,
                      onChanged: (val) {
                        setState(() {
                          device.isAvailable = val;
                          if (val) device.currentCustomer = null;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            shop.notifications.isEmpty
                ? const Center(child: Text('لا توجد طلبات حجز حالياً'))
                : ListView.builder(
                    itemCount: shop.notifications.length,
                    itemBuilder: (context, index) {
                      final notif = shop.notifications[index];
                      return Card(
                        color: notif.isPaid ? Colors.green.shade50 : Colors.orange.shade50,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('طلب من: ${notif.customerName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('حجز: ${notif.deviceName}\nطريقة الدفع: ${notif.paymentMethod} (${notif.amount} ج.م)\nمرسل من: ${notif.customerSenderInfo}'),
                          isThreeLine: true,
                          trailing: notif.isPaid
                              ? const Chip(label: Text('تم الدفع', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green)
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      notif.isPaid = true;
                                      final device = shop.devices.firstWhere((d) => d.name == notif.deviceName);
                                      device.isAvailable = false;
                                      device.currentCustomer = notif.customerName;
                                    });
                                  },
                                  child: const Text('تأكيد الدفع'),
                                ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void _showAddDeviceDialog(BuildContext context) {
    final nameController = TextEditingController();
    String type = 'بلايستيشن';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة جهاز جديد'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الجهاز (مثال: PS5 - 3)'),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: type,
                items: const [
                  DropdownMenuItem(value: 'بلايستيشن', child: Text('بلايستيشن')),
                  DropdownMenuItem(value: 'بي سي', child: Text('بي سي')),
                ],
                onChanged: (val) {
                  if (val != null) type = val;
                },
                decoration: const InputDecoration(labelText: 'نوع الجهاز'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    AppData.registeredShops.first.devices.add(
                      DeviceModel(name: nameController.text, type: type, isAvailable: true),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('إضافة'),
            ),
          ],
        );
      },
    );
  }
}

// 4. شاشة حجز الزبون للجهاز والدفع
class CustomerBookingScreen extends StatefulWidget {
  final ShopAccount shop;
  const CustomerBookingScreen({super.key, required this.shop});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  DeviceModel? selectedDevice;
  final nameController = TextEditingController();
  final senderInfoController = TextEditingController();
  String paymentMethod = 'فودافون كاش';
  double amount = 50.0;

  void _submitBooking() {
    if (selectedDevice == null || nameController.text.isEmpty || senderInfoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك أكمل جميع البيانات واختار الجهاز')),
      );
      return;
    }

    final notif = BookingNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: nameController.text,
      customerSenderInfo: senderInfoController.text,
      deviceName: selectedDevice!.name,
      paymentMethod: paymentMethod,
      amount: amount,
      isPaid: false,
    );

    widget.shop.notifications.add(notif);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم إرسال الطلب بنجاح'),
        content: Text('تم إرسال طلب حجز ${selectedDevice!.name} إلى صاحب السايبر.\nبرجاء تحويل مبلغ $amount ج.م إلى:\n\n$paymentMethod: ${paymentMethod == 'فودافون كاش' ? widget.shop.vodafoneCash : widget.shop.instapay}'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('حسناً'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableDevices = widget.shop.devices.where((d) => d.isAvailable).toList();

    return Scaffold(
      appBar: AppBar(title: Text('حجز في ${widget.shop.shopName}'), backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'اسمك الكريم', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: senderInfoController,
              decoration: const InputDecoration(labelText: 'رقم هاتفك أو حساب إنستا باي المحول منه', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text('اختر الجهاز المتاح:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            availableDevices.isEmpty
                ? const Text('عذراً، لا توجد أجهزة متاحة للحجز حالياً في هذا السايبر.', style: TextStyle(color: Colors.red))
                : Column(
                    children: availableDevices.map((device) {
                      return RadioListTile<DeviceModel>(
                        title: Text(device.name),
                        subtitle: Text('النوع: ${device.type}'),
                        value: device,
                        groupValue: selectedDevice,
                        onChanged: (val) {
                          setState(() {
                            selectedDevice = val;
                          });
                        },
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
            const Text('طريقة الدفع:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            DropdownButtonFormField<String>(
              value: paymentMethod,
              items: const [
                DropdownMenuItem(value: 'فودافون كاش', child: Text('فودافون كاش')),
                DropdownMenuItem(value: 'إنستا باي (InstaPay)', child: Text('إنستا باي (InstaPay)')),
                DropdownMenuItem(value: 'نقدي (كاش بالمكان)', child: Text('نقدي (كاش بالمكان)')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => paymentMethod = val);
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
              child: Text(
                paymentMethod == 'فودافون كاش'
                    ? 'رقم فودافون كاش للتحويل: ${widget.shop.vodafoneCash}'
                    : paymentMethod == 'إنستا باي (InstaPay)'
                        ? 'عنوان إنستا باي للتحويل: ${widget.shop.instapay}'
                        : 'يرجى الدفع كاش عند الوصول لمسؤول السايبر.',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
              onPressed: _submitBooking,
              child: const Text('تأكيد وإرسال طلب الحجز', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
