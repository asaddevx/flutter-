import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart' hide TextDirection;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/client_model.dart';
import '../../data/models/measurement_model.dart';
import '../../data/models/order_model.dart';
import '../../features/settings/presentation/providers/settings_provider.dart';
import '../../core/constants/enums.dart';

// Navy + Gold brand colours
const _navy = PdfColor.fromInt(0xFF1B2141);
const _gold = PdfColor.fromInt(0xFFD4A745);
const _white = PdfColors.white;
const _grey = PdfColor.fromInt(0xFF6B7280);
const _lightBg = PdfColor.fromInt(0xFFF8F9FA);
const _border = PdfColor.fromInt(0xFFE5E7EB);
const _green = PdfColor.fromInt(0xFF10B981);
const _red = PdfColor.fromInt(0xFFEF4444);
const _blue = PdfColor.fromInt(0xFF3B82F6);

class PdfGeneratorService {
  static Font? _poppinsFont;
  static Font? _urduFont;
  static MemoryImage? _logoImage;

  // Urdu → English color name lookup (avoids font rendering glitch in PDF)
  static const _urduToEnColor = <String, String>{
    'سفید': 'White', 'کالا': 'Black', 'سرمئی': 'Grey', 'کریم': 'Cream', 'بیج': 'Beige',
    'بھورا': 'Brown', 'ہلکا بھورا': 'Tan', 'کافی': 'Coffee',
    'نیلا': 'Navy Blue', 'آسمانی': 'Sky Blue', 'شاہی نیلا': 'Royal Blue', 'فیروزی': 'Teal',
    'سبز': 'Green', 'گہرا سبز': 'Dark Green', 'زیتونی': 'Olive', 'پودینہ': 'Mint',
    'لال': 'Red', 'مرون': 'Maroon', 'گلابی': 'Pink', 'گلاب': 'Rose',
    'پیلا': 'Yellow', 'سنہری': 'Golden', 'نارنجی': 'Orange', 'آڑو': 'Peach',
    'جامنی': 'Purple', 'لیونڈر': 'Lavender', 'ارغوانی': 'Magenta',
    'چاندی': 'Silver', 'خاکی': 'Khaki', 'فیروزی نیلا': 'Turquoise',
    'کوئلہ': 'Charcoal', 'ہاتھی دانت': 'Ivory', 'ہلکا سفید': 'Off-White',
    'ٹاؤپ': 'Taupe', 'ہلکا سرمئی': 'Light Grey',
    'چاکلیٹ': 'Chocolate', 'کانسی': 'Bronze', 'تانبا': 'Copper', 'سیینا': 'Sienna', 'شاہ بلوط': 'Chestnut',
    'بیبی نیلا': 'Baby Blue', 'سٹیل نیلا': 'Steel Blue', 'نیلگوں': 'Indigo', 'آزور': 'Azure', 'کوبالٹ': 'Cobalt',
    'لیموں': 'Lime', 'جنگل سبز': 'Forest Green', 'سمندری سبز': 'Sea Green', 'زمرد': 'Emerald', 'سیج': 'Sage',
    'گہرا لال': 'Crimson', 'مرجان': 'Coral', 'سمون': 'Salmon', 'برگنڈی': 'Burgundy', 'فوشیا': 'Fuchsia',
    'امبر': 'Amber', 'خوبانی': 'Apricot', 'سنتری': 'Tangerine', 'لیمن': 'Lemon', 'زنگ': 'Rust',
    'بنفشی': 'Violet', 'آلو': 'Plum', 'ارکڈ': 'Orchid', 'للا': 'Lilac', 'نیلم': 'Amethyst',
    'آکوا': 'Aqua', 'پرونکل': 'Periwinkle', 'سلٹ': 'Slate', 'سرسوں': 'Mustard', 'سلٹ نیلا': 'Slate Blue',
  };

  static String _resolveColorEn(String? stored) {
    if (stored == null || stored.isEmpty) return '';
    return _urduToEnColor[stored] ?? stored;
  }

  // Bilingual label helper
  static String _t(bool isUrdu, String en, String ur) => isUrdu ? ur : en;

