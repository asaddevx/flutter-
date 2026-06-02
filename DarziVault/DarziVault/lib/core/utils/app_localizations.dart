import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isUrdu => locale.languageCode == 'ur';

  // Common strings
  String get appName => isUrdu ? 'درزی والٹ' : 'DarziVault';
  String get home => isUrdu ? 'ہوم' : 'Home';
  String get clients => isUrdu ? 'گاہک' : 'Clients';
  String get orders => isUrdu ? 'آرڈرز' : 'Orders';
  String get reports => isUrdu ? 'رپورٹس' : 'Reports';
  String get settings => isUrdu ? 'ترتیبات' : 'Settings';
  
  // Dashboard
  String get totalClients => isUrdu ? 'کل گاہک' : 'Total Clients';
  String get totalOrders => isUrdu ? 'کل آرڈرز' : 'Total Orders';
  String get activeOrders => isUrdu ? 'فعال آرڈرز' : 'Active Orders';
  String get overdue => isUrdu ? 'تاخیر' : 'Overdue';
  String get totalRevenue => isUrdu ? 'کل آمدنی' : 'Total Revenue';
  String get pendingRevenue => isUrdu ? 'باقی آمدنی' : 'Pending Revenue';
  String get quickActions => isUrdu ? 'فوری اعمال' : 'Quick Actions';
  String get newOrder => isUrdu ? 'نیا آرڈر' : 'New Order';
  String get addClient => isUrdu ? 'گاہک شامل کریں' : 'Add Client';
  String get seeAll => isUrdu ? 'سب دیکھیں' : 'See All';
  String get recentClients => isUrdu ? 'حالیہ گاہک' : 'Recent Clients';
  
  // Actions
  String get add => isUrdu ? 'شامل کریں' : 'Add';
  String get edit => isUrdu ? 'ترمیم' : 'Edit';
  String get delete => isUrdu ? 'حذف کریں' : 'Delete';
  String get save => isUrdu ? 'محفوظ کریں' : 'Save';
  String get cancel => isUrdu ? 'منسوخ' : 'Cancel';
  String get search => isUrdu ? 'تلاش کریں' : 'Search';
  String get view => isUrdu ? 'دیکھیں' : 'View';
  String get close => isUrdu ? 'بند کریں' : 'Close';
  String get yes => isUrdu ? 'ہاں' : 'Yes';
  String get no => isUrdu ? 'نہیں' : 'No';
  String get ok => isUrdu ? 'ٹھیک ہے' : 'OK';
  
  // Settings
  String get theme => isUrdu ? 'تھیم' : 'Theme';
  String get language => isUrdu ? 'زبان' : 'Language';
  String get shopProfile => isUrdu ? 'دکان کی معلومات' : 'Shop Profile';
  String get light => isUrdu ? 'روشن' : 'Light';
  String get dark => isUrdu ? 'تاریک' : 'Dark';
  String get system => isUrdu ? 'سسٹم' : 'System';
  String get english => isUrdu ? 'انگریزی' : 'English';
  String get urdu => isUrdu ? 'اردو' : 'Urdu';
  String get appearance => isUrdu ? 'شکل' : 'Appearance';
  String get selectTheme => isUrdu ? 'تھیم منتخب کریں' : 'Select Theme';
  String get selectLanguage => isUrdu ? 'زبان منتخب کریں' : 'Select Language';
  String get dataManagement => isUrdu ? 'ڈیٹا کا انتظام' : 'Data Management';
  String get exportData => isUrdu ? 'ڈیٹا برآمد کریں' : 'Export Data';
  String get exportAllDataAsCsv => isUrdu ? 'تمام ڈیٹا CSV کے طور پر برآمد کریں' : 'Export all data as CSV';
  String get clearAllData => isUrdu ? 'تمام ڈیٹا صاف کریں' : 'Clear All Data';
  String get deleteAllClientsOrdersMeasurements => isUrdu ? 'تمام گاہکوں، آرڈرز اور پیمائشوں کو حذف کریں' : 'Delete all clients, orders & measurements';
  String get about => isUrdu ? 'کے بارے میں' : 'About';
  String get tailorShopManagement => isUrdu ? 'درزی کی دکان کا انتظام' : 'Tailor Shop Management';
  String get builtWithFlutter => isUrdu ? 'Flutter سے بنایا گیا' : 'Built with Flutter';
  String get offlineFirstPrivacyFocused => isUrdu ? 'آف لائن فرسٹ، رازداری پر مبنی' : 'Offline-first, Privacy-focused';
  String get shopName => isUrdu ? 'دکان کا نام' : 'Shop Name';
  String get ownerName => isUrdu ? 'مالک کا نام' : 'Owner Name';
  String get phone => isUrdu ? 'فون' : 'Phone';
  String get address => isUrdu ? 'پتہ' : 'Address';
  String get email => isUrdu ? 'ای میل' : 'Email';
  String get profileSaved => isUrdu ? 'پروفائل محفوظ ہو گیا' : 'Profile saved';
  String get shopNameAndOwnerRequired => isUrdu ? 'دکان کا نام اور مالک کا نام ضروری ہیں' : 'Shop name and owner name are required';
  
  // Clients
  String get client => isUrdu ? 'گاہک' : 'Client';
  String get addNewClient => isUrdu ? 'نیا گاہک شامل کریں' : 'Add New Client';
  String get editClient => isUrdu ? 'گاہک میں ترمیم کریں' : 'Edit Client';
  String get fullName => isUrdu ? 'پورا نام' : 'Full Name';
  String get phoneNumber => isUrdu ? 'فون نمبر' : 'Phone Number';
  String get cnic => isUrdu ? 'شناختی کارڈ' : 'CNIC';
  String get cnicOptional => isUrdu ? 'شناختی کارڈ (اختیاری)' : 'CNIC (Optional)';
  String get addressOptional => isUrdu ? 'پتہ (اختیاری)' : 'Address (Optional)';
  String get time => isUrdu ? 'وقت' : 'Time';
  String get notes => isUrdu ? 'نوٹس' : 'Notes';
  String get notesOptional => isUrdu ? 'نوٹس / خاص ترجیحات (اختیاری)' : 'Notes / Special Preferences (Optional)';
  String get gender => isUrdu ? 'جنس' : 'Gender';
  String get male => isUrdu ? 'مرد' : 'Male';
  String get female => isUrdu ? 'عورت' : 'Female';
  String get clientAdded => isUrdu ? 'گاہک شامل ہو گیا' : 'Client added successfully';
  String get clientUpdated => isUrdu ? 'گاہک کی معلومات محفوظ ہو گئیں' : 'Client updated successfully';
  String get phoneAlreadyExists => isUrdu ? 'یہ فون نمبر پہلے سے موجود ہے' : 'Phone number already exists for another client';
  String get noClientsYet => isUrdu ? 'ابھی کوئی گاہک نہیں' : 'No clients yet';
  String get tapToAddFirst => isUrdu ? 'پہلا گاہک شامل کرنے کے لیے ٹیپ کریں' : 'Tap + to add your first client';
  String get deleteClient => isUrdu ? 'گاہک حذف کریں' : 'Delete Client';
  String get deleteClientConfirm => isUrdu ? 'کیا آپ واقعی اس گاہک کو حذف کرنا چاہتے ہیں؟' : 'Are you sure you want to delete this client?';
  String get deleteClientWarning => isUrdu ? 'اس سے ان کی تمام پیمائشیں اور آرڈرز بھی حذف ہو جائیں گے۔ یہ عمل واپس نہیں کیا جا سکتا۔' : 'This will also delete all their measurements and orders. This cannot be undone.';
  String get clientDeleted => isUrdu ? 'گاہک حذف ہو گیا' : 'Client deleted';
  
  // Share PDF
  String get sharePdf => isUrdu ? 'پی ڈی ایف شیئر کریں' : 'Share PDF';
  String get fullProfile => isUrdu ? 'مکمل پروفائل' : 'Full Profile';
  String get fullProfileDescription => isUrdu ? 'گاہک کی معلومات، پیمائشیں اور آرڈرز' : 'Client info, measurements & orders';
  String get measurementsOnly => isUrdu ? 'صرف پیمائشیں' : 'Measurements Only';
  String get measurementsDescription => isUrdu ? 'تمام پیمائشیں کی تفصیلات' : 'All measurements details';
  String get ordersOnly => isUrdu ? 'صرف آرڈرز' : 'Orders Only';
  String get ordersDescription => isUrdu ? 'تمام آرڈرز کی تاریخ' : 'All orders history';
  
  // PDF Content
  String get clientInformation => isUrdu ? 'گاہک کی معلومات' : 'Client Information';
  String get garmentType => isUrdu ? 'گارمنٹ کی قسم' : 'Garment Type';
  String get color => isUrdu ? 'رنگ' : 'Color';
  String get fabric => isUrdu ? 'کپڑا' : 'Fabric';
  String get defaultMeasurement => isUrdu ? 'پہلے سے طے شدہ' : 'Default';
  String get thankYou => isUrdu ? 'آپ کے کاروبار کا شکریہ!' : 'Thank you for your business!';
  String get contact => isUrdu ? 'رابطہ' : 'Contact';
  String get generatedBy => isUrdu ? 'درزی والٹ کے ذریعے تیار' : 'Generated by DarziVault';
  
  // Orders
  String get order => isUrdu ? 'آرڈر' : 'Order';
  String get createOrder => isUrdu ? 'نیا آرڈر بنائیں' : 'Create Order';
  String get editOrder => isUrdu ? 'آرڈر میں ترمیم کریں' : 'Edit Order';
  String get orderDetails => isUrdu ? 'آرڈر کی تفصیلات' : 'Order Details';
  String get payment => isUrdu ? 'ادائیگی' : 'Payment';
  String get viewClientProfile => isUrdu ? 'گاہک کا پروفائل دیکھیں' : 'View Client Profile';
  String get created => isUrdu ? 'بنایا گیا' : 'Created';
  String get selectClient => isUrdu ? 'گاہک منتخب کریں' : 'Select Client';
  String get selectMeasurement => isUrdu ? 'پیمائش منتخب کریں' : 'Select Measurement';
  String get itemType => isUrdu ? 'شے کی قسم' : 'Item Type';
  String get quantity => isUrdu ? 'تعداد' : 'Quantity';
  String get price => isUrdu ? 'قیمت' : 'Price';
  String get advancePayment => isUrdu ? 'پیشگی ادائیگی' : 'Advance Payment';
  String get deliveryDate => isUrdu ? 'ترسیل کی تاریخ' : 'Delivery Date';
  String get status => isUrdu ? 'حالت' : 'Status';
  String get pending => isUrdu ? 'زیرِ التواء' : 'Pending';
  String get inProgress => isUrdu ? 'جاری ہے' : 'In Progress';
  String get completed => isUrdu ? 'مکمل ہو گیا' : 'Completed';
  String get ready => isUrdu ? 'تیار' : 'Ready';
  String get delivered => isUrdu ? 'پہنچا دیا گیا' : 'Delivered';
  String get cancelled => isUrdu ? 'منسوخ' : 'Cancelled';
  String get totalAmount => isUrdu ? 'کل رقم' : 'Total Amount';
  String get paidAmount => isUrdu ? 'ادا شدہ رقم' : 'Paid Amount';
  String get remainingAmount => isUrdu ? 'باقی رقم' : 'Remaining Amount';
  String get orderCreated => isUrdu ? 'آرڈر بن گیا' : 'Order created successfully';
  String get orderUpdated => isUrdu ? 'آرڈر محفوظ ہو گیا' : 'Order updated successfully';
  String get noOrdersYet => isUrdu ? 'ابھی کوئی آرڈر نہیں' : 'No orders yet';
  String get deleteOrder => isUrdu ? 'آرڈر حذف کریں' : 'Delete Order';
  String get deleteOrderConfirm => isUrdu ? 'کیا آپ واقعی اس آرڈر کو حذف کرنا چاہتے ہیں؟' : 'Are you sure you want to delete this order?';
  String get orderDeleted => isUrdu ? 'آرڈر حذف ہو گیا' : 'Order deleted';
  
  // Reports
  String get reportsAndAnalytics => isUrdu ? 'رپورٹس اور تجزیات' : 'Reports & Analytics';
  String get overview => isUrdu ? 'جائزہ' : 'Overview';
  String get thisMonth => isUrdu ? 'اس ماہ' : 'This Month';
  String get newOrders => isUrdu ? 'نئے آرڈرز' : 'New Orders';
  String get revenue => isUrdu ? 'آمدنی' : 'Revenue';
  String get orderStatus => isUrdu ? 'آرڈر کی حالت' : 'Order Status';
  
  // Measurements
  String get measurements => isUrdu ? 'پیمائشیں' : 'Measurements';
  String get addMeasurement => isUrdu ? 'پیمائش شامل کریں' : 'Add Measurement';
  String get editMeasurement => isUrdu ? 'پیمائش میں ترمیم' : 'Edit Measurement';
  String get deleteMeasurement => isUrdu ? 'پیمائش حذف کریں' : 'Delete Measurement';
  String get upper => isUrdu ? 'اوپری' : 'Upper';
  String get lower => isUrdu ? 'نچلی' : 'Lower';
  String get general => isUrdu ? 'عمومی' : 'General';
  String get makeDefault => isUrdu ? 'بطور ڈیفالٹ بنائیں' : 'Make Default';
  String get noMeasurementsYet => isUrdu ? 'ابھی کوئی پیمائش نہیں' : 'No measurements yet';
  
  // Measurement Fields - Upper
  String get shoulder => isUrdu ? 'کندھا' : 'Shoulder';
  String get chest => isUrdu ? 'سینہ' : 'Chest';
  String get neck => isUrdu ? 'گلا' : 'Neck';
  String get frontLength => isUrdu ? 'سامنے کی لمبائی' : 'Front Length';
  String get backLength => isUrdu ? 'پیچھے کی لمبائی' : 'Back Length';
  String get armLength => isUrdu ? 'بازو کی لمبائی' : 'Arm Length';
  String get sleeveLength => isUrdu ? 'آستین کی لمبائی' : 'Sleeve Length';
  String get bicep => isUrdu ? 'بازو' : 'Bicep';
  String get forearm => isUrdu ? 'بازو کا نچلا حصہ' : 'Forearm';
  String get wrist => isUrdu ? 'کلائی' : 'Wrist';
  String get waist => isUrdu ? 'کمر' : 'Waist';
  
  // Measurement Fields - Lower
  String get hips => isUrdu ? 'کولہے' : 'Hips';
  String get inseam => isUrdu ? 'اندرونی سلائی' : 'Inseam';
  String get outseam => isUrdu ? 'بیرونی سلائی' : 'Outseam';
  String get thigh => isUrdu ? 'ران' : 'Thigh';
  String get knee => isUrdu ? 'گھٹنا' : 'Knee';
  String get calf => isUrdu ? 'پنڈلی' : 'Calf';
  String get ankle => isUrdu ? 'ٹخنہ' : 'Ankle';
  
  // Measurement Fields - General
  String get height => isUrdu ? 'قد' : 'Height';
  
  // Order Details
  String get selectGarment => isUrdu ? 'لباس کی قسم منتخب کریں' : 'Select Garment Type';
  String get totalPrice => isUrdu ? 'کل قیمت' : 'Total Price';
  String get balanceAmount => isUrdu ? 'باقی رقم' : 'Balance Amount';
  String get fabricDetails => isUrdu ? 'کپڑے کی تفصیل' : 'Fabric Details';
  String get colorPreference => isUrdu ? 'رنگ کی ترجیح' : 'Color Preference';
  String get selectDate => isUrdu ? 'تاریخ منتخب کریں' : 'Select Date';
  String get orderNotes => isUrdu ? 'آرڈر نوٹس' : 'Order Notes';
  
  // Report Sections
  String get orderStatusBreakdown => isUrdu ? 'آرڈر کی حالت کی تقسیم' : 'Order Status Breakdown';
  String get revenueByGarment => isUrdu ? 'لباس کی قسم کے حساب سے آمدنی' : 'Revenue by Garment';
  String get topGarments => isUrdu ? 'مقبول لباس' : 'Top Garments';
  String get noData => isUrdu ? 'کوئی ڈیٹا نہیں' : 'No data';
  String get thisWeek => isUrdu ? 'اس ہفتے' : 'This Week';
  String get thisYear => isUrdu ? 'اس سال' : 'This Year';
  String get allTime => isUrdu ? 'تمام وقت' : 'All Time';
  String get revenueOverview => isUrdu ? 'آمدنی کا جائزہ' : 'Revenue Overview';
  String get clientGrowth => isUrdu ? 'گاہکوں کی ترقی' : 'Client Growth';
  String get orderTrends => isUrdu ? 'آرڈرز کے رجحانات' : 'Order Trends';
  String get completionRate => isUrdu ? 'تکمیل کی شرح' : 'Completion Rate';
  String get averageOrderValue => isUrdu ? 'اوسط آرڈر قیمت' : 'Avg. Order Value';
  String get collectionRate => isUrdu ? 'وصولی کی شرح' : 'Collection Rate';
  String get topClients => isUrdu ? 'اعلی گاہک' : 'Top Clients';
  String get monthlyRevenue => isUrdu ? 'ماہانہ آمدنی' : 'Monthly Revenue';
  String get weeklyOrders => isUrdu ? 'ہفتہ وار آرڈرز' : 'Weekly Orders';
  String get performanceSummary => isUrdu ? 'کارکردگی کا خلاصہ' : 'Performance Summary';
  String get shareReport => isUrdu ? 'رپورٹ شیئر کریں' : 'Share Report';
  String get generatePdf => isUrdu ? 'پی ڈی ایف بنائیں' : 'Generate PDF';
  String get reportGenerated => isUrdu ? 'رپورٹ تیار ہو گئی' : 'Report generated';
  String get businessReport => isUrdu ? 'کاروباری رپورٹ' : 'Business Report';
  
  // Common
  String get all => isUrdu ? 'تمام' : 'All';
  String get done => isUrdu ? 'مکمل' : 'Done';
  String get notSet => isUrdu ? 'مقرر نہیں' : 'Not set';
  String get loading => isUrdu ? 'لوڈ ہو رہا ہے...' : 'Loading...';
  String get error => isUrdu ? 'خرابی' : 'Error';
  String get success => isUrdu ? 'کامیابی' : 'Success';
  String get required => isUrdu ? 'ضروری' : 'Required';
  String get optional => isUrdu ? 'اختیاری' : 'Optional';
  String get confirm => isUrdu ? 'تصدیق کریں' : 'Confirm';
  String get areYouSure => isUrdu ? 'کیا آپ کو یقین ہے؟' : 'Are you sure?';
  String get saveChanges => isUrdu ? 'تبدیلیاں محفوظ کریں' : 'Save Changes';
  String get comingSoon => isUrdu ? 'جلد آ رہا ہے' : 'Coming Soon';
  String get defaultLabel => isUrdu ? 'ڈیفالٹ' : 'Default';
  String get contactInformation => isUrdu ? 'رابطے کی معلومات' : 'Contact Information';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ur'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
