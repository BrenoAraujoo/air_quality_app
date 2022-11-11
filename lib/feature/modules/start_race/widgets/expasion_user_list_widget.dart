import 'package:air_quality_app/feature/modules/start_race/controller/start_race_controller.dart';
import 'package:air_quality_app/feature/modules/start_race/utils/generate_user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExpasionUserListWidget extends StatefulWidget {
  const ExpasionUserListWidget({super.key});

  @override
  State<ExpasionUserListWidget> createState() => _ExpasionUserListWidgetState();
}

class _ExpasionUserListWidgetState extends State<ExpasionUserListWidget> {
  final _controller = Modular.get<StartRaceController>();

  @override
  void initState() {
    super.initState();
    _controller.setSelectedUser = generateUserList().first;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: _controller.getSelectedUser,
      builder: (_, selectedUser, __) {
        return Container(
          margin: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.white,
            textColor: Colors.white,
            title: Text(selectedUser.name),
            children: [
              Container(
                padding: const EdgeInsets.only(top: 6.0),
                color: Colors.white,
                child: Container(
                  width: maxWidth,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: generateUserList().map((user) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: 16.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            _controller.setSelectedUser = user;
                            print(user.id);
                            print(user.name);
                          },
                          child: Text(user.name),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
