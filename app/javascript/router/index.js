import Vue from 'vue'
import VueRouter from 'vue-router'


import Admin from 'layouts/Admin'
import Device from 'layouts/Device'
import Login from 'pages/Login'

import Dashboard from 'pages/Dashboard'
import Units from 'pages/Units'
import Devices from 'pages/Devices'
import DeviceScreen from 'pages/DeviceScreen'

import Screens from 'pages/Screens'
import Users from 'pages/Users'
import ScreenEdit from 'pages/ScreenEdit'
import Attachments from 'pages/Attachments'
import Attachment from 'pages/Attachment'
import Unit from 'pages/Unit'

Vue.use(VueRouter)

export default new VueRouter({
    routes: [
        { path: "/", redirect: "/login" },
        {
            path: '/login',
            name: 'login',
            component: Login,
            meta: {
                role: 'guest',
                fail: '/admin/dashboard'
            }
        },
        {
            path: "/admin", component: Admin, children: [

                {
                    path: 'dashboard',
                    name: 'dashboard',
                    component: Dashboard
                },
                {
                    path: 'units',
                    name: 'units',
                    component: Units,
                },
                {
                    path: 'unit/:id',
                    name: 'unit',
                    component: Unit,
                    props: true,

                },
                {
                    path: 'devices',
                    name: 'devices',
                    component: Devices,
                }, {
                    path: 'screens',
                    name: 'screens',
                    component: Screens,
                }, {
                    path: 'screenEdit/:id',
                    name: 'screenEdit',
                    props: true,
                    component: ScreenEdit,
                }, {
                    path: 'users',
                    name: 'users',
                    component: Users,
                }, {
                    path: 'attachments',
                    name: 'attachments',
                    component: Attachments,
                },
                {
                    path: 'attachment/:id',
                    name: 'attachment',
                    component: Attachment,
                    props: true,

                },

            ],
            meta: {
                role: 'logged',
                fail: '/login'
            }
        }, {
            path: '/device', component: Device, children: [
                { path: "screen/:id", component: DeviceScreen, props: true },
                { path: "screen", component: DeviceScreen }

            ]
        }
    ]
})
