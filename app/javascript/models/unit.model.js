import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany } from 'spraypaint'
import { Group } from './group.model'
import { Device } from './device.model'

export const Unit = ApplicationRecord.extend({
    static: {
        jsonapiType: 'units'
    },

    attrs: {
        id: attr(),
        name: attr(),
        notes: attr(),

        flexSettings: attr(),
        wrpdvSettings: attr(),
        group: belongsTo({ type: Group }),
        devices: hasMany({ type: Device })
    },
    methods: {
        toString() {
            return this.name
        }
    }
})