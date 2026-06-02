import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';

class ColorOption {
  final String nameEn;
  final String nameUrdu;
  final Color color;

  const ColorOption({
    required this.nameEn,
    required this.nameUrdu,
    required this.color,
  });
}

class ColorPickerDialog {
  static const List<ColorOption> colors = [
    // Neutrals
    ColorOption(nameEn: 'White', nameUrdu: 'سفید', color: Color(0xFFFFFFFF)),
    ColorOption(nameEn: 'Black', nameUrdu: 'کالا', color: Color(0xFF000000)),
    ColorOption(nameEn: 'Grey', nameUrdu: 'سرمئی', color: Color(0xFF9E9E9E)),
    ColorOption(nameEn: 'Cream', nameUrdu: 'کریم', color: Color(0xFFFFF8DC)),
    ColorOption(nameEn: 'Beige', nameUrdu: 'بیج', color: Color(0xFFF5F5DC)),
    
    // Browns
    ColorOption(nameEn: 'Brown', nameUrdu: 'بھورا', color: Color(0xFF795548)),
    ColorOption(nameEn: 'Tan', nameUrdu: 'ہلکا بھورا', color: Color(0xFFD2B48C)),
    ColorOption(nameEn: 'Coffee', nameUrdu: 'کافی', color: Color(0xFF6F4E37)),
    
    // Blues
    ColorOption(nameEn: 'Navy Blue', nameUrdu: 'نیلا', color: Color(0xFF001F3F)),
    ColorOption(nameEn: 'Sky Blue', nameUrdu: 'آسمانی', color: Color(0xFF87CEEB)),
    ColorOption(nameEn: 'Royal Blue', nameUrdu: 'شاہی نیلا', color: Color(0xFF4169E1)),
    ColorOption(nameEn: 'Teal', nameUrdu: 'فیروزی', color: Color(0xFF008080)),
    
    // Greens
    ColorOption(nameEn: 'Green', nameUrdu: 'سبز', color: Color(0xFF4CAF50)),
    ColorOption(nameEn: 'Dark Green', nameUrdu: 'گہرا سبز', color: Color(0xFF2E7D32)),
    ColorOption(nameEn: 'Olive', nameUrdu: 'زیتونی', color: Color(0xFF808000)),
    ColorOption(nameEn: 'Mint', nameUrdu: 'پودینہ', color: Color(0xFF98FF98)),
    
    // Reds & Pinks
    ColorOption(nameEn: 'Red', nameUrdu: 'لال', color: Color(0xFFF44336)),
    ColorOption(nameEn: 'Maroon', nameUrdu: 'مرون', color: Color(0xFF800000)),
    ColorOption(nameEn: 'Pink', nameUrdu: 'گلابی', color: Color(0xFFE91E63)),
    ColorOption(nameEn: 'Rose', nameUrdu: 'گلاب', color: Color(0xFFFF007F)),
    
    // Yellows & Oranges
    ColorOption(nameEn: 'Yellow', nameUrdu: 'پیلا', color: Color(0xFFFFEB3B)),
    ColorOption(nameEn: 'Golden', nameUrdu: 'سنہری', color: Color(0xFFFFD700)),
    ColorOption(nameEn: 'Orange', nameUrdu: 'نارنجی', color: Color(0xFFFF9800)),
    ColorOption(nameEn: 'Peach', nameUrdu: 'آڑو', color: Color(0xFFFFDAB9)),
    
    // Purples
    ColorOption(nameEn: 'Purple', nameUrdu: 'جامنی', color: Color(0xFF9C27B0)),
    ColorOption(nameEn: 'Lavender', nameUrdu: 'لیونڈر', color: Color(0xFFE6E6FA)),
    ColorOption(nameEn: 'Magenta', nameUrdu: 'ارغوانی', color: Color(0xFFFF00FF)),
    
    // Others
    ColorOption(nameEn: 'Silver', nameUrdu: 'چاندی', color: Color(0xFFC0C0C0)),
    ColorOption(nameEn: 'Khaki', nameUrdu: 'خاکی', color: Color(0xFFC3B091)),
    ColorOption(nameEn: 'Turquoise', nameUrdu: 'فیروزی نیلا', color: Color(0xFF40E0D0)),
    
    // Additional Neutrals
    ColorOption(nameEn: 'Charcoal', nameUrdu: 'کوئلہ', color: Color(0xFF36454F)),
    ColorOption(nameEn: 'Ivory', nameUrdu: 'ہاتھی دانت', color: Color(0xFFFFFFF0)),
    ColorOption(nameEn: 'Off-White', nameUrdu: 'ہلکا سفید', color: Color(0xFFFAF9F6)),
    ColorOption(nameEn: 'Taupe', nameUrdu: 'ٹاؤپ', color: Color(0xFF483C32)),
    ColorOption(nameEn: 'Light Grey', nameUrdu: 'ہلکا سرمئی', color: Color(0xFFD3D3D3)),
    
    // Additional Browns
    ColorOption(nameEn: 'Chocolate', nameUrdu: 'چاکلیٹ', color: Color(0xFF7B3F00)),
    ColorOption(nameEn: 'Bronze', nameUrdu: 'کانسی', color: Color(0xFFCD7F32)),
    ColorOption(nameEn: 'Copper', nameUrdu: 'تانبا', color: Color(0xFFB87333)),
    ColorOption(nameEn: 'Sienna', nameUrdu: 'سیینا', color: Color(0xFFA0522D)),
    ColorOption(nameEn: 'Chestnut', nameUrdu: 'شاہ بلوط', color: Color(0xFF954535)),
    
    // Additional Blues
    ColorOption(nameEn: 'Baby Blue', nameUrdu: 'بیبی نیلا', color: Color(0xFF89CFF0)),
    ColorOption(nameEn: 'Steel Blue', nameUrdu: 'سٹیل نیلا', color: Color(0xFF4682B4)),
    ColorOption(nameEn: 'Indigo', nameUrdu: 'نیلگوں', color: Color(0xFF4B0082)),
    ColorOption(nameEn: 'Azure', nameUrdu: 'آزور', color: Color(0xFF007FFF)),
    ColorOption(nameEn: 'Cobalt', nameUrdu: 'کوبالٹ', color: Color(0xFF0047AB)),
    
    // Additional Greens
    ColorOption(nameEn: 'Lime', nameUrdu: 'لیموں', color: Color(0xFFBFFF00)),
    ColorOption(nameEn: 'Forest Green', nameUrdu: 'جنگل سبز', color: Color(0xFF228B22)),
    ColorOption(nameEn: 'Sea Green', nameUrdu: 'سمندری سبز', color: Color(0xFF2E8B57)),
    ColorOption(nameEn: 'Emerald', nameUrdu: 'زمرد', color: Color(0xFF50C878)),
    ColorOption(nameEn: 'Sage', nameUrdu: 'سیج', color: Color(0xFF9DC183)),
    
    // Additional Reds & Pinks
    ColorOption(nameEn: 'Crimson', nameUrdu: 'گہرا لال', color: Color(0xFFDC143C)),
    ColorOption(nameEn: 'Coral', nameUrdu: 'مرجان', color: Color(0xFFFF7F50)),
    ColorOption(nameEn: 'Salmon', nameUrdu: 'سمون', color: Color(0xFFFA8072)),
    ColorOption(nameEn: 'Burgundy', nameUrdu: 'برگنڈی', color: Color(0xFF800020)),
    ColorOption(nameEn: 'Fuchsia', nameUrdu: 'فوشیا', color: Color(0xFFFF00FF)),
    
    // Additional Yellows & Oranges
    ColorOption(nameEn: 'Amber', nameUrdu: 'امبر', color: Color(0xFFFFBF00)),
    ColorOption(nameEn: 'Apricot', nameUrdu: 'خوبانی', color: Color(0xFFFBCEB1)),
    ColorOption(nameEn: 'Tangerine', nameUrdu: 'سنتری', color: Color(0xFFFF9980)),
    ColorOption(nameEn: 'Lemon', nameUrdu: 'لیمن', color: Color(0xFFF7E98E)),
    ColorOption(nameEn: 'Rust', nameUrdu: 'زنگ', color: Color(0xFFB7410E)),
    
    // Additional Purples
    ColorOption(nameEn: 'Violet', nameUrdu: 'بنفشی', color: Color(0xFF8B00FF)),
    ColorOption(nameEn: 'Plum', nameUrdu: 'آلو', color: Color(0xFFDDA0DD)),
    ColorOption(nameEn: 'Orchid', nameUrdu: 'ارکڈ', color: Color(0xFFDA70D6)),
    ColorOption(nameEn: 'Lilac', nameUrdu: 'للا', color: Color(0xFFC8A2C8)),
    ColorOption(nameEn: 'Amethyst', nameUrdu: 'نیلم', color: Color(0xFF9966CC)),
    
    // Additional Others
    ColorOption(nameEn: 'Aqua', nameUrdu: 'آکوا', color: Color(0xFF00FFFF)),
    ColorOption(nameEn: 'Periwinkle', nameUrdu: 'پرونکل', color: Color(0xFFCCCCFF)),
    ColorOption(nameEn: 'Slate', nameUrdu: 'سلٹ', color: Color(0xFF708090)),
    ColorOption(nameEn: 'Mustard', nameUrdu: 'سرسوں', color: Color(0xFFFFDB58)),
    ColorOption(nameEn: 'Slate Blue', nameUrdu: 'سلٹ نیلا', color: Color(0xFF6A5ACD)),
  ];

