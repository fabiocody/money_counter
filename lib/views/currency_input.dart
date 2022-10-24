import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_counter/validation.dart';

class CurrencyInput extends StatefulWidget {
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? initialText;
  final TextInputAction? textInputAction;
  final List<Validator> validators;

  const CurrencyInput({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.labelText,
    this.initialText,
    this.textInputAction,
    this.validators = const [],
  });

  @override
  State<StatefulWidget> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late TextEditingController _textController;
  bool _touched = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  void didUpdateWidget(covariant CurrencyInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialText != null) {
      _textController.text = widget.initialText!;
      _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        labelText: widget.labelText,
        errorText: _touched ? getErrorText(widget.validators, _textController.text) : null,
      ),
      onSubmitted: widget.onSubmitted,
      onChanged: _onChanged,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]|\.'))],
    );
  }

  void _onChanged(String text) {
    if (!_touched) setState(() => _touched = true);
    widget.onChanged?.call(text);
  }
}