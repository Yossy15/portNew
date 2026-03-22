import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum AppFieldType { text, email, password, phone }

class AppTextField<T> extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.formControlName,
    required this.label,
    this.hint,
    this.fieldType = AppFieldType.text,
    this.prefixIcon,
    this.validationMessages,
    this.onChanged,
    this.textInputAction,
  });

  final String formControlName;
  final String label;
  final String? hint;
  final AppFieldType fieldType;
  final IconData? prefixIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final void Function(T?)? onChanged;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField<T>> createState() => _AppTextFieldState<T>();
}

class _AppTextFieldState<T> extends State<AppTextField<T>>
    with SingleTickerProviderStateMixin {
  bool _obscureText = true;
  late AnimationController _controller;
  late Animation<double> _focusAnim;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _focusAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isPassword => widget.fieldType == AppFieldType.password;

  TextInputType get _keyboardType => switch (widget.fieldType) {
        AppFieldType.email => TextInputType.emailAddress,
        AppFieldType.phone => TextInputType.phone,
        _ => TextInputType.text,
      };

  Map<String, String Function(Object)> get _defaultValidationMessages => {
        ValidationMessage.required: (_) => '${widget.label} is required',
        ValidationMessage.email: (_) => 'Enter a valid email address',
        ValidationMessage.minLength: (e) {
          final min = (e as Map)['requiredLength'];
          return 'Minimum $min characters';
        },
        ...?widget.validationMessages,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _focusAnim,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // boxShadow: [
            //   BoxShadow(
            //     color: colorScheme.primary
            //         .withOpacity(0.08 + (_focusAnim.value * 0.12)),
            //     blurRadius: 8 + (_focusAnim.value * 8),
            //     offset: const Offset(0, 2),
            //   ),
            // ],
          ),
          child: child,
        );
      },
      child: Focus(
        onFocusChange: (focused) {
          setState(() => _isFocused = focused);
          focused ? _controller.forward() : _controller.reverse();
        },
        child: ReactiveTextField<T>(
          formControlName: widget.formControlName,
          obscureText: _isPassword ? _obscureText : false,
          keyboardType: _keyboardType,
          textInputAction:
              widget.textInputAction ?? TextInputAction.next,
          onChanged: widget.onChanged != null
              ? (control) => widget.onChanged!(control.value)
              : null,
          validationMessages: _defaultValidationMessages,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            filled: true,
            fillColor: _isFocused
                ? colorScheme.surfaceContainerLow
                : colorScheme.surfaceContainerLowest,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      widget.prefixIcon,
                      size: 20,
                      color: _isFocused
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                  )
                : null,
            suffixIcon: _isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.5,
              ),
            ),
            labelStyle: TextStyle(
              color: _isFocused
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant.withOpacity(0.6),
              fontSize: 14,
            ),
            errorStyle: TextStyle(
              color: colorScheme.error,
              fontSize: 12,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}