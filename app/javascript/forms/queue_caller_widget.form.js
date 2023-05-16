import { Attachment } from "models/attachment.model"
import { errorsSchema, colorData } from "forms/application_form"

export const schema = function (model, possibleAttachments = []) {
    return {

        name: {
            type: "text",
            label: "Nome",
            prependIcon: "",
            ...errorsSchema(model.errors.name),
        },
        attachment: {
            type: "select",
            label: "Video a ser exibido em stand by",
            prependIcon: "",
            itemText: "name",
            itemValue: "id",
            returnObject: true,
            items: possibleAttachments,
            clearable: true
        },


        description: {
            type: "text",
            label: "Descrição",
            prependIcon: "",
            ...errorsSchema(model.errors.description),
        },
        pdvsToCheck: {
            type: "combobox",
            label: "PDVS",
            multiple: true,
            smallChips: true,
            hideSelected: true,
            prependIcon: "",
            ...errorsSchema(model.errors.pdvsToCheck),
        },
        sambaSettings: {
            type: "group",
            label: "Configurações SAMBA",
            row: { dense: true },
            class: "title pb-2",
            schema: {
                domain: {
                    type: "text",
                    label: "Domínio",
                    prependIcon: "",
                    col: 6,
                },
                host: {
                    type: "text",
                    label: "Host",
                    prependIcon: "",
                    col: 6,
                },
                share: {
                    type: "text",
                    label: "Share",
                    prependIcon: "",
                    col: 6,
                },
                user: {
                    type: "text",
                    label: "Usuário",
                    prependIcon: "",
                    col: 6,
                },
                password: {
                    type: "password",
                    label: "Senha",
                    prependIcon: "",
                    col: 6,
                },
                port: {
                    type: "number",
                    label: "Porta",
                    prependIcon: "",
                    col: 6,
                }, path_to_cd: {
                    type: "text",
                    label: "Caminho p/ cd",
                    prependIcon: "",
                    col: 6,
                },
            },
        },

    };
};

