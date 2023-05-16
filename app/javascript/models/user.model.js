import { ApplicationRecord } from './application_record';
import { attr, belongsTo } from 'spraypaint'
import { Group } from './group.model'
import store from "store"
export const User = ApplicationRecord.extend({
    static: {
        jsonapiType: 'users',
        current: () => {
            if (store.state.currentUser) {
                var user = new User(store.state.currentUser)
                user.isPersisted = true
                return user
            } else {
                return null
            }
        }

    },

    attrs: {
        id: attr(),
        name: attr(),
        login: attr(),
        password: attr(),
        role: attr(),
        group: belongsTo({ type: Group })
    },
    methods: {
        roleText() {
            return this.role == "admin" ? "Administrador" : "Marketing";
        }
    }

})