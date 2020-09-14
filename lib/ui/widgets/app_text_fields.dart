import 'package:flutter/material.dart';
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

_unfocusField(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

class StandardTextFormField extends FormField<String> {
  StandardTextFormField({
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    String initialValue,
    bool autoValidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autoValidate,
            builder: (FormFieldState<String> state) {
              return Column(
                children: <Widget>[
                  Text(state.value),
                  Container(
                    height: 1,
                    width: 400,
                    color: Colors.grey,
                  ),
                  state.hasError
                      ? Text(
                          state.errorText,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              );
            });
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
      //color: Colors.grey,
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
            controller: widget.controller,
            obscureText: widget.obscureText,
            initialValue: widget.initialValue,
            focusNode: widget.currentFocusNode,
            onFieldSubmitted: (_) {
              if (widget.textInputAction != null) {
                switch (widget.textInputAction) {
                  case TextInputAction.next:
                    _fieldFocusChange(
                        context, widget.currentFocusNode, widget.nextFocusNode);
                    break;
                  case TextInputAction.done:
                    _unfocusField(context);
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
              filled: false,
              /*contentPadding: widget.suffixIcon != null
                  ? const EdgeInsets.fromLTRB(12, 12, 52, 12)
                  : null,

               */
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent[400], width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent[400], width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              isDense: true,
            ),
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
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

  BasicStreamDropDownFormField({
    Key key,
    @required this.stream,
    @required this.labelText,
    @required this.hintText,
    @required this.menuItems,
    @required this.onChanged,
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
            value: snapshot.data,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              filled: true,
            ),
            items: widget.menuItems,
            onChanged: widget.onChanged,
          );
        },
      ),
    );
  }
}
