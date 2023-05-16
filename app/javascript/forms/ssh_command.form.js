import { errorsSchema } from "forms/application_form"

export const schema = function (model) {
    return {
        command: {
            type: "text",
            label: "Comando",
            prependIcon: "",
            ...errorsSchema(model.errors.command),
        }
    };
};

