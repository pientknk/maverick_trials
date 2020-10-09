import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';

_fieldFocusChange(
    BuildContext context, FocusNode currentFocusNode, FocusNode nextFocusNode) {
  if (currentFocusNode.hasPrimaryFocus) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  } else {
    print(
        'requested focus change not possible due to current node not having primary focus');
  }
}

_dismissFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

class BasicStreamTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Stream<String> stream;
  final ValueChanged<String> onChanged;
  final bool requiredField;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final TextInputAction textInputAction;
  final String initialValue;
  final bool obscureText;
  final Widget suffixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;

  BasicStreamTextFormField({
    Key key,
    @required this.labelText,
    @required this.hintText,
    @required this.stream,
    @required this.onChanged,
    this.requiredField = false,
    this.obscureText = false,
    this.currentFocusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.initialValue,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  })  : assert(controller == null || initialValue == null),
      assert(validator == null || !requiredField),
        super(key: key);

  @override
  _BasicStreamTextFormFieldState createState() =>
      _BasicStreamTextFormFieldState();
}

class _BasicStreamTextFormFieldState extends State<BasicStreamTextFormField>
    with RequiredFieldValidator {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: widget.suffixIcon == null
          ? _buildStreamBuilder()
          : Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                _buildStreamBuilder(),
                widget.suffixIcon,
              ],
            ),
    );
  }

  Widget _buildStreamBuilder() {
    return StreamBuilder<String>(
        stream: widget.stream,
        builder: (context, snapshot) {
          return TextFormField(
            cursorColor: ThemeColors.greenSheen,
            maxLines: widget.obscureText ? 1 : null,
            controller: widget.controller,
            obscureText: widget.obscureText,
            focusNode: widget.currentFocusNode,
            onFieldSubmitted: (_) {
              if (widget.textInputAction != null) {
                switch (widget.textInputAction) {
                  case TextInputAction.next:
                    _fieldFocusChange(
                        context, widget.currentFocusNode, widget.nextFocusNode);
                    break;
                  case TextInputAction.done:
                    _dismissFocus(context);
                    break;
                  default:
                    print(
                        "unhandled TextInputAction ${widget.textInputAction} in BasicStreamTextFormField");
                }
              }
            },
            decoration: InputDecoration(
              labelText:
                  '${widget.labelText}${widget.requiredField ? ' *' : ''}',
              hintText: widget.hintText,
              errorText: snapshot.error,
              helperText: widget.requiredField ? '*Required' : null,
            ),
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            initialValue: widget.initialValue,
            validator: widget.requiredField ? validateRequiredField : null,
          );
        });
  }
}

class BasicStreamDropDownFormField extends StatefulWidget {
  final Stream<String> stream;
  final String labelText;
  final String hintText;
  final List<DropdownMenuItem<String>> menuItems;
  final ValueChanged<String> onChanged;
  final String initialValue;

  BasicStreamDropDownFormField({
    Key key,
    @required this.stream,
    @required this.labelText,
    @required this.hintText,
    @required this.menuItems,
    @required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _BasicStreamDropDownFormFieldState createState() =>
      _BasicStreamDropDownFormFieldState();
}

class _BasicStreamDropDownFormFieldState
    extends State<BasicStreamDropDownFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: StreamBuilder<String>(
        stream: widget.stream,
        builder: (context, snapshot) {
          return DropdownButtonFormField<String>(
            value: snapshot.data ?? widget.initialValue,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
            ),
            items: widget.menuItems,
            onChanged: widget.onChanged,
          );
        },
      ),
    );
  }
}

class SwitchListTileStreamField extends StatefulWidget {
  final Stream<bool> stream;
  final bool initialValue;
  final Widget title;
  final Widget subtitle;
  final ValueChanged<bool> onChanged;

  SwitchListTileStreamField({Key key,
    @required this.stream,
    @required this.title,
  @required this.initialValue,
    @required this.onChanged,
  this.subtitle,}) : super(key: key);

  @override
  _SwitchListTileStreamFieldState createState() => _SwitchListTileStreamFieldState();
}

class _SwitchListTileStreamFieldState extends State<SwitchListTileStreamField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<bool>(
        initialData: widget.initialValue,
        stream: widget.stream,
        builder: (context, snapshot){
          return SwitchListTile(
            title: widget.title,
            subtitle: widget.subtitle,
            value: snapshot.data ?? false,
            onChanged: widget.onChanged,
          );
        },
      ),
    );
  }
}

