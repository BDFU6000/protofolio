import 'dart:math' as math;

import 'package:flutter/material.dart';

enum ImageLoadPriority { low, normal, high }

class OptimizedAssetRegistry {
  static const _webp = <String, String>{
    'assets/images/Moneeb.png': 'assets/images/optimized/moneeb_hero.webp',
    'assets/images/moneeb2.png': 'assets/images/optimized/moneeb2_800.webp',
    'assets/images/smart-clinic.png':
        'assets/images/optimized/smart-clinic-1600.webp',
    'assets/images/Robot_smart_clinic.png':
        'assets/images/optimized/robot_smart_clinic_512.webp',
    'assets/images/Login Page.png':
        'assets/images/optimized/feedme_login_430.webp',
    'assets/images/Main Page.png':
        'assets/images/optimized/feedme_main_428.webp',
    'assets/images/Shopping Page.png':
        'assets/images/optimized/feedme_shopping_430.webp',
    'assets/images/Products detiaes Page.png':
        'assets/images/optimized/feedme_products_430.webp',
    'assets/images/Cart Page.png':
        'assets/images/optimized/feedme_cart_430.webp',
    'assets/images/Order tracking Page.png':
        'assets/images/optimized/feedme_order_430.webp',
    'assets/images/Account Page.png':
        'assets/images/optimized/feedme_account_430.webp',
    'assets/images/Profile page.png':
        'assets/images/optimized/feedme_profile_430.webp',
    'assets/images/doctor_leandek_login.png':
        'assets/images/optimized/doctor_leandek_login_400.webp',
    'assets/images/doctor_leandek_main.png':
        'assets/images/optimized/doctor_leandek_main_387.webp',
    'assets/images/sidaliti_login.png':
        'assets/images/optimized/sidaliti_login_393.webp',
    'assets/images/torrance_website_desktop.jpg':
        'assets/images/optimized/torrance_desktop_1200.webp',
    'assets/images/torrance_website_mobile.png':
        'assets/images/optimized/torrance_mobile_400.webp',
    'assets/images/Tamayous_website.png':
        'assets/images/optimized/tamayous_1200.webp',
    'assets/images/Tamayous_website_mobile .png':
        'assets/images/optimized/tamayous_mobile_400.webp',
    'assets/images/ERPNext.png': 'assets/images/optimized/erpnext_512.webp',
    'assets/images/Libyan_dealect_Ai_voice.png':
        'assets/images/optimized/libyan_voice_512.webp',
    'assets/images/Seven-Stage Data Pipeline Infographic.png':
        'assets/images/optimized/lead_pipeline_1200.webp',
    'assets/images/My_roadmap.png':
        'assets/images/optimized/my_roadmap_800.webp',
    'assets/images/Custom Software Development.png':
        'assets/images/optimized/custom_software_800.webp',
    'assets/images/AI & Workflow Automation.png':
        'assets/images/optimized/ai_workflow_800.webp',
    'assets/images/Business Website Development.png':
        'assets/images/optimized/business_website_800.webp',
    'assets/images/Flutter_logo.png':
        'assets/images/optimized/flutter_logo_96.webp',
    'assets/images/figma_logo.png':
        'assets/images/optimized/figma_logo_96.webp',
    'assets/images/supabase_logo.png':
        'assets/images/optimized/supabase_logo_96.webp',
    'assets/images/firebase_logo.png':
        'assets/images/optimized/firebase_logo_96.webp',
    'assets/images/python_logo.png':
        'assets/images/optimized/python_logo_96.webp',
    'assets/images/postgresql_logo.png':
        'assets/images/optimized/postgresql_logo_96.webp',
    'assets/images/API&Rest_API_logo.png':
        'assets/images/optimized/api_logo_96.webp',
    'assets/images/C#_logo.png': 'assets/images/optimized/csharp_logo_96.webp',
    'assets/images/Github_logo.png':
        'assets/images/optimized/github_logo_96.webp',
    'assets/images/Gmail_logo.png':
        'assets/images/optimized/gmail_logo_64.webp',
    'assets/images/Instagram_logo.png':
        'assets/images/optimized/instagram_logo_64.webp',
    'assets/images/Linkedin_LOGO.png':
        'assets/images/optimized/linkedin_logo_64.webp',
  };

  static const _compactWebp = <String, String>{
    'assets/images/smart-clinic.png':
        'assets/images/optimized/smart-clinic-800.webp',
  };

  static String resolve(String assetName, {bool compact = false}) {
    if (compact) {
      final small = _compactWebp[assetName];
      if (small != null) return small;
    }
    return _webp[assetName] ?? assetName;
  }
}

class OptimizedImage extends StatefulWidget {
  const OptimizedImage.asset({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.priority = ImageLoadPriority.normal,
    this.lazy = false,
    this.cacheWidth,
    this.cacheHeight,
    this.color,
    this.colorBlendMode,
    this.semanticLabel,
    this.placeholderColor = const Color(0xFF0D2B31),
    this.placeholderIcon = Icons.image_outlined,
    this.errorIcon = Icons.image_not_supported_outlined,
  });

  final String assetName;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit fit;
  final Alignment alignment;
  final ImageLoadPriority priority;
  final bool lazy;
  final int? cacheWidth;
  final int? cacheHeight;
  final Color? color;
  final BlendMode? colorBlendMode;
  final String? semanticLabel;
  final Color placeholderColor;
  final IconData placeholderIcon;
  final IconData errorIcon;

