


export const errorsSchema = function (errorAttr) {
    return {
        error: errorAttr != null,
        "error-messages": errorAttr ? [errorAttr.message] : null,
        "error-count": errorAttr ? 1 : null,
    };
}

export const colorData = {
    type: 'color',
    ext: 'text',
    prependIcon: 'palette',
    mode: 'hexa',
    "show-swatches": false,
    "hide-mode-switch": false,
}
