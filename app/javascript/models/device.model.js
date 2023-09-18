import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasOne } from 'spraypaint'
import { Unit } from './unit.model'
import { Screen } from './screen.model'
import { Department } from './department.model'

export const Device = ApplicationRecord.extend({
    static: {
        jsonapiType: 'devices',
        current: () => {
            var user = new User(store.state.currentUser)
            user.isPersisted = true
            return user
        }

    },

    attrs: {
        id: attr(),
        name: attr(),
        mac: attr(),
        ip: attr(),
        notes: attr(),
        unit: belongsTo({ type: Unit }),
        department: belongsTo({ type: Department }),
        departmentId: attr(),
        screen: hasOne({ type: Screen }),
        sshSettings: attr()
    },
    methods: {

    }

})