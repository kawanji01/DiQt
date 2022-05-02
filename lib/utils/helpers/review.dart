class ReviewHelper {
  static String interval(number) {
    switch (number) {
      case 0:
        return '翌日';
      case 1:
        return '３日後';
      case 2:
        return '１週間後';
      case 3:
        return '２週間後';
      case 4:
        return '３週間後';
      case 5:
        return '１ヶ月後';
      case 6:
        return '２ヶ月後';
      case 7:
        return '３ヶ月後';
      case 8:
        return '６ヶ月後';
      case 9:
        return '１年後';
      default:
        return '';
    }
  }

  static String intervalSetting(number) {
    return '${ReviewHelper.interval(number)}に復習する';

    /*   String intervalSetting = '';
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
    return intervalSetting; */
  }
}
