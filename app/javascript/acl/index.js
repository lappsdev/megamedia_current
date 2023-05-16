import Vue from 'vue'
import Acl from 'vue-browser-acl'
import store from "store"
import router from "router"
import { User } from "models"
const user = () => {
    return User.current()
}
Vue.use(Acl, user, (acl) => {
    acl.rule("guest", (user) => user == null)
    acl.rule("logged", (user) => user != null)

    acl.rule("admin", (user) => user.role == "admin")
    acl.rule("marketing", (user) => user.role == "marketing")

}, { router })