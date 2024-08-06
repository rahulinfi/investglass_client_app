import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class DocumentsController extends ChangeNotifier{
  String _selectedType='All';
  List<String> typesList = ['All', 'Document', 'Form', 'Package'];

  String range = '';
  String searchedFile = '';
  String? selectedType = 'All';
  int sortRadioGroupValue = -1;
  String selectedAncestryFolder = '',
      selectedPath = '',
      startDate = '',
      endDate = '',orderColumn='created_at',orderDirection='desc';
  List<FilterModel> appliedFilters=[];
  String filterName='filterName',filterType='filterType',filterDate='filterDate',path='path',sortType='sortType';

  void setSortRadioGroupValue(int value, String label) {
    sortRadioGroupValue = value;
    if(value==0 || value==1){
      orderColumn='created_at';
    }else{
      orderColumn='name';
    }

    if(value==0 || value==3){
      orderDirection='desc';
    }else{
      orderDirection='asc';
    }
    appliedFilters.removeWhere((element) => element.type==sortType,);
    appliedFilters.insert(0,FilterModel(label,sortType));
    notifyListeners();
  }

  void setDate(String date) {
    range='';
    startDate='';
    endDate='';
notifyListeners();
  }

  /*________________________________________________UPLOAD DOCUMENT____________________________________*/
  XFile? image;
  TextEditingController descController=TextEditingController();
  bool shared=false;
  TextEditingController expiryDateController=TextEditingController();

  void selectImage(XFile? image) {
    this.image=image;
    notifyListeners();
  }

  void removeSelectedImage() {
    image=null;
    notifyListeners();
  }
}

class FilterModel {
  String? name;
  String type;

  FilterModel(this.name, this.type);
}