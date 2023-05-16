import { ApplicationRecord } from './application_record';
import { attr, belongsTo } from 'spraypaint'
import { User } from './user.model'
import { Device } from './device.model'

export const Credential = ApplicationRecord.extend({
    static: {
        jsonapiType: 'credentials'
    },

    attrs: {
        login: attr(),
        password: attr(),
        jsonWebToken: attr(),
        user: belongsTo({ type: User }),
        device: belongsTo({ type: Device })

    },
    methods: {

    }
})