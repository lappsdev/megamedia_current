import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Screen } from './screen.model'
import { Widget } from './widget.model'
import { Media } from './media.model'
import { Attachment } from './attachment.model'
import { schema } from 'forms/image_widget.form.js'

export const ImageWidget = Widget.extend({
    static: {
        jsonapiType: 'image_widgets'
    },

    attrs: {
        media: hasOne({ type: Media }),
        attachment: hasOne({ type: Attachment }),

    },
    methods: {
        async getFormSchema() {
            let attachments = (await Attachment.where({ attachType: "image" }).all()).data
            return schema(this, attachments)
        }
    }
})
