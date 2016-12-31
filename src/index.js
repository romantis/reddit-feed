'use strict';

require('./main.css');


// Require index.html so it gets copied to dist
require('./index.html');
var Elm = require('./Main.elm');

var REDDITS_STORAGE = 'my-reddits';

var storedReddits = localStorage.getItem(REDDITS_STORAGE);
var startingState = storedReddits? JSON.parse(storedReddits) : null;

var mountNode = document.getElementById('main') || document.body;

var app = Elm.Main.embed(mountNode, startingState);

app.ports.setStorage.subscribe(setStorage);


function setStorage(reddits) {
    localStorage.setItem(REDDITS_STORAGE, JSON.stringify(reddits));
}