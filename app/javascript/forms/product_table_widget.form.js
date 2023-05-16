import { errorsSchema } from "forms/application_form"

export const schema = function (model) {
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
        productCodes: {
            type: "combobox",
            label: "Código dos produtos",
            multiple: true,
            smallChips: true,
            hideSelected: true,
            prependIcon: "",
            ...errorsSchema(model.errors.product_codes),
        },

    };
};

