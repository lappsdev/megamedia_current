import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany } from 'spraypaint'
import { Group } from './group.model'
import { Device } from './device.model'
import { Widget } from './widget.model'
import { ImageWidget } from './image_widget.model'
import { PriceCheckerWidget } from './price_checker_widget.model'

export const Screen = ApplicationRecord.extend({
    static: {
        jsonapiType: 'screens'
    },

    attrs: {
        id: attr(),
        name: attr(),
        widgets: hasMany({ type: Widget }),
        group: belongsTo({ type: Group }),
        device: belongsTo({ type: Device })
    },
    methods: {

    }
})