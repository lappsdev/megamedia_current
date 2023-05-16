<template>
  <div
    :style="`width: 100%; height: ${windowHeight}px; max-height: ${windowHeight}px`"
  >
    <v-system-bar dark color="green darken-2">
      <v-icon>mdi-message</v-icon>
      <span>Paraná Supermercados - Bons Momentos</span>
      <v-spacer></v-spacer>
      <span>Conectado </span>
      <v-icon>mdi-wifi-strength-4</v-icon>
    </v-system-bar>
    <grid-layout
      v-if="screen"
      :style="`height: ${windowHeight}px; max-height: ${windowHeight}px`"
      :layout.sync="layout"
      :col-num="12"
      :autoSize="false"
      :is-draggable="false"
      :is-resizable="false"
      :is-mirrored="false"
      :rowHeight="rowHeight"
      :vertical-compact="false"
      :maxRows="12"
      :margin="[0, 0]"
      :use-css-transforms="false"
    >
      <grid-item
        v-for="item in layout"
        :x="item.x"
        :y="item.y"
        :w="item.w"
        :h="item.h"
        :i="item.i"
        :key="item.i"
      >
        <div
          class="grid-item-container"
          :style="`height: ${rowHeight * item.h}px; max-height: ${
            rowHeight * item.h
          }px`"
        >
          <WidgetComponent :instance="item.instance"></WidgetComponent>
        </div>
      </grid-item>
    </grid-layout>
    <h1 v-else>SEM TELA DEFINIDA!</h1>
  </div>
</template>

<script>
import { GridLayout, GridItem } from "vue-grid-layout";
import WidgetComponent from "components/Widgets/Widget";
import { Screen } from "models/screen.model";
import { Credential } from "models/credential.model";

export default {
  props: ["id"],
  components: {
    GridLayout,
    GridItem,
    WidgetComponent,
  },
  data() {
    return {
      screen: null,
      screen_id: null,
      layout: [],
      windowWidth: 0,
      windowHeight: 0,
    };
  },
  methods: {
    getWindowWidth(event) {
      this.windowWidth = document.documentElement.clientWidth;
    },

    getWindowHeight(event) {
      this.windowHeight = document.documentElement.clientHeight - 30;
    },
    loadScreen(id) {
      this.layout = [];
      this.screen = null;
      Screen.includes(["widgets", "widgets.attachment"])
        .find(id)
        .then((response) => {
          this.screen = response.data;
          this.layout = this.screen.widgets.map((e) => ({
            w: e.width,
            h: e.height,
            x: e.x,
            y: e.y,
            i: e.id,
            instance: e,
            static: true,
          }));
        });
    },
  },
  computed: {
    rowHeight() {
      return this.windowHeight / 12;
    },
  },

  created() {
    console.log("Teste");
    if (this.id) {
      this.loadScreen(this.id);
    } else {
      let credential = new Credential();

      credential
        .save({
          returnScope: Credential.includes(["device", { device: "screen" }]),
        })
        .then((success) => {
          if (success) {
            this.loadScreen(credential.device.screen.id);
          }
        });
    }
  },
  mounted() {
    this.$cable.subscribe({
      channel: "ScreenChannel",
      id: this.id,
    });
    this.$nextTick(function () {
      window.addEventListener("resize", this.getWindowWidth);
      window.addEventListener("resize", this.getWindowHeight);

      //Init
      this.getWindowWidth();
      this.getWindowHeight();
    });
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.getWindowWidth);
    window.removeEventListener("resize", this.getWindowHeight);
  },

  channels: {
    ScreenChannel: {
      connected() {
        console.log("CONECTAADO");
      },
      rejected() {},
      received(data) {
        if (data.action == "edit") {
          this.loadScreen();
        }
      },
      disconnected() {},
    },
  },
};
</script>

<style>
</style>