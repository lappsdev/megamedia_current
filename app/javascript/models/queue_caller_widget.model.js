import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Screen } from './screen.model'
import { Widget } from './widget.model'
import { Media } from './media.model'
import { Attachment } from './attachment.model'
import { schema } from 'forms/queue_caller_widget.form'

export const QueueCallerWidget = Widget.extend({
    static: {
        jsonapiType: 'queue_caller_widgets'
    },

    attrs: {
        media: hasOne({ type: Media }),
        attachment: hasOne({ type: Attachment }),
        queue: attr(),
        pdvsToCheck: attr(),
        sambaSettings: attr()
    },
    methods: {
        async getFormSchema() {
            let attachments = (await Attachment.where({ attachType: "video" }).all()).data
            return schema(this, attachments)
        }
    }
})
