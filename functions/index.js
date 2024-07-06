const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { decode } = require('@msgpack/msgpack');
const { Buffer } = require('buffer');

admin.initializeApp();

async function loadTracksFromDatabase(tracksPath) {
    const db = admin.database();
    const ref = db.ref(tracksPath);
    const snapshot = await ref.once('value');
    const base64Data = snapshot.val();

    if (!base64Data) {
        throw new Error('No data found at specified path');
    }

    const buffer = Buffer.from(base64Data, 'base64');
    const tracks = decode(buffer);
    return tracks;
}

async function getPlayerByFrameAndPoint(frameNum, point, tracksPath) {
    const tracks = await loadTracksFromDatabase(tracksPath);

    if (frameNum < 0 || frameNum >= tracks.players.length) {
        return null;
    }

    const [x, y] = point;

    for (const playerId in tracks.players[frameNum]) {
        if (tracks.players[frameNum].hasOwnProperty(playerId)) {
            const track = tracks.players[frameNum][playerId];
            const [x1, y1, x2, y2] = track.bbox;

            if (x1 <= x && x <= x2 && y1 <= y && y <= y2) {
                return track;
            }
        }
    }

    return null;
}

exports.httpMain = functions.https.onRequest(async (req, res) => {
    const { frameNum, point, tracksPath } = req.body;

    if (!frameNum || !point || !tracksPath) {
        res.status(400).send('Missing parameters');
        return;
    }

    try {
        const playerTrack = await getPlayerByFrameAndPoint(frameNum, point, tracksPath);
        res.status(200).send(playerTrack || 'No player found');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error processing request');
    }
});
