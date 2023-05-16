<template>
  <div>
    <template v-if="!hasVideo">
      <div class="text-center">
        <h1 class="text-h3 text-md-h2 font-weight-black text-center mb-5">
          {{ widget.idleText }}
        </h1>
        <v-icon class="arrow-icon" size="128" color="red">
          mdi-arrow-down-bold</v-icon
        >
      </div>
    </template>
    <template v-else>
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
      <v-row>
        <v-col cols="12" class="text-center">
          <h1
            class="text-h3 text-center text-uppercase justify-center align-center"
          >
            {{ widget.idleText }}
          </h1>
          <v-icon class="arrow-icon" size="128" color="red">
            mdi-arrow-down-bold</v-icon
          >
        </v-col></v-row
      >
    </template>
  </div>
</template>

<script>
import { PriceCheckerWidget } from "models";
export default {
  props: {
    styles: {
      type: Object,
      required: false,
    },
    widget: {
      type: PriceCheckerWidget,
      required: true,
    },
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

<style scoped>
.arrow-icon {
  -webkit-animation: action 1s infinite alternate;
  animation: action 1s infinite alternate;
}
@-webkit-keyframes action {
  0% {
    transform: translateY(0);
  }
  100% {
    transform: translateY(-15px);
  }
}
@keyframes action {
  0% {
    transform: translateY(0);
  }
  100% {
    transform: translateY(-15px);
  }
}

.center {
  margin: 0 auto;
  text-align: center;
}
</style>