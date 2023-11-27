// marker_with_ripple.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerWithRipple extends StatefulWidget {
  final LatLng position;
  final double initialRippleSize;
  final double finalRippleSize;
  final int rippleDurationMilliseconds;
  final Widget? markerWidget;

  const MarkerWithRipple({
    required this.position,
    this.initialRippleSize = 20.0,
    this.finalRippleSize = 100.0,
    this.rippleDurationMilliseconds = 1500,
    this.markerWidget,
  });

  @override
  _MarkerWithRippleState createState() => _MarkerWithRippleState();
}

class _MarkerWithRippleState extends State<MarkerWithRipple> {
  bool _isRippleAnimating = false;

  @override
  void initState() {
    super.initState();
    _startRippleAnimation();
  }

  void _startRippleAnimation() {
    setState(() {
      _isRippleAnimating = true;
    });
    Future.delayed(Duration(milliseconds: widget.rippleDurationMilliseconds),
        () {
      if (mounted) {
        setState(() {
          _isRippleAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_isRippleAnimating)
          AnimatedPositioned(
            duration: Duration(milliseconds: widget.rippleDurationMilliseconds),
            left: widget.position.longitude - widget.finalRippleSize / 2,
            top: widget.position.latitude - widget.finalRippleSize / 2,
            width: widget.initialRippleSize,
            height: widget.initialRippleSize,
            child: AnimatedContainer(
              duration:
                  Duration(milliseconds: widget.rippleDurationMilliseconds),
              width: _isRippleAnimating
                  ? widget.finalRippleSize
                  : widget.initialRippleSize,
              height: _isRippleAnimating
                  ? widget.finalRippleSize
                  : widget.initialRippleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.3),
              ),
            ),
          ),
        if (widget.markerWidget != null)
          Positioned(
            left: widget.position.longitude,
            top: widget.position.latitude,
            child: widget.markerWidget!,
          ),
      ],
    );
  }
}
