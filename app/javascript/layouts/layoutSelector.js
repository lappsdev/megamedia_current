import Admin from './Admin'
import Guest from './Guest'
import Device from './Device'

import { store } from "src/store"

// collect comonents in a object since we can't use local registration in a functional component.
const components = {
    Admin,
    Guest,
    Device
}
export default {
    functional: true,
    props: ['currentUser'],
    render(h, ctx) {
        if (store.state.currentUser == null && store.state.currentScreen == null) {
            return h(components["Guest"], ctx.data, ctx.children)
        } else if (store.state.currentUser) {
            return h(components["Admin"], ctx.data, ctx.children)

        } else if (store.state.currentScreen) {
            return h(components["Device"], ctx.data, ctx.children)

        }


    }
}
