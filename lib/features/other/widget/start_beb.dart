import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/network/api_client.dart';
import 'package:portfolio/features/other/dialog/picture.dart';
import 'package:portfolio/features/other/dialog/video.dart';
import 'package:portfolio/features/other/dialog/web.dart';
import 'package:portfolio/features/other/model/contact_yoss_form.dart';
import 'package:portfolio/features/other/widget/icon_beb.dart';
import 'package:reactive_forms/reactive_forms.dart';

const _contactApiUrl =
    'https://testsendemail-production-f7ae.up.railway.app/contact';
const _defaultContactEmail = 'test@example.com';

class StartBeb extends ConsumerStatefulWidget {
  const StartBeb({super.key});

  @override
  ConsumerState<StartBeb> createState() => _StartBebState();
}

class _StartBebState extends ConsumerState<StartBeb> {
  void _showLockDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('แจ้งเตือน'),
        content: const Text('ยังไม่ให้เข้าดูหรอกจ้าาาาาา!!!!!!!!'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  void _showSendMessageDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => _ContactYossDialog(
        messenger: ScaffoldMessenger.of(context),
        dio: ref.read(dioProvider),
      ),
    );
  }

  Widget _buildIconMenu(String label) {
    return IconBeb(
      onPressed: _showLockDialog,
      textlabel: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: theme.colorScheme.primary,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  constraints: const BoxConstraints(),
                  onPressed: () => context.go('/'),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black.withOpacity(0.5),
                    size: 20,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _showSendMessageDialog,
                style: ElevatedButton.styleFrom(
                  // backgroundColor: theme.colorScheme.secondary,
                  // foregroundColor: theme.colorScheme.onSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "ฝากบอก YOSSY",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            IconBeb(
                onPressed: () => PictureGridDialog.show(context),
                textlabel: "Pictures"),
            IconBeb(
                onPressed: () => VideoGridDialog.show(context),
                textlabel: "Videos"),
            IconBeb(
                onPressed: () => WebGridDialog.show(context), textlabel: "Web")
          ],
        ),
      ],
    );
  }
}

class _ContactYossDialog extends StatefulWidget {
  const _ContactYossDialog({
    required this.messenger,
    required this.dio,
  });

  final ScaffoldMessengerState messenger;
  final Dio dio;

  @override
  State<_ContactYossDialog> createState() => _ContactYossDialogState();
}

class _ContactYossDialogState extends State<_ContactYossDialog> {
  late final FormGroup _form;
  bool _submitting = false;
  String? _sendError;

  static final Map<String, ValidationMessageFunction> _minLengthMessages = {
    ValidationMessage.minLength: (Object error) {
      final map = error as Map;
      final min = map['requiredLength'];
      return 'อย่างน้อย $min ตัวอักษร';
    },
  };

  static final Map<String, ValidationMessageFunction> _nameMessages = {
    ValidationMessage.required: (_) => 'กรุณากรอกชื่อ',
    ..._minLengthMessages,
  };

  static final Map<String, ValidationMessageFunction> _messageMessages = {
    ValidationMessage.required: (_) => 'กรุณากรอกข้อความ',
    ..._minLengthMessages,
  };

  @override
  void initState() {
    super.initState();
    _form = ContactYossForm.form();
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(BuildContext context, String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Future<void> _send(BuildContext dialogContext) async {
    _form.markAllAsTouched();
    if (!_form.valid) {
      widget.messenger.showSnackBar(
        const SnackBar(content: Text('กรุณาแก้ข้อมูลในฟอร์มให้ถูกต้อง')),
      );
      return;
    }

    final name =
        (_form.control(ContactYossForm.nameKey).value as String).trim();
    final message =
        (_form.control(ContactYossForm.messageKey).value as String).trim();

    setState(() {
      _submitting = true;
      _sendError = null;
    });

    try {
      await widget.dio.post<Map<String, dynamic>>(
        _contactApiUrl,
        data: <String, dynamic>{
          'name': name,
          'email': _defaultContactEmail,
          'message': message,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      if (!mounted) return;
      if (!dialogContext.mounted) return;
      Navigator.of(dialogContext).pop();
      widget.messenger.showSnackBar(
        const SnackBar(content: Text('ส่งข้อความให้ YOSS แล้วจ้า')),
      );
    } on DioException catch (e) {
      final msg = e.response?.data is Map
          ? (e.response!.data as Map)['message']?.toString()
          : null;
      setState(() {
        _submitting = false;
        _sendError = msg ?? e.message ?? 'ส่งไม่สำเร็จ ลองใหม่นะ';
      });
    } catch (e) {
      setState(() {
        _submitting = false;
        _sendError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ฝากบอก YOSS'),
      content: ReactiveForm(
        formGroup: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Baby อยากบอกอะไร Yossy ไหมมมม??'),
              const Gap(12),
              ReactiveTextField<String>(
                formControlName: ContactYossForm.nameKey,
                textInputAction: TextInputAction.next,
                validationMessages: _nameMessages,
                decoration: _fieldDecoration(context, 'ปุ้มปุ้ย').copyWith(
                  labelText: 'ชื่อเล่น',
                ),
              ),
              const Gap(12),
              ReactiveTextField<String>(
                formControlName: ContactYossForm.messageKey,
                minLines: 3,
                maxLines: 6,
                textInputAction: TextInputAction.done,
                validationMessages: _messageMessages,
                decoration: _fieldDecoration(context, 'บอกมาเลยสิจ๊ะะ')
                    .copyWith(alignLabelWithHint: true),
              ),
              if (_sendError != null) ...[
                const Gap(8),
                Text(
                  _sendError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('ยกเลิก'),
        ),
        FilledButton(
          onPressed: _submitting ? null : () => _send(context),
          child: _submitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : const Text('ส่ง'),
        ),
      ],
    );
  }
}
