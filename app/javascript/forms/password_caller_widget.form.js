import { Attachment } from "models/attachment.model"
import { errorsSchema, colorData } from "forms/application_form"

export const schema = function (model) {
    return {
        name: {
            type: "text",
            label: "Nome",
            prependIcon: "",
            ...errorsSchema(model.errors.name),
        },

    };
};

