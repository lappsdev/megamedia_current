import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Widget } from './widget.model'
import { Product } from './product.model'
import { Attachment } from './attachment.model'
import { schema } from 'forms/price_checker_widget.form'

export const PriceCheckerWidget = Widget.extend({
    static: {
        jsonapiType: 'price_checker_widgets'
    },

    attrs: {
        flexSettings: attr(),
        idleText: attr(),
        attachment: hasOne({ type: Attachment }),

    },
    methods: {

        async scan(barcode) {
            let product = (await Product.where({ barcode: barcode, requesterId: this.id, requesterType: "PriceCheckerWidget" })
                .find()).data
            if (product == null) {
                return new Error()
            }
            return product;
        },
        async getFormSchema() {
            let attachments = (await Attachment.where({ attachType: "video" }).all()).data
            return schema(this, attachments)
        }
    }
})
