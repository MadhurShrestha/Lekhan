// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery_ujs
//= require algolia/algoliasearch.min
//= require local-time

import "bootstrap";
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../stylesheets/application"

window.Noty = require('noty');


Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")
require("jquery")
import "./quill-editor.js"

document.addEventListener('turbolinks:load', () => {
  document.addEventListener('click', () => {
    let element = event.target.closest('.text-content')
    if (!element) return;

    element.classList.add('d-none')
    element.nextElementSibling.classList.remove('d-none')
  })

  document.addEventListener('click', () => {
    if (!event.target.matches('.cancel')) return;

    event.preventDefault();

    let element = event.target.closest('.form-content')

    element.classList.add('d-none')
    element.previousElementSibling.classList.remove('d-none')
  })
  $(document).ready(function () {
    if(notebook_id){
     $("#notebook-" + notebook_id).collapse('show')
    }
  })
})

import "controllers"

let heartBeatActivated = false;
class HeartBeat {
  constructor() {
    document.addEventListener('DOMContentLoaded', () => {
      this.initHeartBeat();
    });
  }

  initHeartBeat() {
    this.lastActive = new Date().valueOf();
    if (!heartBeatActivated) {
      ['mousemove', 'scroll', 'click', 'keydown'].forEach((activity) => {
        document.addEventListener(activity, (ev) => {
          this.lastActive = ev.timeStamp + performance.timing.navigationStart;
        }, false);
      });
      heartBeatActivated = true;
    }
  }
}

window.heartBeat = new HeartBeat();

const sessionTimeoutPollFrequency = 600;
function pollForSessionTimeout() {
  if ((Date.now() - window.heartBeat.lastActive) < (sessionTimeoutPollFrequency * 1000)) {
    // HERE
    setTimeout(pollForSessionTimeout, (sessionTimeoutPollFrequency * 1000));
    return;
  }

  let request = new XMLHttpRequest();
  request.onload = function (event) {
    var status = event.target.status;
    var response = event.target.response;

    // if the remaining valid time for the current user session is less than or equals to 0 seconds.
    if (status === 200 && (response <= 0)) {
      window.location.href = '/session_timeout';
    }
  };
  request.open('GET', '/check_session_timeout', true);
  request.responseType = 'json';
  request.send();
  setTimeout(pollForSessionTimeout, (sessionTimeoutPollFrequency * 1000));
}

// HERE
setTimeout(pollForSessionTimeout, (sessionTimeoutPollFrequency * 1000));
