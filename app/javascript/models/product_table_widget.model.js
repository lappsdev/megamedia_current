import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Widget } from './widget.model'
import { Product } from './product.model'

export const ProductTableWidget = Widget.extend({
    static: {
        jsonapiType: 'product_table_widgets'
    },

    attrs: {
        productCodes: attr(),
    },
    methods: {

        async products() {
            let products = (await Product.where({ requesterId: this.id, requesterType: "ProductTableWidget" }).all()).data
            if (!products) {
                return new Error()
            }
            console.log(products)
            return products;
        }
    }
})
