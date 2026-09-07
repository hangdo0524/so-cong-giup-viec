/* Chép file này thành docs/firebase-config.js rồi điền config của project Firebase.
   Các khoá này công khai được — Firebase thiết kế như vậy; phần chặn nằm ở Firestore Rules
   (xem firestore.rules) và ở mã sổ ngẫu nhiên trong link. */
window.FIREBASE_CONFIG = {
  apiKey:            "",
  authDomain:        "",
  projectId:         "",          // để trống thì app chạy bằng localStorage như cũ
  storageBucket:     "",
  messagingSenderId: "",
  appId:             ""
};
