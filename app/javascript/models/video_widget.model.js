import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Screen } from './screen.model'
import { Widget } from './widget.model'
import { Media } from './media.model'
import { Attachment } from './attachment.model'
import { schema } from 'forms/video_widget.form.js'
import { Scheduler } from './scheduler.model';

export const VideoWidget = Widget.extend({
    static: {
        jsonapiType: 'video_widgets'
    },

    attrs: {
        media: hasOne({ type: Media }),
        attachment: hasOne({ type: Attachment }),
        scheduler: hasOne({ type: Scheduler }),

    },
    methods: {
        async getFormSchema() {
            let attachments = (await Attachment.where({ attachType: "video" }).all()).data
            return schema(this, attachments)
        }
    }
})
