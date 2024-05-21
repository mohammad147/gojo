const firebase = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Path to your service account key file
const serviceAccountPath = 'C:\\Users\\VICTUS\\Documents\\jam3a\\grad project\\grad_final_project\\gojo\\gojo-s-firebase-adminsdk-2zqxh-dc50890505.json';

// Initialize Firebase
firebase.initializeApp({
  credential: firebase.credential.cert(require(serviceAccountPath)),
  storageBucket: 'gs://gojo-s.appspot.com'
});

const bucket = firebase.storage().bucket();

const uploadDirectory = async (baseDir, dir) => {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const fullPath = path.join(dir, file);
    const relativePath = path.relative(baseDir, fullPath).replace(/\\/g, '/');
    const destPath = relativePath;

    if (fs.lstatSync(fullPath).isDirectory()) {
      await uploadDirectory(baseDir, fullPath);
    } else {
      await bucket.upload(fullPath, {
        destination: destPath,
        metadata: {
          cacheControl: 'public, max-age=31536000'
        }
      });
      console.log(`Uploaded ${fullPath} to ${destPath}`);
    }
  }
};

const startUpload = async () => {
  const localDirectory = 'C:\\Users\\VICTUS\\Documents\\jam3a\\grad project\\grad_final_project\\gojo\\assets';
  await uploadDirectory(localDirectory, localDirectory);
  console.log('All files uploaded');
};

startUpload().catch(err => console.error('Error uploading files', err));
