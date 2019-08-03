#!/usr/bin/env node
const fs = require('fs');
const sqlite3 = require('sqlite3').verbose();

const sqlitePath = '/Users/mburks/Library/Group\ Containers/group.com.apple.notes/NoteStore.sqlite';
// const sqlitePath = '/Users/mburks/Library/Containers/com.apple.Notes/Data/Library/Notes/NotesV7.storedata';

console.log(sqlitePath);

console.log('sqllite exists?', fs.existsSync(sqlitePath));

const db = new sqlite3.Database(sqlitePath);
db.close();
