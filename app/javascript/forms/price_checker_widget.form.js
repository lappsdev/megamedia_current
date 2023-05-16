import { errorsSchema, colorData } from "forms/application_form"
import { schema as flexSettingsSchema } from "forms/flex_settings.form"
export const schema = function (model, possibleAttachments = []) {
    return {
        name: {
            type: "text",
            label: "Nome",
            prependIcon: "",
            ...errorsSchema(model.errors.name),
        },
        description: {
            type: "text",
            label: "Descrição",
            prependIcon: "",
            ...errorsSchema(model.errors.description),
        },

        idleText: {
            type: "text",
            prependIcon: "",
            label: 'Texto de espera',
        },

        flexSettings: flexSettingsSchema

    }


};


