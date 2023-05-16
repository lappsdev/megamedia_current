import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany } from 'spraypaint'
import { Group } from './group.model'
import { Device } from './device.model'
import { Widget } from './widget.model'
import { ImageWidget } from './image_widget.model'
import { PriceCheckerWidget } from './price_checker_widget.model'

export const Scheduler = ApplicationRecord.extend({
    static: {
        jsonapiType: 'schedulers'
    },

    attrs: {
        id: attr(),
        startedAt: attr(),
        finishedAt: attr(),
        schedulable: belongsTo(),
    },
    methods: {

    }
})