import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasOne } from 'spraypaint'
import { Unit } from './unit.model'
import { Screen } from './screen.model'

export const Department = ApplicationRecord.extend({
    static: {
        jsonapiType: 'departments',

    },

    attrs: {
        id: attr(),
        name: attr(),
        unit: belongsTo({ type: Unit }),
        queueIndex: attr()
    },
    methods: {
        toString() {
            return this.name
        }
    }

})