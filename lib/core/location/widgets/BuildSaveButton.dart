part of 'LocationWidgetsImports.dart';

class BuildSaveButton extends StatelessWidget {
  final LocationAddressData locationAddressData;

  const BuildSaveButton({super.key, required this.locationAddressData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () => locationAddressData.changeLocation(context),
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width * .7,
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text('تاكيد'),
          ),
        ),
      ],
    );
  }
}
