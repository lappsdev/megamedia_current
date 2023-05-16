import { Attachment } from "models/attachment.model"

export const schema = function (model, possibleAttachments) {
    return {
        attachment: {
            type: "select",
            label: "Video a ser exibido",
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
            ...errorsSchema(model.errors.description)
        },

    };
}

function errorsSchema(errorAttr) {
    return {
        error: errorAttr != null,
        "error-messages": errorAttr ? [errorAttr.message] : null,
        "error-count": errorAttr ? 1 : null,
    };
}