  // Urdu measurement field names
  static const _measureFieldsUrdu = <String, String>{
    'Height': 'قد', 'Shoulder': 'کندھا', 'Chest': 'سینہ',
    'Waist': 'کمر', 'Hips': 'کولھے', 'Neck': 'گردن',
    'Arm Length': 'بازو', 'Sleeve': 'آستین',
    'Bicep': 'بازو کا گول', 'Forearm': 'کہنی', 'Wrist': 'کلائی',
    'Front': 'آگے', 'Back': 'پیچھے', 'Side Seam': 'پہلو',
    'Inseam': 'اندرونی', 'Outseam': 'بیرونی',
    'Thigh': 'ران', 'Knee': 'گھٹنا', 'Ankle': 'ٹخنہ', 'Calf': 'پنڈلی',
  };

  static String _statusLabel(String status, bool isUrdu) {
    if (isUrdu) {
      switch (status) {
        case 'pending': return 'زیر التواء';
        case 'inProgress': return 'جاری';
        case 'completed': return 'مکمل';
        case 'delivered': return 'ڈیلیور';
        case 'cancelled': return 'منسوخ';
        default: return status;
      }
    }
    switch (status) {
      case 'pending': return 'Pending';
      case 'inProgress': return 'In Progress';
      case 'completed': return 'Completed';
      case 'delivered': return 'Delivered';
      case 'cancelled': return 'Cancelled';
      default: return status;
    }
  }

  static Future<void> _loadAssets() async {
    if (_poppinsFont != null && _urduFont != null) return;
    final poppinsData = await rootBundle.load('assets/fonts/Poppins/Poppins-Regular.ttf');
    _poppinsFont = Font.ttf(poppinsData);
    final urduData = await rootBundle.load('assets/fonts/NotoNaskhArabic/NotoNaskhArabic-Regular.ttf');
    _urduFont = Font.ttf(urduData);
    try {
      final logoData = await rootBundle.load('assets/images/logo.jpg');
      _logoImage = MemoryImage(logoData.buffer.asUint8List());
    } catch (_) {}
  }

  static Future<Uint8List?> _loadClientPhoto(ClientModel client) async {
    if (!client.hasPhoto) return null;
    try {
      final file = File(client.photoPath!);
      if (await file.exists()) return await file.readAsBytes();
    } catch (_) {}
    return null;
  }

  static Future<Uint8List?> _loadShopProfilePhoto(dynamic shopProfile) async {
    final logoPath = shopProfile?.logoPath as String?;
    if (logoPath == null || logoPath.isEmpty) return null;
    try {
      final file = File(logoPath);
      if (await file.exists()) return await file.readAsBytes();
    } catch (_) {}
    return null;
  }

  // ─── Public API ────────────────────────────────────────────────────────────

  static Future<void> shareClientProfile(
    ClientModel client, List<MeasurementModel> measurements,
    List<OrderModel> orders, WidgetRef ref,
  ) async {
    await _loadAssets();
    final photoBytes = await _loadClientPhoto(client);
    final sp = ref.read(shopProfileProvider);
    final shopPhotoBytes = await _loadShopProfilePhoto(sp);
    final isUrdu = ref.read(languageProvider) == LanguageType.urdu;
    final pdf = _buildDoc(sp, isUrdu, (ctx) => [
      _clientInfoCard(client, isUrdu, photoBytes),
      if (measurements.isNotEmpty) ...[
        SizedBox(height: 12),
        _sectionHeader(isUrdu ? 'پیمائشیں' : 'Measurements', isUrdu),
        SizedBox(height: 6),
        ...measurements.map((m) => _measurementCard(m, isUrdu)),
      ],
      if (orders.isNotEmpty) ...[
        SizedBox(height: 12),
        _sectionHeader(isUrdu ? 'آرڈر' : 'Orders', isUrdu),
        SizedBox(height: 6),
        ...orders.map((o) => _orderCard(o, isUrdu)),
      ],
    ], shopPhotoBytes: shopPhotoBytes);
    await _share(pdf, 'Profile_${client.fullName}.pdf', client.fullName);
  }

