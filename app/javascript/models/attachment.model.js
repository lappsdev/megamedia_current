import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Media } from './media.model'
import { Group } from './group.model'
import { ImageWidget } from './image_widget.model'
import { Scheduler } from './scheduler.model';

export const Attachment = ApplicationRecord.extend({
    static: {
        jsonapiType: 'attachments'
    },

    attrs: {
        id: attr(),
        file: attr(),
        attachType: attr(),
        name: attr(),
        description: attr(),
        expiredAt: attr(),
        expired: attr(),
        medias: hasMany({ type: Media }),

        group: belongsTo({ type: Group }),
        scheduler: hasOne({ type: Scheduler }),

    },
    methods: {

    }
})