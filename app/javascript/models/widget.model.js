import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany } from 'spraypaint'
import { Screen } from './screen.model'

export const Widget = ApplicationRecord.extend({
    static: {
        jsonapiType: 'widgets'
    },

    attrs: {
        id: attr(),
        name: attr(),
        description: attr(),
        type: attr({ persist: false }),
        notes: attr(),
        width: attr(),
        height: attr(),
        x: attr(),
        y: attr(),
        data: attr(),
        screen: belongsTo({ type: Screen }),
    },
    methods: {

    }
})