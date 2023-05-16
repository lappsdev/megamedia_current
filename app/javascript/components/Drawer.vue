<template>
  <v-navigation-drawer v-if="currentUser" v-model="drawer" app>
    <v-sheet class="pa-4">
      <v-avatar class="mb-4" color="grey darken-1" size="64">
        <span class="white--text headline">{{ currentUser.name[0] }}</span>
      </v-avatar>

      <div>{{ currentUser.name }}</div>
    </v-sheet>

    <v-divider></v-divider>

    <v-list>
      <v-list-item
        v-for="item in items"
        v-can="[item.role]"
        :key="item.text"
        link
        :to="item.to"
      >
        <v-list-item-icon>
          <v-icon color="primary">{{ item.icon }}</v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{ item.text }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapState } from "vuex";
export default {
  name: "Drawer",
  data: () => ({
    items: [
      {
        icon: "mdi-view-dashboard",
        text: "Dashboard",
        to: "/admin/dashboard",
        role: "logged",
      },
      {
        icon: "mdi-bank",
        text: "Unidades",
        to: "/admin/units",
        role: "admin",
      },
      {
        icon: "mdi-devices",
        text: "Equipamentos",
        to: "/admin/devices",
        role: "logged",
      },
      {
        icon: "mdi-monitor",
        text: "Telas",
        to: "/admin/screens",
        role: "logged",
      },
      {
        icon: "mdi-animation-play",
        text: "Mídias",
        to: "/admin/attachments",
        role: "logged",
      },
      {
        icon: "mdi-account-group",
        text: "Usuários",
        to: "/admin/users",
        role: "admin",
      },
    ],
  }),
  computed: {
    ...mapState(["currentUser"]),
    drawer: {
      set(data) {
        this.$store.commit("SET_DRAWER", data);
      },
      get() {
        return this.$store.state.drawer;
      },
    },
  },
};
</script>