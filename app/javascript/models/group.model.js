import { ApplicationRecord } from './application_record';
import { attr, hasMany } from 'spraypaint'
import store from 'store'
export const Group = ApplicationRecord.extend({
    static: {
        jsonapiType: 'groups',
        current: () => {
            var group = new Group(store.getters.currentGroup)
            group.isPersisted = true
            return group
        }
    },

    attrs: {
        id: attr(),
        name: attr(),
        units: hasMany(),
        users: hasMany()

    },
    methods: {

    }
})
