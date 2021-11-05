class Dictionary {
  Dictionary(
      {this.id,
      this.title,
      this.introduction,
      this.image,
      this.publicUid,
      this.langNumberOfEntry,
      this.langNumberOfMeaning,
      this.requestScreened = false,
      this.wordsCount = 0,
      this.acceptedRequestsCount = 0,
      this.usersAuthorizedToCreate = 4,
      this.createScreened = false,
      this.usersAuthorizedToUpdate = 4,
      this.updateScreened = false,
      this.usersAuthorizedToDestroy = 1,
      this.destroyScreened = false,
      this.usersAuthorizedToReview = 3,
      this.reviewCountToCloseRequest = 3,
      this.sameEntryScreened = false,
      this.changingEntryScreened = false,
      this.createdAt,
      this.updatedAt});

  int? id;
  String? title;
  String? introduction;
  String? image;
  String? publicUid;
  int? langNumberOfEntry;
  int? langNumberOfMeaning;
  bool requestScreened;
  int wordsCount;
  int acceptedRequestsCount;
  int usersAuthorizedToCreate;
  bool createScreened;
  int usersAuthorizedToUpdate;
  bool updateScreened;
  int usersAuthorizedToDestroy;
  bool destroyScreened;
  int usersAuthorizedToReview;
  int reviewCountToCloseRequest;
  bool sameEntryScreened;
  bool changingEntryScreened;
  String? createdAt;
  String? updatedAt;

  Dictionary.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        introduction = json['introduction'],
        image = json['image'].toString(),
        publicUid = json['public_uid'],
        langNumberOfEntry = json['lang_number_of_entry'],
        langNumberOfMeaning = json['lang_number_of_meaning'],
        requestScreened = json['request_screened'],
        wordsCount = json['words_count'],
        acceptedRequestsCount = json['accepted_requests_count'],
        usersAuthorizedToCreate = json['users_authorized_to_create'],
        createScreened = json['create_screened'],
        usersAuthorizedToUpdate = json['users_authorized_to_update'],
        updateScreened = json['update_screened'],
        usersAuthorizedToDestroy = json['users_authorized_to_destroy'],
        destroyScreened = json['destroy_screened'],
        usersAuthorizedToReview = json['users_authorized_to_review'],
        reviewCountToCloseRequest = json['review_count_to_close_request'],
        sameEntryScreened = json['same_entry_screened'],
        changingEntryScreened = json['changing_entry_screened'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'introduction': introduction,
        'image': image,
        'publicUid': publicUid,
        'langNumberOfEntry': langNumberOfEntry,
        'langNumberOfMeaning': langNumberOfMeaning,
        'requestScreened': requestScreened,
        'wordsCount': wordsCount,
        'acceptedRequestsCount': acceptedRequestsCount,
        'usersAuthorizedToCreate': usersAuthorizedToCreate,
        'createScreened': createScreened,
        'usersAuthorizedToUpdate': usersAuthorizedToUpdate,
        'updateScreened': updateScreened,
        'usersAuthorizedToDestroy': usersAuthorizedToDestroy,
        'destroyScreened': destroyScreened,
        'usersAuthorizedToReview': usersAuthorizedToReview,
        'reviewCountToCloseRequest': reviewCountToCloseRequest,
        'sameEntryScreened': sameEntryScreened,
        'changingEntryScreened': changingEntryScreened,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
