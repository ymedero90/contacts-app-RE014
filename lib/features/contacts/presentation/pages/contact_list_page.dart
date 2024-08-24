import 'package:contacts_app_re014/common/core/navigation/routes.dart';
import 'package:contacts_app_re014/common/index.dart';
import 'package:contacts_app_re014/features/contacts/application/contacts_list/contacts_list_bloc.dart';
import 'package:contacts_app_re014/features/contacts/domain/core/register_list_status.dart';
import 'package:contacts_app_re014/features/contacts/presentation/widgets/contact_list_header_widget.dart';
import 'package:contacts_app_re014/features/contacts/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ContactListBloc, ContactsListState>(
          listener: (context, state) {
            switch (state.status) {
              case RegisterListtStatus.fail:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("Something went wrong. Please check and try again."),
                  ),
                );
                break;
              default:
            }
          },
          builder: (context, state) {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const ContactsListHeaderWidget(),
                        SearchWidget(
                          margin: EdgeInsets.symmetric(horizontal: size.width * .08, vertical: size.height * .02),
                          onChanged: (filter) {
                            context.read<ContactListBloc>().add(OnGetContactsEvent(filter: filter));
                          },
                        ),
                        Expanded(
                          child: state.status == RegisterListtStatus.loading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.lightBlueAccent,
                                ))
                              : Center(
                                  child: Container(
                                    child: state.contacts.isEmpty
                                        ? SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.warning_amber_rounded,
                                                  color: Colors.blueGrey,
                                                  size: size.height * .08,
                                                ),
                                                const Text(
                                                  'There is not contacts to show',
                                                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(top: size.height * .02),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.separated(
                                                    itemBuilder: (context, index) {
                                                      return Container(
                                                        margin: EdgeInsets.symmetric(horizontal: size.width * .08),
                                                        child: Slidable(
                                                          direction: Axis.horizontal,
                                                          endActionPane: ActionPane(
                                                            motion: const ScrollMotion(),
                                                            children: [
                                                              if (state.contacts[index].fromApp)
                                                                SlidableAction(
                                                                  padding: EdgeInsets.zero,
                                                                  onPressed: (_) async {
                                                                    await showActionDialog(
                                                                      context: context,
                                                                      message: "Do you want to delete this contact?​​",
                                                                      onAccept: () {
                                                                        context.read<ContactListBloc>().add(
                                                                            OnRemoveContactEvent(
                                                                                contact: state.contacts[index]));
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      onCancel: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    );
                                                                  },
                                                                  backgroundColor: Colors.red,
                                                                  foregroundColor: Colors.white,
                                                                  icon: Icons.delete,
                                                                ),
                                                              SlidableAction(
                                                                padding: EdgeInsets.zero,
                                                                onPressed: (_) async {
                                                                  await context
                                                                      .pushNamed(
                                                                        Routes.contactRegister.name,
                                                                        extra: state.contacts[index],
                                                                      )
                                                                      .then((value) {});
                                                                  context.read<ContactListBloc>().add(
                                                                        const OnGetContactsEvent(),
                                                                      );
                                                                },
                                                                backgroundColor: Colors.orange,
                                                                foregroundColor: Colors.white,
                                                                icon: Icons.edit,
                                                              ),
                                                              if (state.contacts[index].fromApp)
                                                                SlidableAction(
                                                                  padding: EdgeInsets.zero,
                                                                  borderRadius: const BorderRadius.only(
                                                                    topRight: Radius.circular(4),
                                                                    bottomRight: Radius.circular(4),
                                                                  ),
                                                                  onPressed: (_) async {
                                                                    await showActionDialog(
                                                                      context: context,
                                                                      message:
                                                                          "Do you want to add to device this contact?​​",
                                                                      onAccept: () {
                                                                        context.read<ContactListBloc>().add(
                                                                            OnSaveContactEvent(
                                                                                contact: state.contacts[index]));
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      onCancel: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    );
                                                                  },
                                                                  backgroundColor: Colors.green,
                                                                  foregroundColor: Colors.white,
                                                                  icon: Icons.save,
                                                                ),
                                                            ],
                                                          ),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                              color: Colors.lightBlue,
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(4),
                                                                bottomLeft: Radius.circular(4),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                                                  offset: Offset(0, 3),
                                                                  blurRadius: 5,
                                                                )
                                                              ],
                                                            ),
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: size.width * .04,
                                                              vertical: size.height * .01,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.white,
                                                                  child: Text(
                                                                    state.contacts[index].name.isNotEmpty
                                                                        ? state.contacts[index].name[0]
                                                                        : '-',
                                                                    style: const TextStyle(
                                                                      color: Colors.lightBlue,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 20,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: size.width * .04),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        state.contacts[index].name.isNotEmpty
                                                                            ? state.contacts[index].name
                                                                            : '-',
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.white,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Phone: ${state.contacts[index].phoneNumber}",
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                          fontSize: 14,
                                                                          color: Colors.white,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (state.contacts[index].fromApp)
                                                                  Icon(
                                                                    Icons.phone_android_rounded,
                                                                    color: Colors.white,
                                                                    size: size.height * .034,
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder: (context, index) => SizedBox(
                                                      height: size.height * .02,
                                                    ),
                                                    itemCount: state.contacts.length,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  if (MediaQuery.of(context).viewInsets.bottom == 0)
                    Container(
                      margin: EdgeInsets.only(
                        bottom: size.height * .02,
                        left: size.width * .08,
                        right: size.width * .08,
                      ),
                      child: CustomButton(
                        text: 'Add Contact',
                        suffixIcon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                        margin: EdgeInsets.only(top: size.height * .04, bottom: size.height * .01),
                        onPressed: () async {
                          await context.pushNamed(Routes.contactRegister.name).then((value) {});
                          context.read<ContactListBloc>().add(
                                const OnGetContactsEvent(),
                              );
                        },
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
}
