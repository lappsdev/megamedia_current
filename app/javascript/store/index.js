import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
    state: {
        drawer: null,
        currentScreen: null,
        currentUser: null,
    },
    mutations: {
        TOGGLE_DRAWER(state) {
            state.drawer = !state.drawer
        },
        SET_DRAWER(state, payload) {
            state.drawer = payload
        },
        SET_CURRENT_USER(state, payload) {
            state.currentUser = payload
        },
        SET_CURRENT_SCREEN(state, payload) {
            state.currentScreen = payload
        },

        LOGOFF(state) {
            state.currentUser = null

        }
    },


    getters: {
        currentGroup(state) {
            return state.currentUser.group
        }

    },
    modules: {

    },

    plugins: [createPersistedState()]

})