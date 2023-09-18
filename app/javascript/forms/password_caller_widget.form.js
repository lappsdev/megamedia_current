import { Attachment } from "models/attachment.model"
import { errorsSchema, colorData } from "forms/application_form"

export const schema = function (model, possibleDepartments) {
    return {
        name: {
            type: "text",
            label: "Nome",
            prependIcon: "",
            ...errorsSchema(model.errors.name),
        },
        department: {
            type: "select",
            label: "Selecione o departamento",
            prependIcon: "",
            itemText: "name",
            itemValue: "id",
            returnObject: true,
            items: possibleDepartments,
            clearable: true
        },
    };
};

