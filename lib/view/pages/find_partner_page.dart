import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/find_partner_controller.dart';
import 'package:sport_partner/view/widgets/post_card.dart';

class FindPartnerPage extends StatelessWidget {
  const FindPartnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FindPartnerController(),
      builder: (context, child) {
        context.read<FindPartnerController>().fetchPosts();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Znajdź partnera'),
          ),
          body: Consumer<FindPartnerController>(builder: (context, findPartnerController, _) {
            return ListView.separated(
              itemCount: findPartnerController.posts.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                return PostCard(
                  post: findPartnerController.posts[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