  static Future<void> shareClientMeasurements(
    ClientModel client, List<MeasurementModel> measurements, WidgetRef ref,
  ) async {
    await _loadAssets();
    final photoBytes = await _loadClientPhoto(client);
    final sp = ref.read(shopProfileProvider);
    final shopPhotoBytes = await _loadShopProfilePhoto(sp);
    final isUrdu = ref.read(languageProvider) == LanguageType.urdu;
    final pdf = _buildDoc(sp, isUrdu, (ctx) => [
      _clientInfoCard(client, isUrdu, photoBytes),
      SizedBox(height: 12),
      _sectionHeader(isUrdu ? 'پیمائشیں' : 'Measurements', isUrdu),
      SizedBox(height: 6),
      ...measurements.map((m) => _measurementCard(m, isUrdu)),
    ], shopPhotoBytes: shopPhotoBytes);
    await _share(pdf, 'Measurements_${client.fullName}.pdf', client.fullName);
  }

  static Future<void> shareSingleMeasurement(
    ClientModel client, MeasurementModel measurement, WidgetRef ref,
  ) async {
    await _loadAssets();
    final photoBytes = await _loadClientPhoto(client);
    final sp = ref.read(shopProfileProvider);
    final shopPhotoBytes = await _loadShopProfilePhoto(sp);
    final isUrdu = ref.read(languageProvider) == LanguageType.urdu;
    final pdf = _buildDoc(sp, isUrdu, (ctx) => [
      _clientInfoCard(client, isUrdu, photoBytes),
      SizedBox(height: 12),
      _sectionHeader(isUrdu ? 'پیمائش' : 'Measurement', isUrdu),
      SizedBox(height: 6),
      _measurementCard(measurement, isUrdu),
    ], shopPhotoBytes: shopPhotoBytes);
    await _share(pdf, 'Measurement_${client.fullName}.pdf', client.fullName);
  }

  static Future<void> shareClientOrders(
    ClientModel client, List<OrderModel> orders, WidgetRef ref,
  ) async {
    await _loadAssets();
    final photoBytes = await _loadClientPhoto(client);
    final sp = ref.read(shopProfileProvider);
    final shopPhotoBytes = await _loadShopProfilePhoto(sp);
    final isUrdu = ref.read(languageProvider) == LanguageType.urdu;
    final pdf = _buildDoc(sp, isUrdu, (ctx) => [
      _clientInfoCard(client, isUrdu, photoBytes),
      SizedBox(height: 12),
      _sectionHeader(isUrdu ? 'آرڈر' : 'Orders', isUrdu),
      SizedBox(height: 6),
      ...orders.map((o) => _orderCard(o, isUrdu)),
    ], shopPhotoBytes: shopPhotoBytes);
    await _share(pdf, 'Orders_${client.fullName}.pdf', client.fullName);
  }

  static Future<void> shareSingleOrder(
    ClientModel client, OrderModel order, WidgetRef ref,
  ) async {
    await _loadAssets();
    final photoBytes = await _loadClientPhoto(client);
    final sp = ref.read(shopProfileProvider);
    final shopPhotoBytes = await _loadShopProfilePhoto(sp);
    final isUrdu = ref.read(languageProvider) == LanguageType.urdu;
    final pdf = _buildDoc(sp, isUrdu, (ctx) => [
      _clientInfoCard(client, isUrdu, photoBytes),
      SizedBox(height: 12),
      _sectionHeader(isUrdu ? 'آرڈر کی تفصیل' : 'Order Details', isUrdu),
      SizedBox(height: 6),
      _orderCard(order, isUrdu),
    ], shopPhotoBytes: shopPhotoBytes);
    await _share(pdf, 'Order_${client.fullName}_${order.id.substring(0, 6)}.pdf', client.fullName);
  }

  // ─── Document builder ──────────────────────────────────────────────────────

