enum Gender {
  male,
  female;
  
  String get displayName {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }
}

enum OrderStatus {
  pending,
  inProgress,
  completed,
  delivered,
  cancelled;
  
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.inProgress:
        return 'In Progress';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

enum GarmentType {
  shalwarKameez,
  suit,
  shirt,
  pants,
  coat,
  kurta,
  anarkali,
  other;
  
  String get displayName {
    switch (this) {
      case GarmentType.shalwarKameez:
        return 'Shalwar Kameez';
      case GarmentType.suit:
        return 'Suit';
      case GarmentType.shirt:
        return 'Shirt';
      case GarmentType.pants:
        return 'Pants';
      case GarmentType.coat:
        return 'Coat';
      case GarmentType.kurta:
        return 'Kurta';
      case GarmentType.anarkali:
        return 'Anarkali';
      case GarmentType.other:
        return 'Other';
    }
  }
  
  String getLocalizedName(bool isUrdu) {
    switch (this) {
      case GarmentType.shalwarKameez:
        return isUrdu ? 'شلوار قمیض' : 'Shalwar Kameez';
      case GarmentType.suit:
        return isUrdu ? 'سوٹ' : 'Suit';
      case GarmentType.shirt:
        return isUrdu ? 'قمیض' : 'Shirt';
      case GarmentType.pants:
        return isUrdu ? 'پتلون' : 'Pants';
      case GarmentType.coat:
        return isUrdu ? 'کوٹ' : 'Coat';
      case GarmentType.kurta:
        return isUrdu ? 'کرتا' : 'Kurta';
      case GarmentType.anarkali:
        return isUrdu ? 'انارکلی' : 'Anarkali';
      case GarmentType.other:
        return isUrdu ? 'دیگر' : 'Other';
    }
  }
}

enum ThemeType {
  light,
  dark,
  system;

  String get displayName {
    switch (this) {
      case ThemeType.light: return 'Light';
      case ThemeType.dark: return 'Dark';
      case ThemeType.system: return 'System Default';
    }
  }
}

enum LanguageType {
  english,
  urdu;

  String get displayName {
    switch (this) {
      case LanguageType.english: return 'English';
      case LanguageType.urdu: return 'اردو (Urdu)';
    }
  }
}
