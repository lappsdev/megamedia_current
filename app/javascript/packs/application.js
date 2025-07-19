
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "../controllers"


import '@mdi/font/css/materialdesignicons.css'
import "@hotwired/turbo-rails"
import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import pt from 'vuetify/es5/locale/pt.js'

import router from '../router'
import store from '../store'
import acl from "../acl"

import ActionCableVue from 'actioncable-vue';
import VueBarcodeScanner from 'vue-barcode-scanner'
import VuetifyToast from 'vuetify-toast-snackbar-ng'

import App from '../app.vue'
import UnitsPage from '../pages/Units.vue'

import VueHotkey from 'v-hotkey'
import VueResizeText from 'vue-resize-text';
import VuetifyDialog from 'vuetify-dialog'
import 'vuetify-dialog/dist/vuetify-dialog.css'
import DatetimePicker from 'vuetify-datetime-picker'

Turbo.session.drive = false
Vue.use(require('vue-moment'));

Vue.use(DatetimePicker)
Vue.use(VueResizeText)
Vue.use(VueHotkey, {
  'plus': 107
})

Vue.component("units-page", UnitsPage)

Vue.component("app", App)
const vuetify = new Vuetify({
  lang: {
    locales: { pt },
    current: 'pt',
  },
})
Vue.component('v-dropzone-input', () => import('components/DropzoneInput.vue'))

Vue.use(Vuetify)

Vue.use(VuetifyDialog, {
  context: {
    vuetify
  }
})
var env = process.env.RAILS_ENV || "development"

Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'error',
  connectionUrl: env == "development" ? 'ws://localhost:5000/cable' : 'wss://app.varejo4tech.paranasuper.com.br/cable', // or function which returns a string with your JWT appended to your server URL as a query parameter
  connectImmediately: true,
});
Vue.use(VueBarcodeScanner)
Vue.use(VuetifyToast, {
  x: 'center', // default
  y: 'bottom', // default
  color: 'info', // default
  timeout: 3000,
  dismissable: true, // default
  showClose: true, // default
  closeText: '', // default
  closeIcon: 'mdi-close', // default
  shorts: {
    error: {
      icon: 'mdi-alert',
      color: 'red'
    },
    success: { icon: 'mdi-check', color: "green" }
  },
})
const app = new Vue({
  vuetify,
  router,
  store,
  el: "#app",
  components: { App }
})

console.log("TESTE")