  @override
  State<OptimizedImage> createState() => _OptimizedImageState();
}

class _OptimizedImageState extends State<OptimizedImage> {
  bool _shouldLoad = false;
  bool _precached = false;
  bool _frameCheckRegistered = false;
  bool _loadPending = false;
  final ValueNotifier<bool> _loaded = ValueNotifier<bool>(false);
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _shouldLoad = !widget.lazy;
    _registerFrameCheck();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachScrollListener();
    if (_shouldLoad && widget.priority == ImageLoadPriority.high) {
      _precache();
    }
  }

  @override
  void didUpdateWidget(covariant OptimizedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetName != widget.assetName) {
      _precached = false;
      _loadPending = false;
      _loaded.value = false;
    }
    if (oldWidget.lazy != widget.lazy && !widget.lazy && !_shouldLoad) {
      setState(() => _shouldLoad = true);
      _unregisterFrameCheck();
    }
    if (_shouldLoad && widget.priority == ImageLoadPriority.high) {
      _precache();
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScroll);
    _unregisterFrameCheck();
    _loaded.dispose();
    super.dispose();
  }

  void _markLoaded() {
    if (_loaded.value || _loadPending) return;
    _loadPending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPending = false;
      if (mounted && !_loaded.value) _loaded.value = true;
    });
  }

  void _registerFrameCheck() {
    if (!widget.lazy || _shouldLoad || _frameCheckRegistered) return;
    _frameCheckRegistered = true;
    WidgetsBinding.instance
        .addPersistentFrameCallback(_checkVisibilityEachFrame);
  }

  void _unregisterFrameCheck() {
    _frameCheckRegistered = false;
  }

  void _checkVisibilityEachFrame(Duration timestamp) {
    if (!_frameCheckRegistered || !mounted || _shouldLoad) return;
    _updateVisibility();
  }

  void _attachScrollListener() {
    final position = Scrollable.maybeOf(context)?.position;
    if (identical(position, _scrollPosition)) return;
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = position;
    _scrollPosition?.addListener(_onScroll);
    if (widget.lazy && !_shouldLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateVisibility());
    }
  }

  void _onScroll() => _updateVisibility();

  void _updateVisibility() {
    if (!mounted) return;
    if (_shouldLoad) {
      _unregisterFrameCheck();
      return;
    }
    final object = context.findRenderObject();
    if (object is! RenderBox || !object.hasSize) return;
    final top = object.localToGlobal(Offset.zero).dy;
    final bottom = top + object.size.height;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    if (bottom < -160 || top > viewportHeight + 160) return;
    setState(() => _shouldLoad = true);
    _unregisterFrameCheck();
    if (widget.priority == ImageLoadPriority.high) _precache();
  }

  void _precache() {
    if (_precached) return;
    _precached = true;
    final compact = MediaQuery.sizeOf(context).width < 600;
    final asset = OptimizedAssetRegistry.resolve(
      widget.assetName,
      compact: compact,
    );
    precacheImage(AssetImage(asset), context).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    final asset = OptimizedAssetRegistry.resolve(
      widget.assetName,
      compact: compact,
    );
    final shouldLoad = !widget.lazy || _shouldLoad;
    final deviceRatio = MediaQuery.devicePixelRatioOf(context);
    final ratioCap = widget.priority == ImageLoadPriority.high
        ? 2.0
        : (widget.priority == ImageLoadPriority.low ? 1.25 : 1.5);
    final ratio = math.min(deviceRatio, ratioCap);
    final cacheWidth = widget.cacheWidth ??
        (widget.width == null || !widget.width!.isFinite
            ? null
            : (widget.width! * ratio).round());
    final cacheHeight = widget.cacheHeight ??
        (widget.height == null || !widget.height!.isFinite
            ? null
            : (widget.height! * ratio).round());

    Widget placeholder = ValueListenableBuilder<bool>(
      valueListenable: _loaded,
      builder: (context, loaded, child) {
        return AnimatedOpacity(
          opacity: loaded ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: child,
        );
      },
      child: ColoredBox(
        color: widget.placeholderColor,
        child: Center(
          child: Opacity(
            opacity: .16,
            child: Icon(widget.placeholderIcon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );

    Widget image = Image.asset(
      asset,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      semanticLabel: widget.semanticLabel,
      gaplessPlayback: true,
      errorBuilder: (_, __, ___) => Center(
        child: Icon(
          widget.errorIcon,
          color: Colors.white54,
          size: 22,
        ),
      ),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        final loaded = wasSynchronouslyLoaded || frame != null;
        if (loaded) _markLoaded();
        return AnimatedOpacity(
          opacity: loaded ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: child,
        );
      },
    );

    Widget body = LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.hasBoundedWidth && constraints.hasBoundedHeight) {
          return Stack(
            children: [
              Positioned.fill(child: placeholder),
              if (shouldLoad) Positioned.fill(child: image),
            ],
          );
        }
        return shouldLoad ? image : placeholder;
      },
    );

    if (widget.aspectRatio != null) {
      body = AspectRatio(aspectRatio: widget.aspectRatio!, child: body);
    } else if (widget.width != null || widget.height != null) {
      body = SizedBox(
        width: widget.width,
        height: widget.height,
        child: body,
      );
    }
    return body;
  }
}
