import { SpraypaintBase, MiddlewareStack } from 'spraypaint';
import store from "store"
import router from "router"

var middleware = new MiddlewareStack();
middleware.afterFilters.push(function (response, json) {

  if (response.status === 401) {
    router.push("/login");
    store.commit("LOGOFF")
  }
});

export const ApplicationRecord = SpraypaintBase.extend({
  static: {
    baseUrl: '',
    apiNamespace: '/api/v1',
    jwtStorage: "token",
    sync: true,
    middlewareStack: middleware,
    generateAuthHeader: function (token) {
      console.log("CARALHO" + token)
      return "Bearer " + token;
    },
    $auth: null
  }
  , methods: {
    async getFormSchema() {

      return require(`forms/${this.constructor.jsonapiType.slice(0, -1)}.form.js`).schema(this);
    }
  }
})
