import { errorsSchema, colorData } from "forms/application_form"

export const schema = function (model, possibleAttachments = []) {
    return {
        db_host: {
            type: "text",
            label: "Host",
            prependIcon: "",
            col: 6,
        },
        db_port: {
            type: "text",
            label: "Porta",
            prependIcon: "",
            col: 6,
        },
        db_user: {
            type: "text",
            label: "Usuário",
            prependIcon: "",
            col: 6,
        },
        db_password: {
            type: "password",
            label: "Senha",
            prependIcon: "",
            col: 6,
        },
        db_name: {
            type: "text",
            label: "Nome do banco",
            prependIcon: "",
            col: 6,
        },
        unit_code: {
            type: "text",
            label: "Código da unidade",
            prependIcon: "",
            col: 6,
        }
    }
}