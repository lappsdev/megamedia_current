import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Widget } from './widget.model'
import { schema } from 'forms/product_table_widget.form.js'

export const PasswordCallerWidget = Widget.extend({
    static: {
        jsonapiType: 'password_caller_widgets'
    },

    attrs: {
        flexSettings: attr(),

    },
    methods: {

    }

})
