<template>
  <div class="waitContainer">
    <template v-if="!hasVideo">
      <h1 class="text-h1 text-center waitText justify-center align-center">
        Nenhum caixa livre, aguarde ser chamado
      </h1>
    </template>
    <template v-else>
      <v-row>
        <v-col cols="12">
          <marquee scrolldelay="60" scrollamount="12">
            <h1
              class="text-h3 text-center waitText justify-center align-center"
            >
              Nenhum caixa livre, aguarde ser chamado
            </h1>
          </marquee>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12">
          <v-card height="100%">
            <v-card-text>
              <div :style="`width: 100%; height: ${videoHeight}px`">
                <video
                  style="
                    background: black;
                    object-fit: fill;
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    max-height: 100%;
                  "
                  muted="muted"
                  autobuffer="autobuffer"
                  autoplay="autoplay"
                  loop="loop"
                >
                  <source :src="file" type="video/mp4" />
                </video></div
            ></v-card-text> </v-card
        ></v-col>
      </v-row>
      <v-row> </v-row>
    </template>
  </div>
</template>

<script>
import { QueueCallerWidget } from "models/queue_caller_widget.model";

export default {
  props: {
    widget: { required: true, type: QueueCallerWidget },
  },

  computed: {
    hasVideo() {
      return !(this.widget.attachment == null);
    },
    file() {
      return this.widget.attachment.file;
    },
    videoHeight() {
      return document.documentElement.clientHeight * 0.75;
    },
  },
};
</script>

<style>
.waitContainer .waitText {
  font-size: 18vmin;
  color: #ffffff;
  font-weight: bolder;
  text-transform: uppercase;
}
.waitContainer {
  color: #ffffff;
}
</style>