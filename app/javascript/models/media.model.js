import { ApplicationRecord } from './application_record';
import { attr, belongsTo } from 'spraypaint'
import { Attachment } from './attachment.model'
import { ImageWidget } from './image_widget.model'

export const Media = ApplicationRecord.extend({
    static: {
        jsonapiType: 'medias'
    },

    attrs: {
        id: attr(),
        attachment: belongsTo({ type: Attachment }),
        attachable: belongsTo([{ type: ImageWidget }])

    },
    methods: {

    }
})