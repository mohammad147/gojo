const firebase = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Path to your service account key file
const serviceAccountPath = 'C:\\Users\\VICTUS\\Documents\\jam3a\\grad project\\grad_final_project\\gojo\\gojo-s-firebase-adminsdk-2zqxh-dc50890505.json';

// Initialize Firebase
firebase.initializeApp({
  credential: firebase.credential.cert(require(serviceAccountPath))
});

const db = firebase.firestore();

// Path to your JSON file
const jsonFilePath = 'C:\\Users\\VICTUS\\Documents\\jam3a\\grad project\\grad_final_project\\gojo\\assets\\Json_Files\\places_db.json';

// Read the JSON file
fs.readFile(jsonFilePath, 'utf8', async (err, data) => {
  if (err) {
    console.error('Error reading JSON file:', err);
    return;
  }

  try {
    // Parse the JSON data
    const jsonData = JSON.parse(data);

    // Ensure jsonData.places is an array
    if (!Array.isArray(jsonData.places)) {
      throw new Error('Invalid JSON data: "places" should be an array');
    }

    // Upload the data to Firestore
    const collectionRef = db.collection('places');

    const promises = jsonData.places.map(async (place) => {
      // Use place.key as the document ID
      if (typeof place !== 'object' || place === null) {
        throw new Error(`Invalid place data: Not an object`);
      }

      await collectionRef.doc(place.key.toString()).set(place);
    });

    await Promise.all(promises);
    console.log('Data uploaded successfully to Firestore');
  } catch (error) {
    console.error('Error uploading data to Firestore:', error);
  }
});
