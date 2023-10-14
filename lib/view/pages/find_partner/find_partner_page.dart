import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/find_partner_controller.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:sport_partner/view/pages/find_partner/add_post_page.dart';
import 'package:sport_partner/view/pages/find_partner/widgets/post_card.dart';
import 'package:sport_partner/view/widgets/custom_gradient_background.dart';

class FindPartnerPage extends StatelessWidget {
  const FindPartnerPage({super.key, required this.categoryIdName});

  final String categoryIdName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FindPartnerController(categoryIdName),
      builder: (context, child) {
        context.read<FindPartnerController>().fetchPosts();
        return Scaffold(
          appBar: AppBar(
            title: Text('mainOptions.findPartner'.tr()),
            flexibleSpace: AppTheme.defaultAppBarTheme,
          ),
          body: CustomGradientBackground(
            child: Consumer<FindPartnerController>(builder: (context, findPartnerController, _) {
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<UserController>().userConfirmedDetails
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPostPage(categoryIdName: categoryIdName),
                      ),
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Aby dodawać posty musisz uzupełnić swój profil'),
                      ),
                    );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
