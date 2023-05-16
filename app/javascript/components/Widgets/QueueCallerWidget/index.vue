<template>
  <v-row class="fill-height justify-center align-center red accent-4">
    <v-col cols="12"
      ><component
        :is="currentComponent"
        :pdvCall="currentPdvCall"
        :widget="widget"
      ></component
    ></v-col>
  </v-row>
</template>
<script>
import { QueueCallerWidget } from "models/queue_caller_widget.model";
import Idle from "./Idle";
import PdvCall from "./PdvCall";
export default {
  props: {
    widget: { type: QueueCallerWidget, required: true },
    running: { type: Boolean, default: true },
  },
  data() {
    return {
      queue: [],
      refreshModel: null,
      requesting: false,
    };
  },
  created() {
    if (this.running) {
      this.refreshModel = setInterval(() => {
        if (this.queue.length == 0) {
          if (!this.requesting) {
            this.findWithQueue();
          }
        }
      }, 1000);

      setTimeout(() => {
        window.location.reload();
      }, 1 * 60 * 60 * 1000);
    }
  },
  watch: {
    queue: function (newQueue, oldQueue) {
      this.executeSound(newQueue[0].number);
      setTimeout(() => {
        this.$delete(this.queue, 0); // delete first
      }, 3 * 1000);
    },
  },
  computed: {
    currentComponent() {
      if (this.queue.length == 0) {
        return Idle;
      } else {
        return PdvCall;
      }
    },
    currentPdvCall() {
      return this.queue[0];
    },
  },
  methods: {
    findWithQueue() {
      this.requesting = true;
      QueueCallerWidget.selectExtra(["queue"])
        .find(this.widget.id)
        .then((response) => {
          if (this.widget.queue.length > 0) {
            this.queue = this.widget.queue;
          }
        })
        .finally(() => {
          this.requesting = false;
        });
    },

    executeSound(pdv) {
      let mp3_file = ("000" + parseInt(pdv)).substr(-3) + ".mp3";
      let file = require(`sounds/${mp3_file}`);
      let audio = new Audio(file);
      audio.play();
    },
  },
  destroyed() {
    clearInterval(this.refreshModel);
  },
};
</script>

<style scoped>
</style>