extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get titleCase {
    return split(' ').map((w) => w.capitalize).join(' ');
  }

  bool get isValidPhone {
    final clean = replaceAll(RegExp(r'[\s-]'), '');
    return RegExp(r'^03\d{9}$').hasMatch(clean);
  }

  bool get isValidCnic {
    final clean = replaceAll(RegExp(r'[\s-]'), '');
    return RegExp(r'^\d{13}$').hasMatch(clean);
  }

  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  String get initials {
    final parts = trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return isNotEmpty ? this[0].toUpperCase() : '?';
  }

  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  String get orEmpty => this ?? '';
}
