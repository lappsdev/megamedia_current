import { ApplicationRecord } from './application_record';
import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'

export const Product = ApplicationRecord.extend({
    static: {
        jsonapiType: 'products'
    },

    attrs: {
        description: attr(),
        price: attr(),
        promotionalPrice: attr(),
        fatorPromotionalPrice: attr(),
        fatorPromotional: attr(),
        barcode: attr(),
        balanceCode: attr()
    },
    methods: {

    }
})
