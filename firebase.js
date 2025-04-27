const admin = require("firebase-admin");
const express = require('express');
const multer = require('multer');
const { Storage } = require('@google-cloud/storage'); // If using Firebase Storage
const path = require('path');
const app = express();
require('dotenv').config();
app.use(express.json());

// Initialize Firebase Admin SDK with parsed credentials
const serviceAccount = JSON.parse(process.env.FIREBASE_CREDENTIALS);

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    storageBucket: "gramakart-a9d4f.appspot.com"
});

const storage = multer.memoryStorage();
const upload = multer({ storage });
const db = admin.firestore();
module.exports = db;
const bucket = admin.storage().bucket();


// getScheme.js or inside an API route

async function getSchemeDetails() {
    try {
        const docRef = db.collection("Schemes").doc("SC01");
        const docSnap = await docRef.get();

        if (docSnap.exists) {
            const data = docSnap.data();
            console.log("Scheme Data:", data);
            // Use or return this data
        } else {
            console.log("No such document!");
        }
    } catch (error) {
        console.error("Error getting document:", error);
    }
}

// Call the function
getSchemeDetails();
// firebase.js


// GET /businessTypes
app.get('/businessTypes', async (req, res) => {
    try {
        const snapshot = await db.collection('business_types').get();
        console.log("Function called");
        const types = snapshot.docs.map(doc => ({
            id: doc.id,
            ...doc.data()
        }));
        res.json(types);
    } catch (e) {
        console.error(e);
        res.status(500).send('Error fetching business types');
    }
});

// GET /productTypes?businessTypeId=XYZ
app.get('/productTypes', async (req, res) => {
    const { businessTypeId } = req.query;

    try {
        console.log("product_types called with:", businessTypeId);

        if (!businessTypeId) {
            return res.status(400).json({ error: 'Missing businessTypeId parameter' });
        }

        const docRef = db.collection('business_types').doc(businessTypeId);
        const docSnap = await docRef.get();

        if (!docSnap.exists) {
            return res.status(404).json({ error: 'Business type not found' });
        }

        const data = docSnap.data();
        const products = data.products || [];

        console.log(products);
        res.json(products);
    } catch (e) {
        console.error(e);
        res.status(500).send('Error fetching product types');
    }
});


app.post('/submitBusinessProfile', async (req, res) => {
    try {
        const data = req.body;

        if (!data) {
            return res.status(400).json({ success: false, error: 'No data provided' });
        }

        const docRef = await db.collection('businessProfiles').add(data);
        console.log(docRef.id);
        return res.status(200).json({ success: true, id: docRef.id });

    } catch (err) {
        console.error('Error saving profile:', err);

        if (!res.headersSent) {
            return res.status(500).json({ success: false, error: 'Failed to store data' });
        }
    }
});


app.post('/submitBusinessProfile2', upload.single('pic'), async (req, res) => {
    try {
        const { docId, role, gender } = req.body;
        const file = req.file;

        if (!docId) {
            return res.status(400).json({ success: false, error: 'Missing docId in request body' });
        }

        let imageUrl = null;

        if (file) {
            const fileName = `businessProfiles/${docId}_${Date.now()}${path.extname(file.originalname)}`;
            const fileUpload = bucket.file(fileName);

            await fileUpload.save(file.buffer, {
                metadata: { contentType: file.mimetype },
            });

            imageUrl = `https://firebasestorage.googleapis.com/v0/b/${bucket.name}/o/${encodeURIComponent(fileName)}?alt=media`;
        }

        const docRef = db.collection('businessProfiles').doc(docId);
        await docRef.update({
            role,
            gender,
            imageUrl: imageUrl || null,
        });

        res.status(200).json({ success: true, imageUrl });
    } catch (err) {
        console.error('Error updating profile:', err);
        res.status(500).json({ success: false, error: 'Failed to update profile data' });
    }
});

// firebase.js (add this below your other routes)

app.get('/sellerProfile', async (req, res) => {
    try {
        const { docId } = req.query;
        if (!docId) return res.status(400).json({ error: 'docId required' });

        const docRef = db.collection('businessProfiles').doc(docId);
        const snap = await docRef.get();
        if (!snap.exists) return res.status(404).json({ error: 'Not found' });
        console.log(docId);
        // send the entire document data as JSON
        return res.json(snap.data());
    } catch (err) {
        console.error('Error fetching sellerProfile:', err);
        return res.status(500).json({ error: 'Internal error' });
    }
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API listening on ${PORT}`));
