import { Attachment } from "models/attachment.model"
import { errorsSchema, colorData } from "forms/application_form"

export const schema = function (model, possibleAttachments) {

    return {
        attachment: {
            type: "select",
            label: "Imagem a ser exibida",
            prependIcon: "",
            itemText: "name",
            key: "id",
            returnObject: true,
            items: possibleAttachments,
        },

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

    };
}
