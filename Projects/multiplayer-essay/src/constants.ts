import * as firebase from 'firebase'

export const firebaseConfig = {
  apiKey: "AIzaSyC3Gwq2s8IbN0tfeRT8bzLWpVuB8Hwp1C4",
  authDomain: "multiplayer-essay.firebaseapp.com",
  databaseURL: "https://multiplayer-essay.firebaseio.com",
  projectId: "multiplayer-essay",
  storageBucket: "multiplayer-essay.appspot.com",
  messagingSenderId: "1051787669336"
};

firebase.initializeApp(firebaseConfig);

export const ref = firebase.database().ref();
export const firebaseAuth = firebase.auth;

export interface User {
  displayName: string;
  photoURL: string;
  uid: string;
  metadata: any;
  readyParty?: boolean;
  readyPartyTimestamp?: number;
  confirmParty?: boolean;
  confirmPartyTimestamp?: number;
  confirmPartyAllSet?: boolean;
  party: string;
}