  static Document _buildDoc(
    dynamic shopProfile, bool isUrdu,
    List<Widget> Function(Context) buildFn, {
    Uint8List? shopPhotoBytes,
  }) {
    final font = isUrdu ? _urduFont : _poppinsFont;
    final theme = ThemeData.withFont(
      base: font ?? Font.helvetica(),
      bold: font ?? Font.helveticaBold(),
    );
    final pdf = Document(theme: theme);
    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const EdgeInsets.fromLTRB(28, 24, 28, 24),
      theme: theme,
      header: (ctx) {
        // Show header only on first page
        if (ctx.pageNumber == 1) {
          return Column(children: [
            _buildHeader(shopProfile, shopPhotoBytes),
            SizedBox(height: 10),
          ]);
        }
        return SizedBox(height: 6);
      },
      footer: (ctx) => _buildFooter(ctx, shopProfile, isUrdu),
      build: buildFn,
    ));
    return pdf;
  }

  // ─── Header ────────────────────────────────────────────────────────────────

  static Widget _buildHeader(dynamic shopProfile, [Uint8List? shopPhotoBytes]) {
    final shopName = shopProfile?.shopName ?? 'DarziVault';
    final ownerName = (shopProfile?.ownerName as String?) ?? '';
    final phone = shopProfile?.phone as String?;
    final address = shopProfile?.address as String?;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Shop profile photo (left)
          if (shopPhotoBytes != null)
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _gold, width: 2),
                image: DecorationImage(image: MemoryImage(shopPhotoBytes), fit: BoxFit.cover),
              ),
            )
          else
            Container(
              width: 48, height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _gold,
                shape: BoxShape.circle,
              ),
              child: Icon(IconData(0xe59c), size: 26, color: _navy),
            ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopName,
                    style: TextStyle(color: _white, fontSize: 15, fontWeight: FontWeight.bold)),
                if (ownerName.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Text(ownerName,
                      style: const TextStyle(color: _gold, fontSize: 9)),
                ],
                if (phone != null) ...[
                  SizedBox(height: 1),
                  Text(phone, style: const TextStyle(color: PdfColors.grey300, fontSize: 8)),
                ],
                if (address != null) ...[
                  SizedBox(height: 1),
                  Text(address, style: const TextStyle(color: PdfColors.grey300, fontSize: 8)),
                ],
              ],
            ),
          ),
          SizedBox(width: 10),
          // App logo (right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_logoImage != null)
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _gold, width: 1.5),
                    image: DecorationImage(image: _logoImage!, fit: BoxFit.cover),
                  ),
                )
              else
                Text('DarziVault',
                    style: TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(DateFormat('dd MMM yyyy').format(DateTime.now()),
                  style: const TextStyle(color: _white, fontSize: 7)),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Footer ────────────────────────────────────────────────────────────────

  static Widget _buildFooter(Context ctx, dynamic shopProfile, bool isUrdu) {
    final dir = isUrdu ? TextDirection.rtl : TextDirection.ltr;
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _navy, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isUrdu ? 'ڈارزی والٹ کی جانب سے' : 'Generated by DarziVault',
            style: const TextStyle(color: _grey, fontSize: 7),
            textDirection: dir,
          ),
          Text(
            isUrdu
                ? 'صفحہ ${ctx.pageNumber} / ${ctx.pagesCount}'
                : 'Page ${ctx.pageNumber} / ${ctx.pagesCount}',
            style: const TextStyle(color: _grey, fontSize: 7),
            textDirection: dir,
          ),
        ],
      ),
    );
  }

  // ─── Client Info ───────────────────────────────────────────────────────────

  static Widget _clientInfoCard(ClientModel client, bool isUrdu, [Uint8List? photoBytes]) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Client photo or initials avatar
          if (photoBytes != null)
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _gold, width: 2),
                image: DecorationImage(
                  image: MemoryImage(photoBytes),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              width: 44, height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _gold,
                shape: BoxShape.circle,
              ),
              child: Text(
                client.fullName.isNotEmpty ? client.fullName[0].toUpperCase() : 'C',
                style: TextStyle(color: _navy, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client.fullName,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: _white)),
                SizedBox(height: 3),
                Text(client.phoneNumber,
                    style: const TextStyle(fontSize: 9, color: _gold)),
                if (client.address != null)
                  Text(client.address!,
                      style: const TextStyle(fontSize: 8, color: PdfColors.grey300)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: client.gender == 'male'
                  ? const PdfColor(0.231, 0.510, 0.965, 0.25)
                  : const PdfColor(0.95, 0.30, 0.59, 0.25),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: client.gender == 'male' ? _blue : const PdfColor(0.95, 0.30, 0.59),
              ),
            ),
            child: Text(
              client.gender == 'male'
                  ? _t(isUrdu, 'Male', 'مرد')
                  : _t(isUrdu, 'Female', 'خاتون'),
              style: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: _white,
              ),
              textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section header ────────────────────────────────────────────────────────

  static Widget _sectionHeader(String title, [bool isUrdu = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(title,
          style: TextStyle(color: _white, fontSize: 10, fontWeight: FontWeight.bold),
          textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr),
    );
  }

  // ─── Order card ────────────────────────────────────────────────────────────

  static Widget _orderCard(OrderModel order, bool isUrdu) {
    final effectiveItems = order.effectiveItems;
    final suitCount = effectiveItems.length;
    final dir = isUrdu ? TextDirection.rtl : TextDirection.ltr;
    final crossAlign = isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: crossAlign,
        children: [
          // Header row: garment title + status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                suitCount > 1
                    ? '$suitCount ${_t(isUrdu, "Suits", "سوٹ")}'
                    : GarmentType.values.firstWhere(
                        (g) => g.name == effectiveItems.first.garmentType,
                        orElse: () => GarmentType.other,
                      ).getLocalizedName(isUrdu),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _navy),
                textDirection: dir,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor(order.status),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _statusLabel(order.status, isUrdu),
                  style: TextStyle(fontSize: 8, color: _white, fontWeight: FontWeight.bold),
                  textDirection: dir,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),

          // Multi-suit garments list
          if (suitCount > 1) ...[
            ...effectiveItems.asMap().entries.map((e) {
              final g = GarmentType.values.firstWhere(
                (gt) => gt.name == e.value.garmentType, orElse: () => GarmentType.other);
              final colorStr = isUrdu ? (e.value.color ?? '') : _resolveColorEn(e.value.color);
              return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    Container(
                      width: 16, height: 16,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const PdfColor(0.831, 0.655, 0.271, 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Text('${e.key + 1}',
                          style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: _gold)),
                    ),
                    SizedBox(width: 6),
                    Text(g.getLocalizedName(isUrdu),
                        style: const TextStyle(fontSize: 9, color: _navy),
                        textDirection: dir),
                    if (e.value.color != null && colorStr.isNotEmpty) ...[
                      SizedBox(width: 6),
                      Text('• $colorStr',
                          style: const TextStyle(fontSize: 9, color: _grey),
                          textDirection: dir),
                    ],
                  ],
                ),
              );
            }),
            SizedBox(height: 4),
          ] else if (effectiveItems.first.color != null) ...[
            _detailRow(_t(isUrdu, 'Color', 'رنگ'),
                isUrdu ? (effectiveItems.first.color ?? '') : _resolveColorEn(effectiveItems.first.color),
                isUrdu),
          ],

          // Payment details
          Divider(color: _border, height: 8),
          Row(
            children: [
              Expanded(child: _miniStat(_t(isUrdu, 'Total', 'کل'), 'PKR ${order.totalPrice.toStringAsFixed(0)}', _navy, isUrdu)),
              Expanded(child: _miniStat(_t(isUrdu, 'Paid', 'ادا'), 'PKR ${order.advanceAmount.toStringAsFixed(0)}', _green, isUrdu)),
              Expanded(child: _miniStat(_t(isUrdu, 'Balance', 'باقی'), 'PKR ${order.balanceAmount.toStringAsFixed(0)}',
                  order.balanceAmount > 0 ? _red : _green, isUrdu)),
            ],
          ),
          if (order.fabricDescription != null) ...[
            SizedBox(height: 4),
            _detailRow(_t(isUrdu, 'Fabric', 'کپڑا'), order.fabricDescription!, isUrdu),
          ],
          SizedBox(height: 2),
          _detailRow(_t(isUrdu, 'Created', 'تاریخ'), DateFormat('dd MMM yyyy').format(order.createdAt), isUrdu),
          if (order.dueDate != null) ...[
            SizedBox(height: 2),
            _detailRow(_t(isUrdu, 'Due', 'ڈیڈ لائن'), DateFormat('dd MMM yyyy – hh:mm a').format(order.dueDate!), isUrdu),
          ],
          SizedBox(height: 2),
          _detailRow(_t(isUrdu, 'Order ID', 'آرڈر نمبر'), '#${order.id.substring(0, 8).toUpperCase()}', isUrdu),
        ],
      ),
    );
  }

  static Widget _miniStat(String label, String value, PdfColor color, [bool isUrdu = false]) {
    final dir = isUrdu ? TextDirection.rtl : TextDirection.ltr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 7, color: _grey), textDirection: dir),
      ],
    );
  }

  static Widget _detailRow(String label, String value, [bool isUrdu = false]) {
    if (isUrdu) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(value,
                style: const TextStyle(fontSize: 8, color: _navy),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left),
            SizedBox(width: 6),
            Text('$label:', style: const TextStyle(fontSize: 8, color: _grey),
                textDirection: TextDirection.rtl),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            child: Text('$label:', style: const TextStyle(fontSize: 8, color: _grey)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 8, color: _navy)),
          ),
        ],
      ),
    );
  }

  // ─── Measurement card ──────────────────────────────────────────────────────

  static Widget _measurementCard(MeasurementModel m, bool isUrdu) {
    final garment = GarmentType.values.firstWhere(
      (g) => g.name == m.garmentType, orElse: () => GarmentType.other);
    final dir = isUrdu ? TextDirection.rtl : TextDirection.ltr;
    final crossAlign = isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    final fields = <String, double?>{
      'Height': m.height, 'Shoulder': m.shoulder, 'Chest': m.chest,
      'Waist': m.waist, 'Hips': m.hips, 'Neck': m.neck,
      'Arm Length': m.armLength, 'Sleeve': m.sleeveLength,
      'Bicep': m.bicep, 'Forearm': m.forearm, 'Wrist': m.wrist,
      'Front': m.frontLength, 'Back': m.backLength, 'Side Seam': m.sideSeam,
      'Inseam': m.inseam, 'Outseam': m.outseam,
      'Thigh': m.thigh, 'Knee': m.knee, 'Ankle': m.ankle, 'Calf': m.calf,
    };
    for (final e in m.customFields.entries) { fields[e.key] = e.value; }
    final active = fields.entries.where((e) => e.value != null && e.value! > 0).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: crossAlign,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(garment.getLocalizedName(isUrdu),
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _navy),
                  textDirection: dir),
              if (m.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: const PdfColor(0.063, 0.725, 0.506, 0.15), borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    _t(isUrdu, 'Default', 'بنیادی'),
                    style: TextStyle(fontSize: 7, color: _green, fontWeight: FontWeight.bold),
                    textDirection: dir,
                  ),
                ),
            ],
          ),
          SizedBox(height: 6),
          if (active.isEmpty)
            Text(
              _t(isUrdu, 'No measurements recorded.', 'کوئی پیمائش نہیں'),
              style: const TextStyle(fontSize: 8, color: _grey),
              textDirection: dir,
            )
          else
            Wrap(
              spacing: 6, runSpacing: 6,
              children: active.map((e) {
                final fieldLabel = isUrdu
                    ? (_measureFieldsUrdu[e.key] ?? m.customFieldNamesUrdu[e.key] ?? e.key)
                    : e.key;
                return Container(
                  width: 74,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: _lightBg, borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: crossAlign,
                    children: [
                      Text(fieldLabel,
                          style: const TextStyle(fontSize: 7, color: _grey),
                          textDirection: dir),
                      Text('${e.value} cm',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _navy)),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  static PdfColor _statusColor(String status) {
    switch (status) {
      case 'pending': return const PdfColor.fromInt(0xFFF59E0B);
      case 'inProgress': return _blue;
      case 'completed': return _green;
      case 'delivered': return const PdfColor.fromInt(0xFF14B8A6);
      case 'cancelled': return _red;
      default: return _grey;
    }
  }

  static Future<void> _share(Document pdf, String fileName, String clientName) async {
    final bytes = await pdf.save();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], subject: clientName);
  }
}
