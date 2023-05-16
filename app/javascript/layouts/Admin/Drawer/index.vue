<template>
  <v-navigation-drawer
    id="default-drawer"
    v-model="drawer"
    :dark="dark"
    :right="$vuetify.rtl"
    :mini-variant.sync="mini"
    mini-variant-width="80"
    app
    width="260"
  >
    <template v-if="drawerImage" #img="props">
      <v-img :key="image" :gradient="gradient" v-bind="props" />
    </template>

    <div class="px-2">
      <default-drawer-header />

      <v-divider class="mx-3 mb-2" />

      <default-list :items="items" />
    </div>

    <template #append>
      <div class="pa-4 text-center">
        <app-btn
          class="text-none mb-4"
          color="white"
          href="https://vuetifyjs.com"
          small
          text
        >
          Documentation
        </app-btn>

        <app-btn
          block
          class="text-none"
          color="secondary"
          href="https://store.vuetifyjs.com/products/vuetify-material-dashboard-pro"
        >
          <v-icon left> mdi-package-up </v-icon>

          Upgrade to Pro
        </app-btn>
      </div>
    </template>

    <div class="pt-12" />
  </v-navigation-drawer>
</template>

<script>
// Utilities

export default {
  name: "DefaultDrawer",
  data() {
    return {
      mini: false, //
      dark: false,
    };
  },
  components: {
    DefaultDrawerHeader: () => import("./Header"),
    DefaultList: () => import("./List"),
  },

  computed: {},
};
</script>

