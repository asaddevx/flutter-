import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that displays a profile picture with an attractive full-screen preview
/// similar to WhatsApp profile picture preview.
class ProfilePicturePreview extends StatelessWidget {
  final String? imagePath;
  final double size;
  final double borderRadius;
  final Widget? placeholder;
  final bool isCircular;

  const ProfilePicturePreview({
    super.key,
    required this.imagePath,
    this.size = 50,
    this.borderRadius = 8,
    this.placeholder,
    this.isCircular = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: imagePath != null && imagePath!.isNotEmpty
          ? () => _showFullScreenPreview(context, imagePath!)
          : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircular ? null : BorderRadius.circular(borderRadius),
          color: Colors.grey.shade300,
        ),
        child: ClipRRect(
          borderRadius: isCircular
              ? BorderRadius.circular(size / 2)
              : BorderRadius.circular(borderRadius),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath == null || imagePath!.isEmpty) {
      return placeholder ??
          Icon(
            Icons.person_rounded,
            size: size * 0.5,
            color: Colors.grey.shade600,
          );
    }

    try {
      if (imagePath!.startsWith('http')) {
        // Network image
        return Image.network(
          imagePath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return placeholder ??
                Icon(
                  Icons.person_rounded,
                  size: size * 0.5,
                  color: Colors.grey.shade600,
                );
          },
        );
      } else {
        // Local file
        final file = File(imagePath!);
        if (file.existsSync()) {
          return Image.file(
            file,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return placeholder ??
                  Icon(
                    Icons.person_rounded,
                    size: size * 0.5,
                    color: Colors.grey.shade600,
                  );
            },
          );
        } else {
          return placeholder ??
              Icon(
                Icons.person_rounded,
                size: size * 0.5,
                color: Colors.grey.shade600,
              );
        }
      }
    } catch (e) {
      return placeholder ??
          Icon(
            Icons.person_rounded,
            size: size * 0.5,
            color: Colors.grey.shade600,
          );
    }
  }

  void _showFullScreenPreview(BuildContext context, String path) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _FullScreenImageViewer(imagePath: path),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0, 1);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}

class _FullScreenImageViewer extends StatefulWidget {
  final String imagePath;

  const _FullScreenImageViewer({required this.imagePath});

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() => _transformationController.value = _animation!.value);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    if (_transformationController.value.getMaxScaleOnAxis() < 0.8) {
      _animation = Matrix4Tween(
        begin: _transformationController.value,
        end: Matrix4.identity(),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: InteractiveViewer(
          transformationController: _transformationController,
          onInteractionEnd: _onInteractionEnd,
          minScale: 0.5,
          maxScale: 4.0,
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    try {
      if (widget.imagePath.startsWith('http')) {
        return Image.network(
          widget.imagePath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.white54,
                size: 64,
              ),
            );
          },
        );
      } else {
        final file = File(widget.imagePath);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.broken_image,
                  color: Colors.white54,
                  size: 64,
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.white54,
              size: 64,
            ),
          );
        }
      }
    } catch (e) {
      return const Center(
        child: Icon(
          Icons.broken_image,
          color: Colors.white54,
          size: 64,
        ),
      );
    }
  }
}
