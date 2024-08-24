import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/contacts/application/contact_register/index.dart';
import 'package:contacts_app_re014/features/contacts/domain/core/register_contacts_status.dart';
import 'package:contacts_app_re014/features/contacts/domain/entities/contact_entity.dart';
import 'package:contacts_app_re014/features/contacts/presentation/widgets/contact_register_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ContactRegisterPage extends StatefulWidget {
  const ContactRegisterPage({
    super.key,
    this.contact,
  });
  final ContactEntity? contact;

  @override
  State<ContactRegisterPage> createState() => _ContactRegisterPageState();
}

class _ContactRegisterPageState extends State<ContactRegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.contact?.name ?? '');
    phoneController = TextEditingController(text: widget.contact?.phoneNumber ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<RegisterContactFormBloc, RegisterContactFormState>(
          listener: (context, state) {
            switch (state.status) {
              case RegisterContactStatus.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("Something went wrong. Please check and try again."),
                  ),
                );
                break;
              case RegisterContactStatus.idInUse:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("A user with this ID is already registered."),
                  ),
                );
                break;
              case RegisterContactStatus.success:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Contact registered successfully."),
                  ),
                );
                context.pop();
                break;

              default:
            }
          },
          builder: (context, state) {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ContactRegisterHeaderWidget(size: size),
                  Expanded(
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: size.width * .08, vertical: size.height * .06),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                hintText: "User Name",
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (p0) {},
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[^0-9]'))],
                                validator: (value) {
                                  return AppValidators.contactNameValidator(value);
                                },
                              ),
                              SizedBox(height: size.height * .02),
                              CustomTextFormField(
                                hintText: "Phone",
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: phoneController,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.none,
                                textInputType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                                onChanged: (p0) {},
                                validator: (value) {
                                  return AppValidators.contactPhoneValidator(value);
                                },
                              ),
                              CustomButton(
                                text: 'Save',
                                suffixIcon: state.status == RegisterContactStatus.submitting
                                    ? SizedBox(
                                        height: size.height * .033,
                                        width: size.height * .033,
                                        child: const CircularProgressIndicator(color: Colors.white),
                                      )
                                    : const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                enable: formKey.currentState != null && formKey.currentState!.validate(),
                                margin: EdgeInsets.only(top: size.height * .04, bottom: size.height * .01),
                                onPressed: () => state.status != RegisterContactStatus.submitting ? onSubmit() : {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void onSubmit() {
    context.read<RegisterContactFormBloc>().add(
          FormSubmitted(
            id: widget.contact?.id,
            name: nameController.text,
            phoneNumber: phoneController.text,
            isEditing: widget.contact != null,
            fromApp: widget.contact != null && widget.contact!.fromApp,
          ),
        );
  }
}