  static Future<ColorOption?> show(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    
    return await showModalBottomSheet<ColorOption>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.palette_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.isUrdu ? 'رنگ منتخب کریں' : 'Select Color',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Color Grid
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  final colorOption = colors[index];
                  return _ColorTile(
                    colorOption: colorOption,
                    isUrdu: l10n.isUrdu,
                    onTap: () => Navigator.pop(context, colorOption),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final ColorOption colorOption;
  final bool isUrdu;
  final VoidCallback onTap;

  const _ColorTile({
    required this.colorOption,
    required this.isUrdu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = colorOption.color.computeLuminance() < 0.5;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colorOption.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorOption.color == const Color(0xFFFFFFFF)
                ? Colors.grey.shade300
                : colorOption.color,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: colorOption.color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            isUrdu ? colorOption.nameUrdu : colorOption.nameEn,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class SelectedColorDisplay extends StatelessWidget {
  final ColorOption? selectedColor;
  final bool isUrdu;

  const SelectedColorDisplay({
    super.key,
    required this.selectedColor,
    required this.isUrdu,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedColor == null) {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            isUrdu ? 'رنگ منتخب نہیں' : 'No color selected',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    }

    final isDark = selectedColor!.color.computeLuminance() < 0.5;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: selectedColor!.color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selectedColor!.color == const Color(0xFFFFFFFF)
              ? Colors.grey.shade300
              : selectedColor!.color,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: selectedColor!.color.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: selectedColor!.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? Colors.white54 : Colors.black26,
                width: 2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            isUrdu ? selectedColor!.nameUrdu : selectedColor!.nameEn,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
