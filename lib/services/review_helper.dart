class ReviewHelperService {
  static String intervalSetting(number) {
    String intervalSetting = '';
    switch (number) {
      case 0:
        intervalSetting = '翌日に復習する';
        break;
      case 1:
        intervalSetting = '３日後に復習する';
        break;
      case 2:
        intervalSetting = '１週間後に復習する';
        break;
      case 3:
        intervalSetting = '２週間後に復習する';
        break;
      case 4:
        intervalSetting = '３週間後に復習する';
        break;
      case 5:
        intervalSetting = '１ヶ月後に復習する';
        break;
      case 6:
        intervalSetting = '２ヶ月後に復習する';
        break;
      case 7:
        intervalSetting = '３ヶ月後に復習する';
        break;
      case 8:
        intervalSetting = '６ヶ月後に復習する';
        break;
      case 9:
        intervalSetting = '１年後に復習する';
        break;
      default:
        intervalSetting = '覚える';
        break;
    }
    return intervalSetting;
  }
}
