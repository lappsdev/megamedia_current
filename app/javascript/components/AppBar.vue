<template>
  <v-app-bar
    v-if="currentUser"
    :clipped-right="$vuetify.breakpoint.lgAndUp"
    color="primary"
    dark
    app
  >
    <v-app-bar-nav-icon @click.stop="TOGGLE_DRAWER()"></v-app-bar-nav-icon>
    <v-toolbar-title class="ml-0 pl-4">
      <span class="hidden-sm-and-down">MegaMedia2</span>
    </v-toolbar-title>

    <v-spacer></v-spacer>

    <v-btn color="red" @click="logout">
      <v-icon>mdi-logout</v-icon>
      Sair
    </v-btn>
  </v-app-bar>
</template>

<script>
import { mapState, mapMutations } from "vuex";

export default {
  name: "AppBar",
  computed: {
    ...mapState(["drawer", "currentUser"]),
  },
  methods: {
    ...mapMutations(["TOGGLE_DRAWER", "LOGOFF"]),
    logout() {
      this.LOGOFF();
      this.$toast.success("Até logo!");
      this.$router.push("/login");
    },
  },
};
</script>