import { attr, belongsTo, hasMany, hasOne } from 'spraypaint'
import { Widget } from './widget.model'
import { schema } from 'forms/password_caller_widget.form.js'
import { Department } from './department.model'

export const PasswordCallerWidget = Widget.extend({
    static: {
        jsonapiType: 'password_caller_widgets'
    },

    attrs: {
        flexSettings: attr(),
        department: belongsTo({ type: Department }),
        departmentId: attr()
    },
    methods: {
        async getFormSchema() {
            if (this.screen && this.screen.device && this.screen.device.departmentId) {
                let departments = (await Department.where({ id: this.screen.device.departmentId }).all()).data
                return schema(this, departments)

            } else {
                let departments = (await Department.where({ unitId: this.screen.device.unitId }).all()).data
                return schema(this, departments)

            }
        }
    }

})
